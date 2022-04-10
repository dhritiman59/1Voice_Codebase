import 'dart:async';

import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Models/CaseDetails/CaseDetailsModel.dart';
import 'package:bring2book/Models/CloseCase/CloseCaseModel.dart';
import 'package:bring2book/Models/DeleteComment/DeleteCommentModel.dart';
import 'package:bring2book/Models/Follow/Follow.dart';
import 'package:bring2book/Models/GetComments/GetCommentsModel.dart';
import 'package:bring2book/Models/IsFollow/IsFollow.dart';
import 'package:bring2book/Models/JoinLeaveCase/JoinLeaveCaseModel.dart';
import 'package:bring2book/Models/RankComment/RankCommentModel.dart';
import 'package:bring2book/Models/RankUpDown/RankCaseDown.dart';
import 'package:bring2book/Models/RankUpDown/RankUpDown.dart';
import 'package:bring2book/Models/ReportComment/ReportCommentModel.dart';
import 'package:bring2book/Models/ReportUserModel/ReportUserModel.dart';
import 'package:bring2book/Models/Share/ShareModel.dart';
import 'package:bring2book/Models/UserBlockModel/UserBlockModel.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaseDetailsBloc {
  final repository = Repository();
  final caseDetails = PublishSubject<CaseDetailsModel>();
  final joinResponse = PublishSubject<JoinLeaveCaseModel>();
  final leaveResponse = PublishSubject<JoinLeaveCaseModel>();
  final getComments = PublishSubject<GetCommentsModel>();
  final rankUpDown = PublishSubject<RankUpDown>();
  final rankCaseDown = PublishSubject<RankCaseDown>();
  final follow = PublishSubject<Follow>();
  final share = PublishSubject<ShareModel>();
  final rankComment = PublishSubject<RankCommentModel>();
  final isFollow = PublishSubject<IsFollow>();
  final closeCase = PublishSubject<CloseCaseModel>();
  final reportComment = PublishSubject<ReportCommentModel>();
  final reportUser = PublishSubject<ReportUserModel>();
  final deleteComments = PublishSubject<DeleteCommentModel>();
  final blockUsers = PublishSubject<UserBlockModel>();
  Stream<JoinLeaveCaseModel> get joinStream => joinResponse.stream;
  Stream<JoinLeaveCaseModel> get leaveStream => leaveResponse.stream;
  Stream<CaseDetailsModel> get details => caseDetails.stream;
  Stream<GetCommentsModel> get comments => getComments.stream;
  Stream<RankUpDown> get rank => rankUpDown.stream;
  Stream<RankCaseDown> get rankDownCase => rankCaseDown.stream;
  Stream<Follow> get follow_him => follow.stream;
  Stream<ShareModel> get shareStream => share.stream;
  Stream<RankCommentModel> get rankCommentStream => rankComment.stream;
  Stream<IsFollow> get isFollowStream => isFollow.stream;
  Stream<CloseCaseModel> get closeCaseStream => closeCase.stream;
  Stream<ReportCommentModel> get reportStream => reportComment.stream;
  Stream<ReportUserModel> get reportUserStream => reportUser.stream;
  Stream<DeleteCommentModel> get deleteCommentStream => deleteComments.stream;
  Stream<UserBlockModel> get blockUserStream => blockUsers.stream;
  StreamController validateCaseDetailsController = StreamController<String>();
  Stream<String> get validateTermsStream =>
      validateCaseDetailsController.stream;
  StreamSink<String> get validateTermsSink =>
      validateCaseDetailsController.sink;

  String bannerImage = 'assets/images/caseDetailCorruptionBanner.png';
  bool isArrowVisible = true;

  String caseTitle,caseStatus;
  Future<CaseDetailsModel> getCaseDetails(String caseId) async {
    CaseDetailsModel model = await repository.getCaseDetails(caseId);
    caseTitle=model.data.usersRef.caseTitle;
    caseStatus=model.data.usersRef.status.toString();
    if (CaseDetailsModel != null) {

      print("not null model");
      if (model.data.usersRef.caseCategory == 'Human Traffic') {
        isArrowVisible = false;
        bannerImage = 'assets/images/casedetailsHuman.png';
      } else if (model.data.usersRef.caseCategory == 'Corruption') {
        isArrowVisible = true;
        bannerImage = 'assets/images/caseDetailCorruptionBanner.png';
      } else if (model.data.usersRef.caseCategory == 'Environment abusing') {
        bannerImage = 'assets/images/caseDetailEvabsu.png';
      } else {
        isArrowVisible = false;
        bannerImage = 'assets/images/casedetailsHuman.png';
      }
      caseDetails.sink.add(model);
    }

    print(CaseDetailsModel);
  }

  Future<JoinLeaveCaseModel> joinCase(String id) async {
    final parameter = {
      'caseId': id,
    };

    JoinLeaveCaseModel joinLeaveCaseModel =
        await repository.postJoin(parameter);
    if (joinLeaveCaseModel != null) {
      joinResponse.sink.add(joinLeaveCaseModel);
    }
    print("Maria");
    print(joinLeaveCaseModel);
  }

  Future<JoinLeaveCaseModel> leaveCase(String id) async {
    final parameter = {
      'caseId': id,
    };

    JoinLeaveCaseModel joinLeaveCaseModel =
        await repository.postLeave(parameter);
    if (joinLeaveCaseModel != null) {
      leaveResponse.sink.add(joinLeaveCaseModel);
    }
    print("Maria");
    print(joinLeaveCaseModel);
  }

  Future<void> getAllComments(String id) async {
    print(
        'comments 3£££3££3££££@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    GetCommentsModel model = await repository.getComments(id);
    if (CaseDetailsModel != null) {
      print("not null model");
      getComments.sink.add(model);
    }

    print(GetCommentsModel);
  }

  Future<void> rankDown(String id) async {
    final parameter = {
      'caseId': id,
    };
    RankCaseDown model = await repository.rankDown(parameter);
    if (RankCaseDown != null) {
      print("not null model");
      rankCaseDown.sink.add(model);
    }

    print(RankCaseDown);
  }

  Future<void> rankUp(String id) async {
    final parameter = {
      'caseId': id,
    };
    RankUpDown model = await repository.rankUp(parameter);
    if (RankUpDown != null) {
      print("not null model");
      rankUpDown.sink.add(model);
    }

    print(RankUpDown);
  }

  Future<void> followUser(String id) async {
    final parameter = {
      'followingUserId': id,
    };
    Follow follow_model = await repository.followUser(parameter);
    if (follow_model != null) {
      print("not null model");
      follow.sink.add(follow_model);
    }

    print(Follow);
  }

  Future<void> unFollowUser(String id) async {
    final parameter = {
      'followingUserId': id,
    };
    Follow follow_model = await repository.unFollowUser(parameter);
    if (follow_model != null) {
      print("not null model");
      follow.sink.add(follow_model);
    }

    print(follow_model);
  }

  Future<void> shareCase(String id) async {
    final parameter = {
      "heading": "Shared Case",
      "message": "Just See this Case",
      "caseId": id,
    };
    ShareModel model = await repository.share(parameter);
    if (model != null) {
      print("not null model");
      share.sink.add(model);
    }

    print(Follow);
  }

  final getComments1 = PublishSubject<GetCommentsModel>();
  Stream<GetCommentsModel> get comments1 => getComments1.stream;
  GetCommentsModel PaginationaComments;
  bool paginationLoading = false;

  Future getAllComments1(String id, String page) async {
    paginationLoading = true;
    Map<String, String> queryParams = {'page': page};

    print('Maria$queryParams');
    paginationLoading = true;
    GetCommentsModel responseJoinCase =
        await repository.getComments1(id, queryParams);

    if (responseJoinCase != null) {
      if (responseJoinCase.status == 'error') {
        getComments1.sink.add(responseJoinCase);
      } else {
        if (responseJoinCase.data.currentPage > 0) {
          if (PaginationaComments.data.data != null) {
            PaginationaComments.data.data.addAll(responseJoinCase.data.data);
          }

          PaginationaComments.data.currentPage =
              responseJoinCase.data.currentPage;
          PaginationaComments.data.totalPages =
              responseJoinCase.data.totalPages; //to pagination page change
          getComments1.sink.add(PaginationaComments);
        } else {
          PaginationaComments = responseJoinCase;
          getComments1.sink.add(responseJoinCase); // jsonEncode != .toString()

        }
      }
    }
    paginationLoading = false;
  }

  Future<RankCommentModel> rankComments(
      int id, int caseId, String status) async {
    final parameter = {
      'commentId': id,
      'caseId': caseId,
      'status': status,
    };

    RankCommentModel rankCommentModel =
        await repository.postRankComment(parameter);
    if (rankCommentModel != null) {
      rankComment.sink.add(rankCommentModel);
    }
  }

  Future<IsFollow> isFollowUser(int userId) async {
    IsFollow model = await repository.isFollow(userId);
    if (model != null) {
      print("not null model");
      isFollow.sink.add(model);
    }
  }

  Future<CloseCaseModel> closingCase(String caseId) async {
    CloseCaseModel model = await repository.closeCase(caseId);
    if (CloseCaseModel != null) {
      print("not null model");
      closeCase.sink.add(model);
    }
  }

  Future<ReportCommentModel> reportComments(String comment, int caseId, int id) async {
    final parameter = {
     'caseId':caseId,
      'commentId':id,
      'message':comment
    };
  ReportCommentModel model=await repository.reportComment(parameter);
    if (model != null) {
      reportComment.sink.add(model);
    }
  }

  Future<ReportUserModel> reportUserComment(String meassage, int userId,int caseId,) async {
    final parameter = {
      'caseId':caseId,
      'reporteduserId':userId,
      'message':meassage
    };
    ReportUserModel model=await repository.reportUser(parameter);
    if (model != null) {
      reportUser.sink.add(model);
    }
  }



  Future<DeleteCommentModel> deleteComment(int id) async {
    DeleteCommentModel model = await repository.deleteComment(id);
    if (model != null) {
      print("not null model");
      deleteComments.sink.add(model);
    }
  }
  Future<UserBlockModel> blockUser(int userId) async {
    UserBlockModel model = await repository.blockUser(userId);
    if (model != null) {
      print("not null model");
      blockUsers.sink.add(model);
    }
  }

}
