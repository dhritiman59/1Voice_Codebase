import 'package:bring2book/Models/CaseDetails/CaseDetailsModel.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Models/AddCaseModel/AddCaseModel.dart';
import 'package:bring2book/Models/StateListModel/StateListModel.dart';
import 'package:bring2book/Models/LoginUserModel/LoginUserBean.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:bring2book/Models/EditCaseModel/EditCaseModel.dart';
import 'package:bring2book/Models/StatusMessageModel/StatusMessageModel.dart';




class EditCaseBloc {
  final repository = Repository();
  final caseDetails = PublishSubject<EditCaseModel>();
  Stream<EditCaseModel> get details => caseDetails.stream;



  Future<EditCaseModel> getCaseDetails(String caseId) async {


    EditCaseModel model = await repository.getEditCaseDetails(caseId);
    caseDetails.sink.add(model);

    print(model);
  }




  final editCaseResponse = PublishSubject<StatusMessageModel>();
  Stream<StatusMessageModel> get editCaseStream => editCaseResponse.stream;

  Future<StatusMessageModel> updateEditMyCase( String caseId,String caseTitle, String caseDescription, String caseTypeFlag, String caseCategory,String filterCountry,String filterState) async
  {
    final parameter = {
      'caseTitle':caseTitle,
      'caseDescription':caseDescription,
      'caseTypeFlag':caseTypeFlag,
      'caseCategory':caseCategory,
      'country':filterCountry,
      'state':filterState,
    };
    print(parameter);
    StatusMessageModel editCaseApiResp = await repository.updateEditMyCase(parameter,caseId);
    if (editCaseApiResp != null) {
      editCaseResponse.sink.add(editCaseApiResp);
    }
    print("MariaMol");
    print(editCaseApiResp);
  }




  final deleteCaseResponse = PublishSubject<StatusMessageModel>();
  Stream<StatusMessageModel> get deleteCaseStream => deleteCaseResponse.stream;

  Future<StatusMessageModel> deleteEditCaseDocs(String imageid) async
  {

    StatusMessageModel deleteCaseApiResp = await repository.deleteEditCaseDocs(imageid);
    if (deleteCaseApiResp != null) {
      deleteCaseResponse.sink.add(deleteCaseApiResp);
    }
    print("MariaMol");
    print(deleteCaseApiResp);
  }


  final uploadCaseResponse = PublishSubject<StatusMessageModel>();
  Stream<StatusMessageModel> get uploadCaseStream => uploadCaseResponse.stream;

  Future<StatusMessageModel> uploadEditCaseDocs( String caseId,   List file,) async
  {
    final parameter = {
      'caseId':caseId,
    };
    print(file);
    print(parameter);
    StatusMessageModel uploadCaseApiResp = await repository.uploadEditCaseDocs(parameter, file);
    if (uploadCaseApiResp != null) {
      uploadCaseResponse.sink.add(uploadCaseApiResp);
    }
    print("MariaMol");
    print(uploadCaseApiResp);
  }


  void dispose() {
    uploadCaseResponse.close();
    deleteCaseResponse.close();
    editCaseResponse.close();
    caseDetails.close();

  }


}