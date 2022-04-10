import 'package:bring2book/Constants/apiPathConstants.dart';
import 'package:bring2book/Models/AddCardModel/AddCardModel.dart';
import 'package:bring2book/Models/AddCaseModel/AddCaseModel.dart';
import 'package:bring2book/Models/AddComment/AddComment.dart';
import 'package:bring2book/Models/AllCaseDetailsModel/AllCaseDetailsModel.dart';
import 'package:bring2book/Models/BecomeProUserModel/BecomProUserModel.dart';
import 'package:bring2book/Models/CardListModel/CardListModel.dart';
import 'package:bring2book/Models/CaseDonationModel/CaseDonationModel.dart';
import 'package:bring2book/Models/ChangePasswordModel/ChangePasswordModel.dart';
import 'package:bring2book/Models/CloseCase/CloseCaseModel.dart';
import 'package:bring2book/Models/DeleteCardModel/DeleteCardModel.dart';
import 'package:bring2book/Models/DeleteComment/DeleteCommentModel.dart';
import 'package:bring2book/Models/EditProfileModel/EditProfileModel.dart';
import 'package:bring2book/Models/Follow/Follow.dart';
import 'package:bring2book/Models/ForgotPasswordModel/ForgotPasswordBean.dart';
import 'package:bring2book/Models/GeneralDonation/GeneralDonationModel.dart';
import 'package:bring2book/Models/GetComments/GetCommentsModel.dart';
import 'package:bring2book/Models/GetUserDetailsModel/GetUserDetailsModel.dart';
import 'package:bring2book/Models/IsFollow/IsFollow.dart';
import 'package:bring2book/Models/JoinLeaveCase/JoinLeaveCaseModel.dart';
import 'package:bring2book/Models/LeaderBoardModel/LeaderBoardModel.dart';
import 'package:bring2book/Models/LoginUserModel/LoginUserBean.dart';
import 'package:bring2book/Models/MyCaseAndJoinCaseModel/JoinedCasesModel.dart';
import 'package:bring2book/Models/MyCaseAndJoinCaseModel/MyCasesModel.dart';
import 'package:bring2book/Models/NotificationModel/NotificationModel.dart';
import 'package:bring2book/Models/PlatFormTermsModel/PlatFormsTermsModel.dart';
import 'package:bring2book/Models/ProfileImageUploadModel/ProfileImageUpload.dart';
import 'package:bring2book/Models/RankComment/RankCommentModel.dart';
import 'package:bring2book/Models/RankUpDown/RankCaseDown.dart';
import 'package:bring2book/Models/RankUpDown/RankUpDown.dart';
import 'package:bring2book/Models/RegistrationDataModel/RegistrationBean.dart';
import 'package:bring2book/Models/ReportUserModel/ReportUserModel.dart';
import 'package:bring2book/Models/ResendEmailModel/ResendEmailModel.dart';
import 'package:bring2book/Models/Share/ShareModel.dart';
import 'package:bring2book/Models/SocialLogin/SocialLoginMdl.dart';
import 'package:bring2book/Models/UpdateFcmToken/UpdateDeviceId.dart';
import 'package:bring2book/Models/UserBlockModel/UserBlockModel.dart';
import 'package:bring2book/Services/apiProvider.dart';
import 'package:bring2book/Models/CaseDetails/CaseDetailsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bring2book/Models/FollowingsResponseModel/FollowingsResponseModel.dart';
import 'package:bring2book/Models/FollowersResponseModel/FollowersResponseModel.dart';
import 'package:bring2book/Models/MyDonationsListModel/MyDonationsListModel.dart';
import 'package:bring2book/Models/StateListModel/StateListModel.dart';
import 'package:bring2book/Models/CountryListModel/CountryListModel.dart';

import 'package:bring2book/Models/CoreMemberSelection/CoreMemberSelection.dart';
import 'package:bring2book/Models/ReportComment/ReportCommentModel.dart';
import 'package:bring2book/Models/GetCoreMember/CoreMemberRequest.dart';
import 'package:bring2book/Models/GetCoreMember/GetCoreMembersModel.dart';
import 'package:bring2book/Models/PrivateRequestAccept/PrivateRequestAccept.dart';
import 'package:bring2book/Models/IsFollow/IsFollow.dart';
import 'package:bring2book/Models/RemoveFollowersModel/RemoveFollowersModel.dart';
import 'package:bring2book/Models/RejectCaseModel/RejectCaseModel.dart';
import 'package:bring2book/Models/EditCaseModel/EditCaseModel.dart';
import 'package:bring2book/Models/StatusMessageModel/StatusMessageModel.dart';

