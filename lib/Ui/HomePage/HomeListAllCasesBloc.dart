import 'dart:convert';

import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Models/AllCaseDetailsModel/AllCaseDetailsModel.dart';
import 'package:bring2book/Models/GetUserDetailsModel/GetUserDetailsModel.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:bring2book/Models/StatusMessageModel/StatusMessageModel.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class HomeListAllCasesBloc {
  final repository = Repository();

  final getUserDetailsResponse = PublishSubject<GetUserDetailsModel>();
  Stream<GetUserDetailsModel> get getUserDetailsStream =>
      getUserDetailsResponse.stream;

  final allCaseDetailsResp = PublishSubject<AllCaseDetailsModel>();
  Stream<AllCaseDetailsModel> get allCaseDetailsRespStream =>
      allCaseDetailsResp.stream;

  final allCaseSearchDetailsResp = PublishSubject<AllCaseDetailsModel>();
  Stream<AllCaseDetailsModel> get allCaseSearchDetailsRespStream =>
      allCaseSearchDetailsResp.stream;

  bool paginationLoading = false;
  AllCaseDetailsModel PaginationallCaseDetailsResp;

  final updateLatLngResponse = PublishSubject<StatusMessageModel>();
  Stream<StatusMessageModel> get LatLngResponse => updateLatLngResponse.stream;

  Future<StatusMessageModel> performUpdateLatLng(
    String latitude,
    String longitude,
  ) async {
    print('countryCode$latitude');

    final parameter = {'latitude': latitude, 'longitude': longitude};

    StatusMessageModel statusMessageModel =
        await repository.performUpdateLatLng(parameter);
    if (statusMessageModel != null) {
      updateLatLngResponse.sink.add(statusMessageModel);
    }

    print(updateLatLngResponse);
  }

  Future allCaseAPI({String page, String sortBy}) async {
    paginationLoading = true;

    //Map<String, String> queryParams = {'page': page, 'sortBy': sortBy};

    Map<String, String> queryParams = {'page': page};

    print('Maria$queryParams');
    allCaseDetailsAPI(queryParams);
  }

  Future allCaseSortAPI({String page, String sortBy}) async {
    paginationLoading = true;

    Map<String, String> queryParams = {'page': page, 'sortBy': sortBy};

    print('Maria$queryParams');
    allCaseDetailsAPI(queryParams);
  }

  Future allCaseFilterAPI({String page, String search, String sortBy}) async {
    paginationLoading = true;

    Map<String, String> queryParams = {
      'page': page,
      'search': search,
      'sortBy': sortBy
    };

    print('Maria$queryParams');
    allCaseDetailsAPI(queryParams);
  }

  Future CountryFilterAPI(
      {String page,
      String sortBy,
      String filterCountry,
      String filterState}) async {
    paginationLoading = true;

    Map<String, String> queryParams = {
      'page': page,
      'sortBy': sortBy,
      'filterCountry': filterCountry,
      'filterState': filterState,
    };

    print('Maria$queryParams');
    allCaseDetailsAPI(queryParams);
  }

  Future allCaseDetailsAPI(queryParams) async {
    print('MariaMinnu$queryParams');
    paginationLoading = true;
    AllCaseDetailsModel responseAllCase =
        await repository.allCaseDetailsAPI(queryParams);

    if (responseAllCase != null) {
      if (responseAllCase.status == 'error') {
        allCaseDetailsResp.sink.add(responseAllCase);
      } else {
        if (responseAllCase.data.currentPage > 0) {
          if (PaginationallCaseDetailsResp.data.data != null) {
            PaginationallCaseDetailsResp.data.data
                .addAll(responseAllCase.data.data);
            print('Minnu');
          }

          PaginationallCaseDetailsResp.data.currentPage =
              responseAllCase.data.currentPage;
          PaginationallCaseDetailsResp.data.totalPages =
              responseAllCase.data.totalPages; //to pagination page change
          allCaseDetailsResp.sink.add(PaginationallCaseDetailsResp);
          print('MinnuMaria');
        } else {
          PaginationallCaseDetailsResp = responseAllCase;
          allCaseDetailsResp.sink
              .add(responseAllCase); // jsonEncode != .toString()
          print('MinnuMariaKurian');
        }
      }
    }

    paginationLoading = false;
  }

  Future allCaseSearchAPI(
      {String page, String sortBy, String searchTitle}) async {
    paginationLoading = true;

    Map<String, String> queryParams = {
      'page': page,
      'sortBy': sortBy,
      'searchTitle': searchTitle
    };

    print('Maria$queryParams');
    allCaseSearchDetailAPI(queryParams);
  }

  Future allCaseSearchDetailAPI(queryParams) async {
    print('MariaMinnu$queryParams');
    paginationLoading = true;
    AllCaseDetailsModel responseAllCase =
        await repository.allCaseDetailsAPI(queryParams);

    if (responseAllCase != null) {
      if (responseAllCase.status == 'error') {
        allCaseSearchDetailsResp.sink.add(responseAllCase);
      } else {
        if (responseAllCase.data.currentPage > 0) {
          if (PaginationallCaseDetailsResp.data.data != null) {
            PaginationallCaseDetailsResp.data.data
                .addAll(responseAllCase.data.data);
            print('Minnu');
          }

          PaginationallCaseDetailsResp.data.currentPage =
              responseAllCase.data.currentPage;
          PaginationallCaseDetailsResp.data.totalPages =
              responseAllCase.data.totalPages; //to pagination page change
          allCaseSearchDetailsResp.sink.add(PaginationallCaseDetailsResp);
          print('MinnuMaria');
        } else {
          PaginationallCaseDetailsResp = responseAllCase;
          allCaseSearchDetailsResp.sink
              .add(responseAllCase); // jsonEncode != .toString()
          print('MinnuMariaKurian');
        }
      }
    }

    paginationLoading = false;
  }

  Future<GetUserDetailsModel> getUserDetails() async {
    GetUserDetailsModel getUserDetailsResp = await repository.getUserDetails();
    if (getUserDetailsResp != null) {
      getUserDetailsResponse.sink.add(getUserDetailsResp);
    }
    print("MariaMol");
    print(getUserDetailsResp);
  }

  dateconvert(String Format) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'");
    DateTime dateTime = dateFormat.parse(Format);

    DateFormat dateFormatterMonDay = DateFormat("MMMM dd, yyyy");
    String monDaystring = dateFormatterMonDay.format(dateTime);

    return monDaystring;
  }

  void dispose() {
    allCaseSearchDetailsResp.close();
    allCaseDetailsResp.close();
    getUserDetailsResponse.close();
  }
}
