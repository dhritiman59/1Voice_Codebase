import 'package:bring2book/Models/AddCardModel/AddCardModel.dart';
import 'package:bring2book/Models/CardListModel/CardListModel.dart';
import 'package:bring2book/Models/CaseDonationModel/CaseDonationModel.dart';
import 'package:bring2book/Models/DeleteCardModel/DeleteCardModel.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CardListBloc{
  var fourDigitsYear;
  int month,year;
  final repository = Repository();
  final cardList = PublishSubject<CardListModel>();
  final addCard = PublishSubject<AddCardModel>();
  final deleteCard = PublishSubject<DeleteCardtModel>();
  Stream<CardListModel> get cardListStream => cardList.stream;
  Stream<AddCardModel> get addCardStream => addCard.stream;
  Stream<DeleteCardtModel> get deleteCardStream => deleteCard.stream;
  Future<AddCardModel> addCardApi(String cardNo,String cvc,String expMnth, String expYr) async {
    final parameter = {
      "cardNo":cardNo,
      "cvc":cvc,
      "expMnth":expMnth,
      "expYr":expYr
    };
    AddCardModel model =
    await repository.addCard(parameter);
    if (model != null) {
      addCard.sink.add(model);
    }


  }

  Future<DeleteCardtModel> deleteCardFromList(String id) async {
    final parameter = {
      "cardId":id,
    };

    DeleteCardtModel deleteCardtModel =
    await repository.deleteCard(parameter);
    if (deleteCardtModel != null) {
      deleteCard.sink.add(deleteCardtModel);
    }
    print(deleteCardtModel);
  }

  Future<CardListModel> getCardList( ) async {
    final parameter = {
      'page':'0',
    };

    CardListModel model =
    await repository.getCardList(parameter);
    if (model != null) {
      cardList.sink.add(model);
    }
    print(model);
  }



}