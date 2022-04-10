import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bring2book/Ui/MyFollowersAndDonationsProfile/MyFollowersAndDonationsBloc.dart';
import 'package:bring2book/Models/FollowersResponseModel/FollowersResponseModel.dart';
import 'package:bring2book/Models/FollowingsResponseModel/FollowingsResponseModel.dart';

import 'package:bring2book/Ui/ChatHomePage/SingleChatMsgPage.dart';
import 'package:bring2book/Ui/ProfileHomePage/ProfileDetailsBloc.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart';

class MyFollowersListProfile extends StatefulWidget {
  const MyFollowersListProfile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyFollowersListProfileState createState() => _MyFollowersListProfileState();
}

class _MyFollowersListProfileState extends State<MyFollowersListProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ProfileDetailsBloc _profileDetailsBloc = ProfileDetailsBloc();

  final MyFollowersAndDonationsBloc _myFollowersAndDonationsBloc =
      MyFollowersAndDonationsBloc();
  bool visible = false;

  Color myCasebBgColor = CustColors.DarkBlue;
  Color myCasebTextColor = Colors.white;
  Color joinedCasebBgColor = Colors.white;
  Color joinedCasebTextColor = CustColors.DarkBlue;
  String mycasejoincasestatus = "1";

  String followText = " .Follow";

  String numberOfFollowers = "0";
  String numberOfFollowings = "0";

  var currentIndex = 0;
  var caseid = "";

  String userTypeId;
  String id;
  String senderFcm;
  String userNameForSingleChat = '';

  bool isLoadingFollowers = false;
  bool isLoadingFollowings = false;

  String userProfilePic = '';

  @override
  void initState() {
    super.initState();

    getData();
    _profileDetailsBloc.getUserDetails();

    _myFollowersAndDonationsBloc.MyFollowersAPI(page: "0");
    _myFollowersAndDonationsBloc.MyFollowingAPI(page: "0");
    listenApi();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userTypeId = prefs.getString(SharedPrefKey.USER_TYPE);
    id = prefs.getString(SharedPrefKey.USER_ID);
    senderFcm = prefs.getString(SharedPrefKey.FCM_TOKEN);
    userNameForSingleChat = prefs.getString(SharedPrefKey.USER_NAME);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 2,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                MediaQuery.of(context).size.height * 0.27,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  flexibleSpace: Column(
                    children: [
                      SafeArea(
                        child: Stack(
                          children: [
                            Image.asset(
                              "assets/images/forgotbgnew.png",
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.19,
                              gaplessPlayback: true,
                              fit: BoxFit.fill,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop(null);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 30),
                                    child: Image.asset(
                                      "assets/images/back_arrow.png",
                                      width: 20,
                                      height: 17,
                                      gaplessPlayback: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 30.0, top: 30),
                                  child: Text("Followers",
                                      style: const TextStyle(
                                        color: CustColors.DarkBlue,
                                        fontSize: 18.0,
                                        fontFamily: 'Formular',
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 7),
                          indicatorPadding:
                              const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          indicatorColor: Colors.transparent,
                          isScrollable: true,
                          onTap: (index) {
                            print(index);
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          tabs: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: SizedBox(
                                  width: 130,
                                  height: 40,
                                  child: currentIndex == 0
                                      ? Container(
                                          decoration: const BoxDecoration(
                                              color: CustColors.DarkBlue,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Center(
                                              child: Text(
                                            "$numberOfFollowers Followers",
                                            style: Styles.textBoldwhite18,
                                          )),
                                        )
                                      : Container(
                                          decoration: const BoxDecoration(
                                              color: CustColors.lightgreyOff,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Center(
                                              child: Text(
                                            "$numberOfFollowers Followers",
                                            style: Styles.textHeadNormalBlue13,
                                          )),
                                        )),
                            ),
                            SizedBox(
                                width: 130,
                                height: 40,
                                child: currentIndex == 1
                                    ? Container(
                                        decoration: const BoxDecoration(
                                            color: CustColors.DarkBlue,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Center(
                                            child: Text(
                                          "$numberOfFollowings Following",
                                          style: Styles.textBoldwhite18,
                                        )),
                                      )
                                    : Container(
                                        decoration: const BoxDecoration(
                                            color: CustColors.lightgreyOff,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Center(
                                            child: Text(
                                          "$numberOfFollowings Following",
                                          style: Styles.textHeadNormalBlue13,
                                        )),
                                      )),
                          ],
                        ),
                      )
                    ],
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                ),
              ),
            ),
            body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    child: Column(
                      children: [
                        Flexible(
                          child: StreamBuilder(
                              stream: _myFollowersAndDonationsBloc
                                  .myFollowersRespStream,
                              builder: (context,
                                  AsyncSnapshot<FollowersResponseModel>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    snapshot.connectionState ==
                                        ConnectionState.none) {
                                  return Center(child: ProgressBarDarkBlue());
                                } else if (snapshot.hasData ||
                                    snapshot.data.data.data.isNotEmpty) {
                                  if (snapshot.data.status == 'error') {
                                    return noDataFound();
                                  } else if (snapshot.data.data.data.isEmpty) {
                                    return noDataFound();
                                  }
                                } else {
                                  return Center(child: ProgressBarDarkBlue());
                                }

                                return NotificationListener(
                                  // ignore: missing_return
                                  onNotification:
                                      (ScrollNotification scrollInfo) {
                                    if (!_myFollowersAndDonationsBloc
                                            .paginationLoading &&
                                        scrollInfo.metrics.pixels ==
                                            scrollInfo
                                                .metrics.maxScrollExtent) {
                                      // start loading data
                                      if (snapshot.data.data.currentPage <
                                          snapshot.data.data.totalPages) {
                                        setState(() {
                                          isLoadingFollowers = true;
                                        });
                                        final page =
                                            snapshot.data.data.currentPage + 1;
                                        _myFollowersAndDonationsBloc
                                            .MyFollowersAPI(
                                                page: page.toString());
                                      }
                                    }
                                  },

                                  child: RefreshIndicator(
                                    color: CustColors.DarkBlue,
                                    onRefresh: _pullRefresh,
                                    child: ListView.builder(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.data.data.length,
                                      itemBuilder: (context, index) {
                                        /*if ((index+1) == snapshot.data.data.data.length ) {//pagination loader
                                            return Container(
                                              padding: EdgeInsets.only(bottom: 10),
                                              child: snapshot.data.data.currentPage +1 < snapshot.data.data.totalPages
                                                  ? Center(child: ProgressBarDarkBlue(),) :  Container(),
                                            );
                                          }*/
                                        return ListTile(
                                          title: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 40.0,
                                                      height: 40.0,
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            child: snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .users
                                                                        .userProfile
                                                                        .isNotEmpty &&
                                                                    snapshot
                                                                            .data
                                                                            .data
                                                                            .data[index]
                                                                            .users
                                                                            .userProfile[0]
                                                                            .profilePic !=
                                                                        null
                                                                ? CachedNetworkImage(
                                                                    imageUrl: snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .users
                                                                        .userProfile[
                                                                            0]
                                                                        .profilePic,
                                                                    imageBuilder:
                                                                        (context,
                                                                                imageProvider) =>
                                                                            Container(
                                                                      width:
                                                                          40.0,
                                                                      height:
                                                                          40.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image: DecorationImage(
                                                                            image:
                                                                                imageProvider,
                                                                            fit:
                                                                                BoxFit.cover),
                                                                      ),
                                                                    ),
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20.0),
                                                                      child: displayProfilePic(snapshot
                                                                          .data
                                                                          .data
                                                                          .data[
                                                                              index]
                                                                          .users
                                                                          .displayName),
                                                                    ),
                                                                  )
                                                                : ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.0),
                                                                    child: displayProfilePic(snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .users
                                                                        .displayName),
                                                                  ),
                                                          ),
                                                          snapshot
                                                                      .data
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .users
                                                                      .userTypeId ==
                                                                  2
                                                              ? Align(
                                                                  alignment:
                                                                      AlignmentDirectional
                                                                          .bottomEnd,
                                                                  child:
                                                                      SizedBox(
                                                                    width: 20,
                                                                    height: 20,
                                                                    child: CircleAvatar(
                                                                        radius: 18,
                                                                        backgroundColor: Colors.white,
                                                                        child: ClipOval(
                                                                          child:
                                                                              Image.asset(
                                                                            'assets/images/core_member.png',
                                                                          ),
                                                                        )),
                                                                  ),
                                                                )
                                                              : Container(),
                                                        ],
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 3,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 10, 10, 10),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Column(
                                                            children: [
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 95,
                                                                      child:
                                                                          AutoSizeText(
                                                                        snapshot.data.data.data[index].users.userProfile.isNotEmpty &&
                                                                                snapshot.data.data.data[index].users.userProfile[0].aliasName != null &&
                                                                                snapshot.data.data.data[index].users.userProfile[0].aliasFlag == 1
                                                                            ? snapshot.data.data.data[index].users.userProfile[0].aliasName
                                                                            : snapshot.data.data.data[index].users.displayName,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Styles
                                                                            .textFollowerDisplayNameBlue25,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          if (snapshot.data.data.data[index].users.followUser.isEmpty ||
                                                                              (snapshot.data.data.data[index].users.followUser.isNotEmpty && snapshot.data.data.data[index].users.followUser[0].status == 2)) {
                                                                            _myFollowersAndDonationsBloc.followUserInFollowersList(snapshot.data.data.data[index].users.id.toString());
                                                                            setState(() {
                                                                              if (snapshot.data.data.data[index].users.followUser.isEmpty) {
                                                                                _myFollowersAndDonationsBloc.MyFollowersAPI(page: "0");
                                                                              } else {
                                                                                snapshot.data.data.data[index].users.followUser[0].status = 1;
                                                                              }
                                                                            });
                                                                          }
                                                                        },
                                                                        child:
                                                                            AutoSizeText(
                                                                          snapshot.data.data.data[index].users.followUser.isEmpty || (snapshot.data.data.data[index].users.followUser.isNotEmpty && snapshot.data.data.data[index].users.followUser[0].status == 2)
                                                                              ? followText
                                                                              : '',
                                                                          style:
                                                                              Styles.textFollowerDisplayNameBlue25,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        3,
                                                                        0,
                                                                        0),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      AutoSizeText(
                                                                    snapshot.data.data.data[index].users.userProfile.isNotEmpty &&
                                                                            snapshot.data.data.data[index].users.userProfile[0].aliasName !=
                                                                                null &&
                                                                            snapshot.data.data.data[index].users.userProfile[0].aliasFlag ==
                                                                                1
                                                                        ? ''
                                                                        : snapshot
                                                                            .data
                                                                            .data
                                                                            .data[index]
                                                                            .users
                                                                            .emailId,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    maxLines: 1,
                                                                    style: Styles
                                                                        .textFolloweremailId,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 22,
                                                      width: 75,
                                                      child: Visibility(
                                                        visible: snapshot
                                                                    .data
                                                                    .data
                                                                    .data[index]
                                                                    .users
                                                                    .followUser
                                                                    .isEmpty ||
                                                                (snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .users
                                                                        .followUser
                                                                        .isNotEmpty &&
                                                                    snapshot
                                                                            .data
                                                                            .data
                                                                            .data[index]
                                                                            .users
                                                                            .followUser[0]
                                                                            .status ==
                                                                        2)
                                                            ? true
                                                            : false,
                                                        child: FlatButton(
                                                          onPressed: () {
                                                            _myFollowersAndDonationsBloc
                                                                .removeUserInFollowersList(
                                                                    snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .users
                                                                        .id
                                                                        .toString());
                                                            setState(() {
                                                              snapshot.data.data
                                                                  .data
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                          },
                                                          textColor: CustColors
                                                              .LightDarkGray,
                                                          color: CustColors
                                                              .lightgreyOff,
                                                          child: const Text(
                                                            'Remove',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 10),
                                                          ),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          // onTap: () =>pubDetails(snapshot.data.data[index]),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }),
                        ),
                        isLoadingFollowers
                            ? Center(
                                child: ProgressBarDarkBlue(),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Flexible(
                          child: StreamBuilder(
                              stream: _myFollowersAndDonationsBloc
                                  .myFollowingRespStream,
                              builder: (context,
                                  AsyncSnapshot<FollowingsResponseModel>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    snapshot.connectionState ==
                                        ConnectionState.none) {
                                  return Center(child: ProgressBarDarkBlue());
                                } else if (snapshot.hasData ||
                                    snapshot.data.data.data.isNotEmpty) {
                                  if (snapshot.data.status == 'error') {
                                    return noDataFound();
                                  } else if (snapshot.data.data.data.isEmpty) {
                                    return noDataFound();
                                  }
                                } else {
                                  return Center(child: ProgressBarDarkBlue());
                                }

                                return NotificationListener(
                                  // ignore: missing_return
                                  onNotification:
                                      (ScrollNotification scrollInfo) {
                                    if (!_myFollowersAndDonationsBloc
                                            .paginationLoading &&
                                        scrollInfo.metrics.pixels ==
                                            scrollInfo
                                                .metrics.maxScrollExtent) {
                                      // start loading data
                                      if (snapshot.data.data.currentPage <
                                          snapshot.data.data.totalPages) {
                                        setState(() {
                                          isLoadingFollowings = true;
                                        });
                                        final page =
                                            snapshot.data.data.currentPage + 1;
                                        _myFollowersAndDonationsBloc
                                            .MyFollowingAPI(
                                                page: page.toString());
                                      }
                                    }
                                  },

                                  child: RefreshIndicator(
                                    color: CustColors.DarkBlue,
                                    onRefresh: _pullRefresh,
                                    child: ListView.builder(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.data.data.length,
                                      itemBuilder: (context, index) {
                                        /*if ((index+1) == snapshot.data.data.data.length ) {//pagination loader
                                            return Container(
                                              padding: EdgeInsets.only(bottom: 10),
                                              child: snapshot.data.data.currentPage +1 < snapshot.data.data.totalPages
                                                  ? Center(child: ProgressBarDarkBlue(),) :  Container(),
                                            );
                                          }*/
                                        return ListTile(
                                          trailing: PopupMenuButton<String>(
                                            padding: EdgeInsets.zero,
                                            offset: const Offset(0, 40),
                                            icon: const Icon(Icons.more_vert),
                                            onSelected: (result) async {
                                              switch (result) {
                                                case 'Unfollow':
                                                  print('index$index');
                                                  _myFollowersAndDonationsBloc
                                                      .unFollowUserInFollowingList(
                                                          snapshot
                                                              .data
                                                              .data
                                                              .data[index]
                                                              .followingUserId
                                                              .toString());
                                                  setState(() {
                                                    snapshot.data.data.data
                                                        .removeAt(index);
                                                  });
                                                  print('click Unfollow');
                                                  break;
                                                case 'Chat':
                                                  signIn(
                                                      "chat1voices@gmail.com",
                                                      "123456");

                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => SingleChatMsgPage(
                                                            senderid: id,
                                                            senderFcm:
                                                                senderFcm,
                                                            senderName:
                                                                userNameForSingleChat,
                                                            senderImage:
                                                                userProfilePic,
                                                            reciverid: snapshot
                                                                .data
                                                                .data
                                                                .data[index]
                                                                .followingUsers
                                                                .id
                                                                .toString(),
                                                            reciverFcm: snapshot
                                                                .data
                                                                .data
                                                                .data[index]
                                                                .followingUsers
                                                                .deviceId
                                                                .toString(),
                                                            reciverImage: snapshot.data.data.data[index].followingUsers.userProfile.isNotEmpty &&
                                                                    snapshot.data.data.data[index].followingUsers.userProfile[0].profilePic !=
                                                                        null
                                                                ? '${snapshot.data.data.data[index].followingUsers.userProfile[0].profilePic}'
                                                                : '',
                                                            reciverUserName: snapshot
                                                                        .data
                                                                        .data
                                                                        .data[index]
                                                                        .followingUsers
                                                                        .userProfile
                                                                        .isNotEmpty &&
                                                                    snapshot.data.data.data[index].followingUsers.userProfile[0].aliasName != null &&
                                                                    snapshot.data.data.data[index].followingUsers.userProfile[0].aliasFlag == 1
                                                                ? '${snapshot.data.data.data[index].followingUsers.userProfile[0].aliasName}'
                                                                : snapshot.data.data.data[index].followingUsers.displayName)),
                                                  );
                                                  print('click Chat');
                                                  break;
                                              }
                                            },
                                            itemBuilder:
                                                (BuildContext context) =>
                                                    <PopupMenuEntry<String>>[
                                              const PopupMenuItem<String>(
                                                  value: 'Unfollow',
                                                  child: ListTile(
                                                      title: Text('Unfollow'))),
                                              const PopupMenuItem<String>(
                                                  value: 'Chat',
                                                  child: ListTile(
                                                      title: Text('Chat'))),
                                            ],
                                          ),
                                          title: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 45.0,
                                                      height: 45.0,
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            child: snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .followingUsers
                                                                        .userProfile
                                                                        .isNotEmpty &&
                                                                    snapshot
                                                                            .data
                                                                            .data
                                                                            .data[index]
                                                                            .followingUsers
                                                                            .userProfile[0]
                                                                            .profilePic !=
                                                                        null
                                                                ? CachedNetworkImage(
                                                                    imageUrl: snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .followingUsers
                                                                        .userProfile[
                                                                            0]
                                                                        .profilePic,
                                                                    imageBuilder:
                                                                        (context,
                                                                                imageProvider) =>
                                                                            Container(
                                                                      width:
                                                                          40.0,
                                                                      height:
                                                                          40.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image: DecorationImage(
                                                                            image:
                                                                                imageProvider,
                                                                            fit:
                                                                                BoxFit.cover),
                                                                      ),
                                                                    ),
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20.0),
                                                                      child: displayProfilePic(snapshot
                                                                          .data
                                                                          .data
                                                                          .data[
                                                                              index]
                                                                          .followingUsers
                                                                          .displayName),
                                                                    ),
                                                                  )
                                                                : ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.0),
                                                                    child: displayProfilePic(snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .followingUsers
                                                                        .displayName),
                                                                  ),
                                                          ),
                                                          snapshot
                                                                      .data
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .followingUsers
                                                                      .userTypeId ==
                                                                  2
                                                              ? Align(
                                                                  alignment:
                                                                      AlignmentDirectional
                                                                          .bottomEnd,
                                                                  child:
                                                                      SizedBox(
                                                                    width: 20,
                                                                    height: 20,
                                                                    child: CircleAvatar(
                                                                        radius: 18,
                                                                        backgroundColor: Colors.white,
                                                                        child: ClipOval(
                                                                          child:
                                                                              Image.asset(
                                                                            'assets/images/core_member.png',
                                                                          ),
                                                                        )),
                                                                  ),
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 5,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 10, 3, 10),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Column(
                                                            children: [
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child:
                                                                    AutoSizeText(
                                                                  snapshot
                                                                              .data
                                                                              .data
                                                                              .data[
                                                                                  index]
                                                                              .followingUsers
                                                                              .userProfile
                                                                              .isNotEmpty &&
                                                                          snapshot.data.data.data[index].followingUsers.userProfile[0].aliasName !=
                                                                              null &&
                                                                          snapshot.data.data.data[index].followingUsers.userProfile[0].aliasName !=
                                                                              "" &&
                                                                          snapshot.data.data.data[index].followingUsers.userProfile[0].aliasFlag ==
                                                                              1
                                                                      ? '${snapshot.data.data.data[index].followingUsers.userProfile[0].aliasName}'
                                                                      : snapshot
                                                                          .data
                                                                          .data
                                                                          .data[
                                                                              index]
                                                                          .followingUsers
                                                                          .displayName,
                                                                  style: Styles
                                                                      .textFollowerDisplayNameBlue25,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        3,
                                                                        0,
                                                                        0),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      AutoSizeText(
                                                                    snapshot.data.data.data[index].followingUsers.userProfile.isNotEmpty &&
                                                                            snapshot.data.data.data[index].followingUsers.userProfile[0].aliasName !=
                                                                                null &&
                                                                            snapshot.data.data.data[index].followingUsers.userProfile[0].aliasName !=
                                                                                "" &&
                                                                            snapshot.data.data.data[index].followingUsers.userProfile[0].aliasFlag ==
                                                                                1
                                                                        ? ''
                                                                        : snapshot
                                                                            .data
                                                                            .data
                                                                            .data[index]
                                                                            .followingUsers
                                                                            .emailId,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: Styles
                                                                        .textFolloweremailId,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                      width: 76,
                                                      child: FlatButton(
                                                        onPressed: () {},
                                                        textColor: CustColors
                                                            .LightDarkGray,
                                                        color: CustColors
                                                            .lightgreyOff,
                                                        child: const Text(
                                                          'Following',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 10),
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          // onTap: () =>pubDetails(snapshot.data.data[index]),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }),
                        ),
                        isLoadingFollowings
                            ? Center(
                                child: ProgressBarDarkBlue(),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ],
    );
  }

  void toastMsg(String s) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(s),
      duration: const Duration(seconds: 1),
    ));
  }

  Widget noDataFound() {
    return SingleChildScrollView(
      child: Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/caseimagedummy.png',
                    width: 250, height: 250),
                const Text('No Data Found',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w200,
                        fontSize: 14,
                        color: Colors.blueGrey))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ProgressBarDarkBlue() {
    return SizedBox(
      height: 60.0,
      child: Center(
          child: CircularProgressIndicator(
        valueColor: const AlwaysStoppedAnimation<Color>(CustColors.DarkBlue),
      )),
    );
  }

  Widget ProgressBarLightRose() {
    return SizedBox(
      height: 60.0,
      child: Center(
          child: CircularProgressIndicator(
        valueColor: const AlwaysStoppedAnimation<Color>(CustColors.Radio),
      )),
    );
  }

  void listenApi() {
    _profileDetailsBloc.getUserDetailsStream.listen((data) {
      if ((data.status == "success")) {
        print(data.status);
        if (data.data.userProfile.isNotEmpty) {
          if (data.data.userProfile[0].profilePic != null) {
            userProfilePic = data.data.userProfile[0].profilePic;
          } else {
            userProfilePic = "";
          }
        } else {
          userProfilePic = '';
        }

        if (data.data.userProfile.isNotEmpty) {
          if (data.data.userProfile[0].aliasFlag == 1) {
            userNameForSingleChat = data.data.userProfile[0].aliasName;
          } else {
            userNameForSingleChat = data.data.userProfile[0].displayName;
          }
        } else {
          userNameForSingleChat = data.data.username;
        }
      } else if ((data.status == "error")) {}
    });
    _myFollowersAndDonationsBloc.myFollowersRespStream.listen((data) {
      if ((data.status == "success")) {
        print(" ${data.status}");
        setState(() {
          isLoadingFollowers = false;
          numberOfFollowers = " ${data.data.totalItems}";
        });
      } else if ((data.status == "error")) {
        print(data.status);
        setState(() {
          isLoadingFollowers = false;
        });
      }
    });
    _myFollowersAndDonationsBloc.myFollowingRespStream.listen((data) {
      if ((data.status == "success")) {
        print(" ${data.status}");
        setState(() {
          isLoadingFollowings = false;
          numberOfFollowings = " ${data.data.totalItems}";
        });
      } else if ((data.status == "error")) {
        print(data.status);
        setState(() {
          isLoadingFollowings = false;
        });
      }
    });
    _myFollowersAndDonationsBloc.unFollowRespStream.listen((data) {
      if ((data.status == "success")) {
        print(" ${data.status}");
      } else if ((data.status == "error")) {
        print(data.status);
      }
    });
    _myFollowersAndDonationsBloc.followRespStream.listen((data) {
      if ((data.status == "success")) {
        print("Follow ${data.status}");
        setState(() {});
      } else if ((data.status == "error")) {
        setState(() {});
        print(data.status);
      }
    });
    _myFollowersAndDonationsBloc.removeRespStream.listen((data) {
      if ((data.status == "success")) {
        print("Remove ${data.status}");
        setState(() {});
      } else if ((data.status == "error")) {
        setState(() {});
        print(data.status);
      }
    });
  }

  Widget displayProfilePic(String displayName) {
    String text = displayName.substring(0, 1);
    return CircularProfileAvatar(
      '',
      radius: 100, // sets radius, default 50.0
      backgroundColor:
          Colors.transparent, // sets background color, default Colors.white
      borderWidth: 10, // sets border, default 0.0
      initialsText: Text(
        text.toUpperCase(),
        style: const TextStyle(fontSize: 15, color: Colors.white),
      ), // sets initials text, set your own style, default Text('')
      borderColor:
          CustColors.DarkBlue, // sets border color, default Colors.white
      elevation:
          5.0, // sets elevation (shadow of the profile picture), default value is 0.0
      //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
      cacheImage: true, // allow widget to cache image against provided url
      onTap: () {
        print('adil');
      }, // sets on tap
      showInitialTextAbovePicture:
          true, // setting it true will show initials text above profile picture, default false
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {
      _myFollowersAndDonationsBloc.MyFollowersAPI(page: "0");
      _myFollowersAndDonationsBloc.MyFollowingAPI(page: "0");
    });
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }

  Future<User> signIn(String email, String password) async {
    try {
      final UserCredential authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      final User user = authResult.user;
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User currentUser = auth.currentUser;
      assert(user.uid == currentUser.uid);
      return user;
    } catch (e) {
      return null;
    }
  }
}