import '../Constants/sharedPrefKeys.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<PlatFormTermsModel> getTerms1() async {
    final response = await apiProvider
        .get1(ApiNames.API_FOLDER_URL + ApiNames.API_TERMS_PRIVACY);
    return PlatFormTermsModel.fromJson(response);
  }

  Future<RegistrationBean> postRegisterUser1(parameter) async {
    final response = await apiProvider.post1(
        path: ApiNames.API_FOLDER_URL +
            ApiNames.API_GENERAL_URL +
            ApiNames.registration,
        parameter: parameter);
    return RegistrationBean.fromJson(response);
  }

  Future<StatusMessageModel> performUpdateLatLng(parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL +
            ApiNames.API_GENERAL_URL +
            ApiNames.updateLatLng,
        parameter: parameter);
    return StatusMessageModel.fromJson(response);
  }

  Future<LoginUserBean> postLoginUser1(parameter) async {
    final response = await apiProvider.postLogin(
        path: ApiNames.API_FOLDER_URL + ApiNames.LOGIN, parameter: parameter);
    return LoginUserBean.fromJson(response);
  }

  Future<ForgotPasswordBean> postForgotPassword1(parameter) async {
    final response = await apiProvider.post1(
        path: ApiNames.API_FOLDER_URL + ApiNames.FORGOT_PASSWORD,
        parameter: parameter);
    return ForgotPasswordBean.fromJson(response);
  }

  Future<SocialLoginMdl> postSocialLogin1(parameter) async {
    final response = await apiProvider.post1(
        path: ApiNames.API_FOLDER_URL +
            ApiNames.API_GENERAL_URL +
            ApiNames.API_SOCIAL_URL,
        parameter: parameter);
    return SocialLoginMdl.fromJson(response);
  }

  Future<AllCaseDetailsModel> allCaseDetailsAPI(parameter) async {
    final response = await apiProvider.getWithHeader(
        ApiNames.API_FOLDER_URL + ApiNames.API_ALL_CASES_URL,
        parameter: parameter);
    return AllCaseDetailsModel.fromJson(response);
  }

  Future<MyCasesModel> myCaseAPI(parameter) async {
    ///Maria Kurian Changes Begin ///
    final response = await apiProvider.getWithHeader(
        ApiNames.API_FOLDER_URL +
            ApiNames.API_ALL_CASES_URL +
            ApiNames.API_MY_CASES_URL +
            "1",
        parameter: parameter);
    return MyCasesModel.fromJson(response);
  }

  Future<GetUserDetailsModel> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);
    String id = prefs.getString(SharedPrefKey.USER_ID);
    print('this is userid ${prefs.getString(SharedPrefKey.USER_ID)}');

    final response = await apiProvider.get(
        ApiNames.API_FOLDER_URL +
            ApiNames.API_FOLDER_URL_USER +
            ApiNames.API_USER_DETAILS_URL +
            id,
        auth);
    return GetUserDetailsModel.fromJson(response);
  }

  Future<AddCaseModel> updateDocuments(parameter, file) async {
    print('parameter list is ${file.length}');
    print('parameter list is $file');

    final response = await apiProvider.multipartpostWithHeader(
      path: ApiNames.API_FOLDER_URL + ApiNames.API_ALL_CASES_URL,
      data: parameter,
      files: file,
    );

    return AddCaseModel.fromJson(response);
  }

  Future<BecomProUserModel> becomeProUserApi(parameter, file) async {
    print('parameter list is ${file.length}');
    print('parameter list is $file');

    final response = await apiProvider.multipartpostWithHeader(
      path: ApiNames.API_FOLDER_URL +
          ApiNames.API_FOLDER_URL_PRO_USER +
          ApiNames.API_PRO_USER_DATA_URL,
      data: parameter,
      files: file,
    );

    return BecomProUserModel.fromJson(response);
  }

  Future<JoinedCasesModel> joinedCaseAPI(parameter) async {
    final response = await apiProvider.getWithHeader(
        ApiNames.API_FOLDER_URL +
            ApiNames.API_ALL_CASES_URL +
            ApiNames.API_JOINED_CASES_URL +
            "1",
        parameter: parameter);
    return JoinedCasesModel.fromJson(response);
  }

  Future<CaseDetailsModel> getCaseDetails(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);

    final response = await apiProvider.get(
        ApiNames.API_FOLDER_URL + ApiNames.API_CASE_DETAILS_URL + id, auth);
    return CaseDetailsModel.fromJson(response);
  }

  Future<JoinLeaveCaseModel> postJoin(parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.JOIN_CASE,
        parameter: parameter);
    return JoinLeaveCaseModel.fromJson(response);
  }

  Future<JoinLeaveCaseModel> postLeave(parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.LEAVE_CASE,
        parameter: parameter);
    return JoinLeaveCaseModel.fromJson(response);
  }

  Future<GetCommentsModel> getComments(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);

    final response = await apiProvider.get(
        ApiNames.API_FOLDER_URL + ApiNames.API_GET_COMMENTS_URL + id, auth);
    return GetCommentsModel.fromJson(response);
  }

  Future<GetCommentsModel> getComments1(String id, parameter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);
    final response = await apiProvider.getWithHeader(
        ApiNames.API_FOLDER_URL + ApiNames.API_GET_COMMENTS_URL + id,
        parameter: parameter);
    return GetCommentsModel.fromJson(response);
  }

  rankDown(Map<String, String> parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.API_RANK_DOWN_URL,
        parameter: parameter);
    return RankCaseDown.fromJson(response);
  }

  rankUp(Map<String, String> parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.API_RANK_UP_URL,
        parameter: parameter);
    return RankUpDown.fromJson(response);
  }

  followUser(Map<String, String> parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.API_FOLLOW_URL,
        parameter: parameter);
    return Follow.fromJson(response);
  }

  unFollowUser(Map<String, String> parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.API_UNFOLLOW_URL,
        parameter: parameter);
    return Follow.fromJson(response);
  }

  Future<AddComment> AddCommentMultipart(
      String comment, String caseId, List file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);
    print('parameter list is ${file.length}');
    print('parameter list is $file');
    print('parameter list is $file');

    final response = await apiProvider.multipartpostAddComment(
        path: ApiNames.API_FOLDER_URL + ApiNames.API_ADD_COMMENT_URL,
        comment: comment,
        caseId: caseId,
        files: file,
        auth: auth);

    return AddComment.fromJson(response);
  }

  Future<AddComment> updateDocumentsComment(parameter, file) async {
    print('parameter list is ${file.length}');
    print('parameter list is $file');
    final response = await apiProvider.multipartpostWithHeader(
      path: ApiNames.API_FOLDER_URL + ApiNames.API_ADD_COMMENT_URL,
      data: parameter,
      files: file,
    );
    return AddComment.fromJson(response);
  }

  Future<ShareModel> share(Map<String, String> parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.API_SHARE_URL,
        parameter: parameter);
    return ShareModel.fromJson(response);
  }

  Future<RankCommentModel> postRankComment(parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.API_RANK_COMMENT,
        parameter: parameter);
    return RankCommentModel.fromJson(response);
  }

  Future<IsFollow> isFollow(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);

    final response = await apiProvider.get(
        ApiNames.API_FOLDER_URL +
            ApiNames.API_IS_FOLLOW_URL +
            userId.toString(),
        auth);
    return IsFollow.fromJson(response);
  }

  Future<CloseCaseModel> closeCase(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);

    final response = await apiProvider.get(
        ApiNames.API_FOLDER_URL + ApiNames.API_CLOSE_CASE + id, auth);
    return CloseCaseModel.fromJson(response);
  }

  Future<CaseDonationModel> caseDonation(parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.CASE_DONATION,
        parameter: parameter);
    return CaseDonationModel.fromJson(response);
  }

  Future<GeneralDonationModel> generalDonation(parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.GENERAL_CASE_DONATION,
        parameter: parameter);
    return GeneralDonationModel.fromJson(response);
  }

  Future<ProfileImageUpload> profileImageUploadApi(parameter, file) async {
    print('parameter list is ${file.length}');
    print('parameter list is $file');

    final response = await apiProvider.multipartpostWithHeader(
      path: ApiNames.API_FOLDER_URL +
          ApiNames.API_FOLDER_URL_USER +
          ApiNames.API_IMAGE_UPLOAD_URL,
      data: parameter,
      files: file,
    );

    return ProfileImageUpload.fromJson(response);
  }

  Future<ChangePasswordModel> performChangePassword(parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL +
            ApiNames.API_FOLDER_URL_USER +
            ApiNames.API_CHANGE_PASSWORD_URL,
        parameter: parameter);
    return ChangePasswordModel.fromJson(response);
  }

  Future<EditProfileModel> performEditProfile(parameter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);
    String id = prefs.getString(SharedPrefKey.USER_ID);
    print('this is userid ${prefs.getString(SharedPrefKey.USER_ID)}');
    print('this is userid ${prefs.getString(SharedPrefKey.AUTH_TOKEN)}');

    final response = await apiProvider.put(
        path: ApiNames.API_FOLDER_URL + ApiNames.API_FOLDER_URL_USER + id,
        parameter: parameter);
    return EditProfileModel.fromJson(response);
  }

  Future<ResendEmailModel> performEmailVerify() async {
    final response = await apiProvider.postWithoutParams(
        path: ApiNames.API_FOLDER_URL +
            ApiNames.API_GENERAL_URL +
            ApiNames.API_EMAIL_RESENT_URL);
    return ResendEmailModel.fromJson(response);
  }

  ///Maria New Changes Begins ///

  Future<FollowingsResponseModel> MyFollowingAPI(parameter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);
    String id = prefs.getString(SharedPrefKey.USER_ID);
    print('this is AUTH_TOKEN ${prefs.getString(SharedPrefKey.AUTH_TOKEN)}');

    final response = await apiProvider.getWithHeader(
        ApiNames.API_FOLDER_URL +
            ApiNames.API_FOLLOW_USER_URL +
            ApiNames.API_FOLLOWINGS_URL,
        parameter: parameter);
    return FollowingsResponseModel.fromJson(response);
  }

  Future<FollowersResponseModel> MyFollowersAPI(parameter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);
    String id = prefs.getString(SharedPrefKey.USER_ID);
    print('this is AUTH_TOKEN ${prefs.getString(SharedPrefKey.AUTH_TOKEN)}');

    final response = await apiProvider.getWithHeader(
        ApiNames.API_FOLDER_URL +
            ApiNames.API_FOLLOW_USER_URL +
            ApiNames.API_FOLLOWERS_URL,
        parameter: parameter);
    return FollowersResponseModel.fromJson(response);
  }

  unFollowUserInFollowingList(Map<String, String> parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.API_UNFOLLOW_URL,
        parameter: parameter);
    return Follow.fromJson(response);
  }

  Future<MyDonationsListModel> MyDonationListAPI(parameter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);
    String id = prefs.getString(SharedPrefKey.USER_ID);
    print('this is AUTH_TOKEN ${prefs.getString(SharedPrefKey.AUTH_TOKEN)}');

    final response = await apiProvider.getWithHeader(
        ApiNames.API_FOLDER_URL + ApiNames.API_DONATION_LIST_URL,
        parameter: parameter);
    return MyDonationsListModel.fromJson(response);
  }

  Future<StateListModel> StateListAPI(parameter, countryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);
    String id = prefs.getString(SharedPrefKey.USER_ID);
    print('This is countryId $countryId');

    final response = await apiProvider.getWithHeader(
        ApiNames.API_FOLDER_URL + ApiNames.API_STATE_LIST_URL + countryId,
        parameter: parameter);
    return StateListModel.fromJson(response);
  }

  Future<CountryListModel> CountryListAPI(parameter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);
    String id = prefs.getString(SharedPrefKey.USER_ID);

    final response = await apiProvider.getWithHeader(
        ApiNames.API_FOLDER_URL + ApiNames.API_COUNTRIES_URL,
        parameter: parameter);
    return CountryListModel.fromJson(response);
  }

  ///Maria New Changes Ends ///
  ///

  Future<ReportCommentModel> reportComment(
      Map<String, Object> parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.REPORT_COMMENTS,
        parameter: parameter);
    return ReportCommentModel.fromJson(response);
  }

  Future<GetCoreMembers> getCoreMembers(String caseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);

    final response = await apiProvider.get(
        ApiNames.API_FOLDER_URL + ApiNames.GET_CORE_MEMBERS + caseId, auth);
    return GetCoreMembers.fromJson(response);
  }

  Future<CoreMemberRequest> requestAsCoreMember(
      Map<String, Object> parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.REQUEST_CORE_MEMBER,
        parameter: parameter);
    return CoreMemberRequest.fromJson(response);
  }

  Future<CoreMemberSelection> getCoreMembersSelectionList(String caseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);

    final response = await apiProvider.get(
        ApiNames.API_FOLDER_URL + ApiNames.REQUEST_CORE_MEMBER_LIST + caseId,
        auth);
    return CoreMemberSelection.fromJson(response);
  }

  Future<PrivateRequestAccept> acceptRequest(String caseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);

    final response = await apiProvider.get(
        ApiNames.API_FOLDER_URL + ApiNames.ACCEPT_REQUEST + caseId, auth);
    return PrivateRequestAccept.fromJson(response);
  }

  Future<NotificationModel> getNotificationList(
      Map<String, Object> parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.API_NOTIFICATION_URL,
        parameter: parameter);
    return NotificationModel.fromJson(response);
  }

  Future<DeviceIdModel> updateDeviceId(parameter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);
    String id = prefs.getString(SharedPrefKey.USER_ID);
    print('this is userid ${prefs.getString(SharedPrefKey.USER_ID)}');
    print('this is userid ${prefs.getString(SharedPrefKey.AUTH_TOKEN)}');

    final response = await apiProvider.put(
        path: ApiNames.API_FOLDER_URL + ApiNames.API_FCM_UPDATE + id,
        parameter: parameter);

    print('response is $response');

    return DeviceIdModel.fromJson(response);
  }

  Future<RejectCaseModel> deleteMyCase(String parameter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);

    final response = await apiProvider.get(
        ApiNames.API_FOLDER_URL +
            ApiNames.API_ADMIN_API_URL +
            ApiNames.API_DELETE_MY_CASE_URL +
            parameter,
        auth);
    return RejectCaseModel.fromJson(response);
  }

  followUserInFollowersList(Map<String, String> parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.API_FOLLOW_URL,
        parameter: parameter);
    return Follow.fromJson(response);
  }

  removeUserInFollowersList(Map<String, String> parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL +
            ApiNames.API_FOLLOW_URL +
            ApiNames.API_REMOVERS_URL,
        parameter: parameter);
    return RemoveFollowersModel.fromJson(response);
  }

  Future<ReportUserModel> reportUser(Map<String, Object> parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.REPORT_USER,
        parameter: parameter);
    return ReportUserModel.fromJson(response);
  }

  Future<AddCardModel> addCard(Map<String, String> parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.ADD_CARD,
        parameter: parameter);
    return AddCardModel.fromJson(response);
  }

  Future<CardListModel> getCardList(Map<String, Object> parameter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);

    final response = await apiProvider.get(
        ApiNames.API_FOLDER_URL + ApiNames.CARD_LIST, auth);
    return CardListModel.fromJson(response);
  }

  Future<DeleteCardtModel> deleteCard(parameter) async {
    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL + ApiNames.DELETE_CARD,
        parameter: parameter);
    return DeleteCardtModel.fromJson(response);
  }

  Future<DeleteCommentModel> deleteComment(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);

    final response = await apiProvider.get(
        ApiNames.API_FOLDER_URL + ApiNames.DELETE_COMMENT + id.toString(),
        auth);
    return DeleteCommentModel.fromJson(response);
  }

  Future<UserBlockModel> blockUser(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);

    final response = await apiProvider.delete(
        ApiNames.API_FOLDER_URL + ApiNames.BLOCK_USER + userId.toString(),
        auth);
    return UserBlockModel.fromJson(response);
  }

  Future<LeaderModel> getLeaderBoardList(Map<String, Object> parameter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);
    final response = await apiProvider.getWithHeader(
        ApiNames.API_FOLDER_URL + ApiNames.LEADER_BOARD_LIST,
        parameter: parameter);
    return LeaderModel.fromJson(response);
  }

  Future<EditCaseModel> getEditCaseDetails(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);

    final response = await apiProvider.get(
        ApiNames.API_FOLDER_URL + ApiNames.API_CASE_DETAILS_URL + id, auth);
    return EditCaseModel.fromJson(response);
  }

  Future<StatusMessageModel> updateEditMyCase(parameter, caseId) async {
    print('parameter list is $caseId');

    final response = await apiProvider.post(
        path: ApiNames.API_FOLDER_URL +
            ApiNames.API_ALL_CASES_URL +
            ApiNames.API_EDIT_CASES_URL +
            caseId,
        parameter: parameter);

    return StatusMessageModel.fromJson(response);
  }

  Future<StatusMessageModel> uploadEditCaseDocs(parameter, file) async {
    print('parameter list is $parameter');

    final response = await apiProvider.multipartpostWithHeader(
      path: ApiNames.API_FOLDER_URL +
          ApiNames.API_ALL_CASES_URL +
          ApiNames.API_EDIT_UPLOAD_DOC_URL,
      data: parameter,
      files: file,
    );

    return StatusMessageModel.fromJson(response);
  }

  Future<StatusMessageModel> deleteEditCaseDocs(String imageid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString(SharedPrefKey.AUTH_TOKEN);

    final response = await apiProvider.get(
        ApiNames.API_FOLDER_URL +
            ApiNames.API_ALL_CASES_URL +
            ApiNames.API_DELETE_UPLOAD_DOC_URL +
            imageid,
        auth);
    return StatusMessageModel.fromJson(response);
  }
}
