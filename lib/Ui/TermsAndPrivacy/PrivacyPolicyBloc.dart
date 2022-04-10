import 'dart:async';

import 'package:bring2book/Models/PlatFormTermsModel/PlatFormsTermsModel.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class PrivacyPolicyBloc{
  final repository = Repository();

  final platformTerms = PublishSubject<PlatFormTermsModel>();

  Stream<PlatFormTermsModel> get termsAndPolicy => platformTerms.stream;


  StreamController validateTermsController = StreamController<String>();
  Stream<String> get validateTermsStream => validateTermsController.stream;
  StreamSink<String> get validateTermsSink => validateTermsController.sink;
  void getPlatFormTerms() {
    getTerms();

  }
  Future <PlatFormTermsModel> getTerms() async {

    PlatFormTermsModel formTermsModel = await repository.getTerms1();
    if (PlatFormTermsModel != null) {
      platformTerms.sink.add(formTermsModel);
    }


    print(PlatFormTermsModel);
  }
}