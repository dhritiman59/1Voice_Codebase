import 'package:bring2book/Models/MyCaseAndJoinCaseModel/JoinedCasesModel.dart';
import 'package:bring2book/Models/MyCaseAndJoinCaseModel/MyCasesModel.dart';
import 'package:bring2book/Models/RejectCaseModel/RejectCaseModel.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class MyCaseAndJoinCaseHomeBloc {
  final repository = Repository();

  final myCaseDetailsResp = BehaviorSubject<MyCasesModel>();
  Stream<MyCasesModel> get myCaseDetailsRespStream => myCaseDetailsResp.stream;

  final joinCaseDetailsResp = BehaviorSubject<JoinedCasesModel>();
  Stream<JoinedCasesModel> get joinCaseDetailsRespStream => joinCaseDetailsResp.stream;


  final deleteMyCaseResp = BehaviorSubject<RejectCaseModel>();
  Stream<RejectCaseModel> get deleteMyCaseRespStream => deleteMyCaseResp.stream;


  bool paginationLoading = false;
  JoinedCasesModel PaginationallJoinCaseResp;
  MyCasesModel PaginationallMyCaseResp;

  Future MyCasesAPI({String page}) async {
    paginationLoading = true;

    Map<String, String> queryParams = {'page': page};

    print('Maria$queryParams');
    paginationLoading = true;
    MyCasesModel responseAllCase = await repository.myCaseAPI(queryParams);

    if (responseAllCase != null) {
      if (responseAllCase.status == 'error') {
        myCaseDetailsResp.sink.add(responseAllCase);
      } else {
        if (responseAllCase.data.currentPage > 0) {
          if (PaginationallMyCaseResp.data.data != null) {
            PaginationallMyCaseResp.data.data.addAll(responseAllCase.data.data);
            print('Minnu');
          }

          PaginationallMyCaseResp.data.currentPage =
              responseAllCase.data.currentPage;
          PaginationallMyCaseResp.data.totalPages =
              responseAllCase.data.totalPages; //to pagination page change
          myCaseDetailsResp.sink.add(PaginationallMyCaseResp);
          print('MinnuMaria');
        } else {
          PaginationallMyCaseResp = responseAllCase;
          myCaseDetailsResp.sink
              .add(PaginationallMyCaseResp); // jsonEncode != .toString()
          print('MinnuMariaKurian');
        }
      }
    }

    paginationLoading = false;
  }

  Future MyCaseSearchAPI({String page, String searchTitle}) async {
    paginationLoading = true;

    Map<String, String> queryParams = {
      'page': page,
      'searchTitle': searchTitle
    };

    print('Maria$queryParams');
    paginationLoading = true;
    MyCasesModel responseAllCase = await repository.myCaseAPI(queryParams);

    if (responseAllCase != null) {
      if (responseAllCase.status == 'error') {
        myCaseDetailsResp.sink.add(responseAllCase);
      } else {
        if (responseAllCase.data.currentPage > 0) {
          if (PaginationallMyCaseResp.data.data != null) {
            PaginationallMyCaseResp.data.data.addAll(responseAllCase.data.data);
            print('Minnu');
          }

          PaginationallMyCaseResp.data.currentPage =
              responseAllCase.data.currentPage;
          PaginationallMyCaseResp.data.totalPages =
              responseAllCase.data.totalPages; //to pagination page change
          myCaseDetailsResp.sink.add(PaginationallMyCaseResp);
          print('MinnuMaria');
        } else {
          PaginationallMyCaseResp = responseAllCase;
          myCaseDetailsResp.sink
              .add(responseAllCase); // jsonEncode != .toString()
          print('MinnuMariaKurian');
        }
      }
    }

    paginationLoading = false;
  }

  Future JoinedCasesAPI({String page}) async {
    paginationLoading = true;

    Map<String, String> queryParams = {'page': page};

    print('Maria$queryParams');
    paginationLoading = true;
    JoinedCasesModel responseJoinCase = await repository.joinedCaseAPI(queryParams);

    if (responseJoinCase != null) {
      if (responseJoinCase.status == 'error') {
        joinCaseDetailsResp.sink.add(responseJoinCase);
      } else {
        if (responseJoinCase.data.currentPage > 0) {
          if (PaginationallJoinCaseResp.data.data != null) {
            PaginationallJoinCaseResp.data.data
                .addAll(responseJoinCase.data.data);
            print('Minnu');
          }

          PaginationallJoinCaseResp.data.currentPage =
              responseJoinCase.data.currentPage;
          PaginationallJoinCaseResp.data.totalPages =
              responseJoinCase.data.totalPages; //to pagination page change
          joinCaseDetailsResp.sink.add(PaginationallJoinCaseResp);
          print('MinnuMaria');
        } else {
          PaginationallJoinCaseResp = responseJoinCase;
          joinCaseDetailsResp.sink
              .add(responseJoinCase); // jsonEncode != .toString()
          print('MinnuMariaKurian');
        }
      }
    }

    paginationLoading = false;
  }

  Future JoinedCaseSearchAPI({String page, String searchTitle}) async {
    paginationLoading = true;

    Map<String, String> queryParams = {
      'page': page,
      'searchTitle': searchTitle
    };

    print('Maria$queryParams');
    paginationLoading = true;
    JoinedCasesModel responseJoinCase = await repository.joinedCaseAPI(queryParams);

    if (responseJoinCase != null) {
      if (responseJoinCase.status == 'error') {
        joinCaseDetailsResp.sink.add(responseJoinCase);
      } else {
        if (responseJoinCase.data.currentPage > 0) {
          if (PaginationallJoinCaseResp.data.data != null) {
            PaginationallJoinCaseResp.data.data
                .addAll(responseJoinCase.data.data);
            print('Minnu');
          }

          PaginationallJoinCaseResp.data.currentPage =
              responseJoinCase.data.currentPage;
          PaginationallJoinCaseResp.data.totalPages =
              responseJoinCase.data.totalPages; //to pagination page change
          joinCaseDetailsResp.sink.add(PaginationallJoinCaseResp);
          print('MinnuMaria');
        } else {
          PaginationallJoinCaseResp = responseJoinCase;
          joinCaseDetailsResp.sink
              .add(responseJoinCase); // jsonEncode != .toString()
          print('MinnuMariaKurian');
        }
      }
    }

    paginationLoading = false;
  }




  Future<RejectCaseModel> deleteMyCase(String id) async {

    RejectCaseModel deleteMyCaseresponse = await repository.deleteMyCase(id);
    if (deleteMyCaseresponse != null) {
      print("not null model");
      deleteMyCaseResp.sink.add(deleteMyCaseresponse);
    }

    print(deleteMyCaseresponse);
  }

  dateconvert(String Format) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'");
    DateTime dateTime = dateFormat.parse(Format);

    DateFormat dateFormatterMonDay = DateFormat("MMMM, dd yyyy");
    String monDaystring = dateFormatterMonDay.format(dateTime);

    return monDaystring;
  }

  void dispose() {
    myCaseDetailsResp.close();
    joinCaseDetailsResp.close();
  }
}
