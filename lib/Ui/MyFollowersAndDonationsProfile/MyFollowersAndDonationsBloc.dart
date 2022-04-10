import 'package:bring2book/Models/GetUserDetailsModel/GetUserDetailsModel.dart';
import 'package:bring2book/Repository/repository.dart';
import 'package:bring2book/Models/ProfileImageUploadModel/ProfileImageUpload.dart';
import 'package:bring2book/Models/EditProfileModel/EditProfileModel.dart';
import 'package:bring2book/Models/FollowersResponseModel/FollowersResponseModel.dart';
import 'package:bring2book/Models/FollowingsResponseModel/FollowingsResponseModel.dart';
import 'package:bring2book/Models/Follow/Follow.dart';
import 'package:bring2book/Models/RemoveFollowersModel/RemoveFollowersModel.dart';
import 'package:bring2book/Models/MyDonationsListModel/MyDonationsListModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class MyFollowersAndDonationsBloc {

  final repository = Repository();

  final myFollowersResp = BehaviorSubject<FollowersResponseModel>();
  Stream<FollowersResponseModel> get myFollowersRespStream => myFollowersResp.stream;

  final myFollowingResp = BehaviorSubject<FollowingsResponseModel>();
  Stream<FollowingsResponseModel> get myFollowingRespStream => myFollowingResp.stream;

  final unFollowResp = BehaviorSubject<Follow>();
  Stream<Follow> get unFollowRespStream => unFollowResp.stream;

  final followResp = BehaviorSubject<Follow>();
  Stream<Follow> get followRespStream => followResp.stream;


  final removeResp = BehaviorSubject<RemoveFollowersModel>();
  Stream<RemoveFollowersModel> get removeRespStream => removeResp.stream;

  final myDonationListResp = BehaviorSubject<MyDonationsListModel>();
  Stream<MyDonationsListModel> get myDonationListRespStream => myDonationListResp.stream;

  bool paginationLoading = false;

  FollowingsResponseModel PaginationmyFollowingResp;
  FollowersResponseModel PaginationmyFollowersResp;
  MyDonationsListModel PaginationmyDonationListResp;





  Future MyFollowersAPI({String page}) async {
    paginationLoading = true;
    Map<String, String> queryParams = {'page': page};

    print('Maria$queryParams');

    paginationLoading = true;
    FollowersResponseModel responseMyFollowers = await repository.MyFollowersAPI(queryParams);

    if (responseMyFollowers != null) {
      if (responseMyFollowers.status == 'error') {
        myFollowersResp.sink.add(responseMyFollowers);
      } else {
        if (responseMyFollowers.data.currentPage > 0) {
          if (PaginationmyFollowersResp.data.data != null) {
            PaginationmyFollowersResp.data.data.addAll(responseMyFollowers.data.data);
            print('Minnu');
          }

          PaginationmyFollowersResp.data.currentPage = responseMyFollowers.data.currentPage;
          PaginationmyFollowersResp.data.totalPages = responseMyFollowers.data.totalPages; //to pagination page change
          myFollowersResp.sink.add(PaginationmyFollowersResp);
          print('MinnuMaria');
        } else {
          PaginationmyFollowersResp = responseMyFollowers;
          myFollowersResp.sink.add(PaginationmyFollowersResp); // jsonEncode != .toString()
          print('MinnuMariaKurian');
        }
      }
    }

    paginationLoading = false;
  }

  Future MyFollowingAPI({String page}) async {
    paginationLoading = true;
    Map<String, String> queryParams = {'page': page};

    print('Maria$queryParams');

    paginationLoading = true;
    FollowingsResponseModel responseMyFollowing = await repository.MyFollowingAPI(queryParams);

    if (responseMyFollowing != null) {
      if (responseMyFollowing.status == 'error') {
        myFollowingResp.sink.add(responseMyFollowing);
      } else {
        if (responseMyFollowing.data.currentPage > 0) {
          if (PaginationmyFollowingResp.data.data != null) {
            PaginationmyFollowingResp.data.data.addAll(responseMyFollowing.data.data);
            print('Minnu');
          }

          PaginationmyFollowingResp.data.currentPage =
              responseMyFollowing.data.currentPage;
          PaginationmyFollowingResp.data.totalPages =
              responseMyFollowing.data.totalPages; //to pagination page change
          myFollowingResp.sink.add(PaginationmyFollowingResp);
          print('MinnuMaria');
        } else {
          PaginationmyFollowingResp = responseMyFollowing;
          myFollowingResp.sink
              .add(PaginationmyFollowingResp); // jsonEncode != .toString()
          print('MinnuMariaKurian');
        }
      }
    }

    paginationLoading = false;
  }


  Future<void> unFollowUserInFollowingList(String id) async {
    final parameter = {
      'followingUserId': id,
    };
    Follow unfollowresponse = await repository.unFollowUserInFollowingList(parameter);
    if (unfollowresponse != null) {
      print("not null model");
      unFollowResp.sink.add(unfollowresponse);
    }

    print(unfollowresponse);
  }



  Future<void> followUserInFollowersList(String id) async {
    final parameter = {
      'followingUserId': id,
    };
    Follow followresponse = await repository.followUserInFollowersList(parameter);
    if (followresponse != null) {
      print("not null model");
      followResp.sink.add(followresponse);
    }

    print(followresponse);
  }



  Future<void> removeUserInFollowersList(String id) async {
    final parameter = {
      'userId': id,
    };
    RemoveFollowersModel removeresponse = await repository.removeUserInFollowersList(parameter);
    if (removeresponse != null) {
      print("not null model");
      removeResp.sink.add(removeresponse);
    }

    print(removeresponse);
  }



  Future MyDonationListAPI({String page}) async {
    paginationLoading = true;
    final parameter = {
      'page':page,
    };
    Map<String, String> queryParams = {'page': page};

    print('Maria$queryParams');

    paginationLoading = true;
    MyDonationsListModel responseMyDonationList = await repository.MyDonationListAPI(queryParams);

    if (responseMyDonationList != null) {
      if (responseMyDonationList.status == 'error') {
        myDonationListResp.sink.add(responseMyDonationList);
      } else {
        if (responseMyDonationList.data.currentPage > 0) {
          if (PaginationmyDonationListResp.data.data != null) {
            PaginationmyDonationListResp.data.data.addAll(responseMyDonationList.data.data);
            print('Minnu');
          }

          PaginationmyDonationListResp.data.currentPage = responseMyDonationList.data.currentPage;
          PaginationmyDonationListResp.data.totalPages = responseMyDonationList.data.totalPages; //to pagination page change
          myDonationListResp.sink.add(PaginationmyDonationListResp);
          print('MinnuMaria');
        } else {
          PaginationmyDonationListResp = responseMyDonationList;
          myDonationListResp.sink.add(PaginationmyDonationListResp); // jsonEncode != .toString()
          print('MinnuMariaKurian');
        }
      }
    }

    paginationLoading = false;
  }


  dateconvert(String Format) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'");
    DateTime dateTime = dateFormat.parse(Format);

    DateFormat dateFormatterMonDay = DateFormat("MMM, dd yyyy");

    String monDaystring = dateFormatterMonDay.format(dateTime);

    return monDaystring;
  }


  void dispose() {
    removeResp.close();
    followResp.close();
    myDonationListResp.close();
    unFollowResp.close();
    myFollowersResp.close();
    myFollowingResp.close();
  }



}