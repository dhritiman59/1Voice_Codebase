import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Models/AddCaseModel/AddCaseModel.dart';
import 'package:bring2book/Models/StateListModel/StateListModel.dart';
import 'package:bring2book/Models/LoginUserModel/LoginUserBean.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:bring2book/Models/CountryListModel/CountryListModel.dart';


import 'package:shared_preferences/shared_preferences.dart';

class AddCaseBloc {

  final repository = Repository();



  final addCaseResponse = PublishSubject<AddCaseModel>();
  Stream<AddCaseModel> get addCaseStream => addCaseResponse.stream;

  Future<AddCaseModel> updateDocuments( String caseTitle, String caseDescription, String caseTypeFlag,
      List file, String caseCategory,String filterCountry,String filterState) async
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
    print(file);
    AddCaseModel addCaseApiResp = await repository.updateDocuments(parameter, file,);
    if (addCaseApiResp != null) {
      addCaseResponse.sink.add(addCaseApiResp);
    }
    print("MariaMol");
    print(addCaseApiResp);
  }



  final stateListResponse = BehaviorSubject<StateListModel>();
  Stream<StateListModel> get stateListStream => stateListResponse.stream;

  bool paginationLoading = false;
  StateListModel PaginationstateListResponse;

  Future StateListAPI({String page, String searchTitle, String countryId}) async {
    paginationLoading = true;

    Map<String, String> queryParams = {
      'page': page,
      'search': searchTitle
    };

    print('Maria$queryParams');
    paginationLoading = true;
    StateListModel responseStateList = await repository.StateListAPI(queryParams,countryId);

    if (responseStateList != null) {
      if (responseStateList.status == 'error') {
        stateListResponse.sink.add(responseStateList);
      } else {
        if (responseStateList.data.currentPage > 0) {
          if (PaginationstateListResponse.data.data != null) {
            PaginationstateListResponse.data.data.addAll(responseStateList.data.data);
            print('Minnu');
          }

          PaginationstateListResponse.data.currentPage = responseStateList.data.currentPage;
          PaginationstateListResponse.data.totalPages = responseStateList.data.totalPages; //to pagination page change
          stateListResponse.sink.add(PaginationstateListResponse);
          print('MinnuMaria');
        } else {
          PaginationstateListResponse = responseStateList;
          stateListResponse.sink.add(responseStateList); // jsonEncode != .toString()
          print('MinnuMariaKurian');
        }
      }
    }

    paginationLoading = false;
  }






  final countryListResponse = BehaviorSubject<CountryListModel>();
  Stream<CountryListModel> get countryListStream => countryListResponse.stream;

  CountryListModel PaginationcountryListResponse;

  Future CountryListAPI({String page, String searchTitle}) async {
    paginationLoading = true;

    Map<String, String> queryParams = {
      'page': page,
      'search': searchTitle
    };

    print('Maria$queryParams');
    paginationLoading = true;
    CountryListModel responseCountryList = await repository.CountryListAPI(queryParams);

    if (responseCountryList != null) {
      if (responseCountryList.status == 'error') {
        countryListResponse.sink.add(responseCountryList);
      } else {
        if (responseCountryList.data.currentPage > 0) {
          if (PaginationcountryListResponse.data.data != null) {
            PaginationcountryListResponse.data.data.addAll(responseCountryList.data.data);
            print('Minnu');
          }

          PaginationcountryListResponse.data.currentPage = responseCountryList.data.currentPage;
          PaginationcountryListResponse.data.totalPages = responseCountryList.data.totalPages; //to pagination page change
          countryListResponse.sink.add(PaginationcountryListResponse);
          print('MinnuMaria');
        } else {
          PaginationcountryListResponse = responseCountryList;
          countryListResponse.sink.add(responseCountryList); // jsonEncode != .toString()
          print('MinnuMariaKurian');
        }
      }
    }

    paginationLoading = false;
  }






  void dispose() {
    countryListResponse.close();
    stateListResponse.close();
    addCaseResponse.close();
  }

}