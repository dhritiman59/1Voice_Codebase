import 'package:bring2book/Models/CaseDonationModel/CaseDonationModel.dart';
import 'package:bring2book/Models/GeneralDonation/GeneralDonationModel.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class DonationBloc{
  final repository = Repository();
  final caseDonation = PublishSubject<CaseDonationModel>();
  final generalDonation = PublishSubject<GeneralDonationModel>();
  Stream<CaseDonationModel> get caseDonationStream => caseDonation.stream;
  Stream<GeneralDonationModel> get generationDonationStream => generalDonation.stream;
  Future<CaseDonationModel> caseDonationApi(String caseId,String amount) async {
    final parameter = {
      'caseId': caseId,
      'amount': amount,
    };

    CaseDonationModel caseDonationModel =
    await repository.caseDonation(parameter);
    if (caseDonationModel != null) {
      caseDonation.sink.add(caseDonationModel);
    }
    print("Maria");
    print(caseDonation);
  }

  Future<GeneralDonationModel> postGeneralDonation(String amount) async {
    final parameter = {
      'amount': amount,

    };

    GeneralDonationModel generalDonationModel =
    await repository.generalDonation(parameter);
    if (generalDonationModel != null) {
      generalDonation.sink.add(generalDonationModel);
    }
    print("Maria");
    print(generalDonationModel);
  }
}