import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Ui/BecomeProUser/BecomeProUserPage.dart';
import 'package:bring2book/Ui/LeaderBoard/LeaderBoardUi.dart';
import 'package:bring2book/Ui/MyFollowersAndDonationsProfile/MyFollowersListProfile.dart';
import 'package:bring2book/Ui/NotificationUi/NotificationPage.dart';
import 'package:bring2book/Ui/ProfileHomePage/EditProfilePage.dart';
import 'package:bring2book/Ui/ProfileHomePage/ChangePasswordPage.dart';
import 'package:bring2book/Ui/ProfileHomePage/ProfileDetailsBloc.dart';
import 'package:bring2book/Ui/SignInScreen/SignInActivity.dart';
import 'package:bring2book/Ui/MyFollowersAndDonationsProfile/MyDonationsProfile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constants/colorConstants.dart';

class ProfileMainHomePage extends StatefulWidget {
  @override
  _ProfileMainHomePageState createState() => _ProfileMainHomePageState();
}

class _ProfileMainHomePageState extends State<ProfileMainHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ProfileDetailsBloc _profileDetailsBloc = ProfileDetailsBloc();

  bool visible = false;

  String usertypeProOrNormal = '0';
  String userEmailVerifiedOrNot = 'Verify';
  bool isPro = false;
  String userProfilePic = '';
  String userProfileName = '';
  String userProfilePhone = '';
  String userProfileEmail = '';
  String userProfileAliasName = '';
  String userProfileAliasFlag = '0';
  String userProfileUserReward = '';

  bool statusSwitchShowHide = true;
  bool changepwdHide = true;

  int verifiedUser = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      visible = true;
    });
    _profileDetailsBloc.getUserDetails();
    listenApi();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: new AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: CustColors.DarkBlue,
              elevation: 0,
              brightness: Brightness.dark,
              flexibleSpace: SafeArea(
                child: Container(
                  color: Colors.white,
                  child: Image(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    image: AssetImage('assets/images/forgotbgnew.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                  child: Column(children: <Widget>[
                /* SafeArea(
                              child: Image(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.19,
                                image: AssetImage('assets/images/forgotbgnew.png'),
                                fit: BoxFit.cover,
                              ),
                            ),*/
                Container(
                    width: 120.0,
                    height: 120.0,
                    child: userProfilePic.isNotEmpty
                        ? Center(
                            child: CachedNetworkImage(
                                imageUrl: userProfilePic,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      width: 120.0,
                                      height: 120.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                placeholder: (context, url) => Container(
                                      width: 120.0,
                                      height: 120.0,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: displayProfilePicWhite(
                                            userProfileName),
                                      ),
                                    )))
                        : Container(
                            width: 120.0,
                            height: 120.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: displayProfilePicWhite(userProfileName),
                            ),
                          )
                    //                     ),
                    // CircleAvatar(
                    //     radius: 50,
                    //     backgroundColor: Colors.white,
                    //     child: ClipOval(
                    //       child: Image.asset(
                    //         'assets/images/dummy_image_user.png',
                    //       ),
                    //     ))
                    ),
                Container(
                  child: usertypeProOrNormal == '3' && verifiedUser == 3
                      ? InkWell(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Center(
                              child: Container(
                                width: 120.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                    color: CustColors.DarkGreen,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/diamond.png',
                                        width: 15, height: 15),
                                    Text(
                                      " Become a pro",
                                      style: Styles.homeCategoryNameswhite,
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BecomeProUserPage()),
                            );
                          },
                        )
                      : usertypeProOrNormal == '2'
                          ? Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Center(
                                child: Container(
                                  width: 120.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/diamond.png',
                                          width: 15, height: 15),
                                      Text(
                                        " ProUser",
                                        style: Styles.homeCategoryNameswhite,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            )
                          : usertypeProOrNormal == '3' && verifiedUser == 2
                              ? Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: Container(
                                      width: 160.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50))),
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              'assets/images/diamond.png',
                                              width: 15,
                                              height: 15),
                                          Text(
                                            " Requested as a pro user",
                                            style:
                                                Styles.homeCategoryNameswhite,
                                          ),
                                        ],
                                      )),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Center(
                                      child: Container(
                                        width: 120.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                            color: CustColors.DarkGreen,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                'assets/images/diamond.png',
                                                width: 15,
                                                height: 15),
                                            Text(
                                              " Become a pro",
                                              style:
                                                  Styles.homeCategoryNameswhite,
                                            ),
                                          ],
                                        )),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BecomeProUserPage()),
                                    );
                                  },
                                ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Center(
                      child: Text('$userProfileName',
                          style: Styles.textProfileNameBlue25)),
                ),
                Visibility(
                  visible: userProfileAliasName == '' ||
                          userProfileAliasName == null ||
                          userProfileAliasName == 'null'
                      ? false
                      : true,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Center(
                        child: Text('\@ $userProfileAliasName',
                            style: Styles.textProfileAliasNameGray)),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  child: Container(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'My Hero Points',
                            style: Styles.textProfileHeroPoints,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'P-$userProfileUserReward',
                            style: Styles.textProfileRewardPoints,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Account Information',
                              style: Styles.textProfileAcctInfoBlue25,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/profile_edit_dark_round.png"),
                                        fit: BoxFit.contain)),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/editnew.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfilePage()),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Image.asset(
                                    'assets/images/profile_alias_icon.png',
                                    width: 20,
                                    height: 20),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    'Alias',
                                    textAlign: TextAlign.start,
                                    style: Styles.textHeadProfileGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              children: [
                                Container(
                                  child: userProfileAliasFlag == '1'
                                      ? InkWell(
                                          onTap: () {
                                            _profileDetailsBloc
                                                .performEditAliasNameProfile(
                                                    userProfileName,
                                                    userProfileAliasName,
                                                    '2');
                                            setState(() {
                                              userProfileAliasFlag = '2';
                                            });
                                          },
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        30, 0, 0, 0),
                                                child: Container(
                                                  width: 60,
                                                  height: 25,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: CustColors
                                                            .LightGray,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: Center(
                                                        child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 0, 0, 0),
                                                      child: Text(
                                                        "Hide",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: Styles
                                                            .texthidedarknormal,
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 40, 0),
                                                child: Container(
                                                  width: 50,
                                                  height: 25,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            CustColors.DarkBlue,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: Center(
                                                        child: Text(
                                                      "Show",
                                                      style: Styles
                                                          .textFollowerDisplayNamenormal,
                                                    )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            _profileDetailsBloc
                                                .performEditAliasNameProfile(
                                                    userProfileName,
                                                    userProfileAliasName,
                                                    '1');
                                            setState(() {
                                              userProfileAliasFlag = '1';
                                            });
                                          },
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        30, 0, 0, 0),
                                                child: Container(
                                                  width: 60,
                                                  height: 25,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            CustColors.DarkBlue,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: Center(
                                                        child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 0, 0, 0),
                                                      child: Text(
                                                        "Hide",
                                                        style: Styles
                                                            .textFollowerDisplayNamenormal,
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 40, 0),
                                                child: Container(
                                                  width: 50,
                                                  height: 25,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: CustColors
                                                            .LightGray,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: Center(
                                                        child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 0, 0, 0),
                                                      child: Text(
                                                        "Show",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: Styles
                                                            .texthidedarknormal,
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: userProfilePhone == '' ||
                          userProfilePhone == null ||
                          userProfilePhone == 'null'
                      ? false
                      : true,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Image.asset('assets/images/profile_phone.png',
                                      width: 20, height: 20),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      'Phone',
                                      textAlign: TextAlign.start,
                                      style: Styles.textHeadProfileGray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                children: [
                                  Text(
                                    '$userProfilePhone',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Styles.textBlueProfilePhoneEmail,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Image.asset('assets/images/profile_email.png',
                                    width: 20, height: 20),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    'Email',
                                    textAlign: TextAlign.start,
                                    style: Styles.textHeadProfileGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '$userProfileEmail',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Styles.textBlueProfilePhoneEmail,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: userEmailVerifiedOrNot == '1'
                                        ? Text('Verified',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.end,
                                            style: new TextStyle(
                                              color: CustColors
                                                  .greenProfileEmailVerifiedText,
                                              fontSize: 16.0,
                                              fontFamily: 'Formular',
                                            ))
                                        : InkWell(
                                            onTap: () {
                                              _profileDetailsBloc
                                                  .performEmailVerify();
                                            },
                                            child: Text('Verify',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                textAlign: TextAlign.end,
                                                style: new TextStyle(
                                                  color: CustColors
                                                      .redProfileEmailNotVerifiedText,
                                                  fontSize: 16.0,
                                                  fontFamily: 'Formular',
                                                )),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LeaderBoardUi()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 22),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Image.asset('assets/images/leader.png',
                                      width: 20, height: 20),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      'Leader Board',
                                      textAlign: TextAlign.start,
                                      style: Styles.textHeadProfileGray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                                'assets/images/profile_arrow.png',
                                width: 10,
                                height: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyDonationsProfile()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 22),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Image.asset(
                                      'assets/images/profile_donations.png',
                                      width: 20,
                                      height: 20),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      'My donations',
                                      textAlign: TextAlign.start,
                                      style: Styles.textHeadProfileGray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                                'assets/images/profile_arrow.png',
                                width: 10,
                                height: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Image.asset(
                                      'assets/images/profile_notification.png',
                                      width: 20,
                                      height: 20),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      'Notifications',
                                      textAlign: TextAlign.start,
                                      style: Styles.textHeadProfileGray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                                'assets/images/profile_arrow.png',
                                width: 10,
                                height: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyFollowersListProfile()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Image.asset(
                                      'assets/images/profile_alias_icon.png',
                                      width: 20,
                                      height: 20),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      'Followers',
                                      textAlign: TextAlign.start,
                                      style: Styles.textHeadProfileGray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                                'assets/images/profile_arrow.png',
                                width: 10,
                                height: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: changepwdHide,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePasswordPage()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Image.asset(
                                        'assets/images/profile_changePwd.png',
                                        width: 20,
                                        height: 20),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        'Change password',
                                        textAlign: TextAlign.start,
                                        style: Styles.textHeadProfileGray,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                  'assets/images/profile_arrow.png',
                                  width: 10,
                                  height: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text("Logout?",
                                style: TextStyle(
                                  fontFamily: 'Formular',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: CustColors.DarkBlue,
                                )),
                            content: Text("Are you sure you want to logout?"),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                  textStyle: TextStyle(
                                    color: CustColors.DarkBlue,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  isDefaultAction: true,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel")),
                              CupertinoDialogAction(
                                  textStyle: TextStyle(
                                    color: CustColors.DarkBlue,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  isDefaultAction: true,
                                  onPressed: () async {
                                    setLogout();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignInActivity(
                                                  frompage: "0",
                                                )),
                                        ModalRoute.withName("/SignInActivity"));
                                  },
                                  child: Text("Logout")),
                            ],
                          );
                        });

                    /*showDialog(
                        context: context,
                        child: CupertinoAlertDialog(
                          title: Text("Logout?",
                              style: TextStyle(
                                fontFamily: 'Formular',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: CustColors.DarkBlue,
                              )),
                          content: Text("Are you sure you want to logout?"),
                          actions: <Widget>[
                            CupertinoDialogAction(
                                textStyle: TextStyle(
                                  color: CustColors.DarkBlue,
                                  fontWeight: FontWeight.normal,
                                ),
                                isDefaultAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            CupertinoDialogAction(
                                textStyle: TextStyle(
                                  color: CustColors.DarkBlue,
                                  fontWeight: FontWeight.normal,
                                ),
                                isDefaultAction: true,
                                onPressed: () async {
                                  setLogout();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignInActivity(
                                                frompage: "0",
                                              )),
                                      ModalRoute.withName("/SignInActivity"));
                                },
                                child: Text("Logout")),
                          ],
                        ));*/
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 30),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Image.asset(
                                      'assets/images/profile_logout.png',
                                      width: 20,
                                      height: 20),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      'Logout',
                                      textAlign: TextAlign.start,
                                      style: Styles.textHeadProfileGray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                                'assets/images/profile_arrow.png',
                                width: 10,
                                height: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ])),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                child: Visibility(
                    visible: visible,
                    child: Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 50, bottom: 30),
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                CustColors.DarkBlue),
                          )),
                    )),
              ),
            ],
          ),
        ));
  }

  toastMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    ));
  }

  Widget ProgressBarDarkBlue() {
    return Container(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(CustColors.DarkBlue),
      )),
    );
  }

  Widget ProgressBarLightRose() {
    return Container(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(CustColors.Radio),
      )),
    );
  }

  Widget displayProfilePicWhite(String displayName) {
    String text = '';
    // if (displayName != "" || displayName != null) {
    //   text = displayName.substring(0, 1);
    // }
    if (displayName.isNotEmpty) {
      text = displayName.substring(0, 1);
    }

    return CircularProfileAvatar(
      '',
      radius: 80, // sets radius, default 50.0
      backgroundColor:
          Colors.transparent, // sets background color, default Colors.white
      borderWidth: 10, // sets border, default 0.0
      initialsText: Text(
        text.toUpperCase(),
        style: TextStyle(fontSize: 15, color: Colors.white),
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

  void listenApi() {
    _profileDetailsBloc.getUserDetailsStream.listen((data) {
      if ((data.status == "success")) {
        print("${data.status}");

        if (data.data.proUsersData.length == 0) {
          isPro = false;
        } else {
          isPro = true;
          verifiedUser = data.data.proUsersData[0].verifiedUser;
        }
        if (data.data.userProfile.length != 0) {
          if (data.data.userProfile[0].profilePic != null) {
            userProfilePic = data.data.userProfile[0].profilePic;
          } else {
            userProfilePic = "";
          }
        } else {
          userProfilePic = '';
        }

        usertypeProOrNormal = data.data.userTypeId.toString();
        userEmailVerifiedOrNot = data.data.verificationStatus.toString();
        userProfilePhone = '${data.data.phone}';
        if (data.data.userProfile.length != 0) {
          userProfileAliasName = '${data.data.userProfile[0].aliasName}';
          userProfileName = '${data.data.userProfile[0].displayName}';
        } else {
          userProfileName = '${data.data.username}';
          userProfileAliasName = '';
        }
        setState(() {
          if (data.data.userProfile.length != 0) {
            userProfileAliasFlag = '${data.data.userProfile[0].aliasFlag}';
          } else {
            userProfileAliasFlag = '0';
          }
        });

        userProfileUserReward = '${data.data.heroPoints.toString()}';

        userProfileEmail = '${data.data.emailId}';
        if (data.data.userProfile.length != 0) {
          if (data.data.userProfile[0].aliasFlag == 1) {
            statusSwitchShowHide = true;
          } else if (data.data.userProfile[0].aliasFlag == 2) {
            statusSwitchShowHide = false;
          }
        }

        if (data.data.loginType == 1) {
          changepwdHide = true;
        } else if (data.data.loginType == 2) {
          changepwdHide = false;
        }

        setState(() {
          visible = false;
        });
      } else if ((data.status == "error")) {
        setState(() {
          visible = false;
        });
        toastMsg(data.message);
      }
    });

    _profileDetailsBloc.emailVerifyStream.listen((data) {
      if ((data.status == "success")) {
        print("${data.status}");
        toastMsg(data.message);
        setState(() {
          visible = false;
        });
      } else if ((data.status == "error")) {
        setState(() {
          visible = false;
        });
        toastMsg(data.message);
      }
    });

    _profileDetailsBloc.editAliasNameProfileStream.listen((data) {
      if ((data.status == "success")) {
        print("${data.status}");
        //toastMsg(data.message);
        setState(() {
          visible = false;
        });
      } else if ((data.status == "error")) {
        setState(() {
          visible = false;
        });
        //toastMsg(data.message);
      }
    });
  }

  void setLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKey.AUTH_TOKEN, '');
    prefs.setString(SharedPrefKey.FCM_TOKEN, '');
    prefs.setString(SharedPrefKey.OLD_FCM_TOKEN, '');
  }

  // Widget displayProfilePicWhite(String displayName) {
  //   String text = 'a';
  //   if (displayName != "" || displayName != null) {
  //     text = displayName.substring(0, 1);
  //   }

  //   return CircularProfileAvatar(
  //     'https://avata',
  //     radius: 80, // sets radius, default 50.0
  //     backgroundColor:
  //         Colors.transparent, // sets background color, default Colors.white
  //     borderWidth: 10, // sets border, default 0.0
  //     initialsText: Text(
  //       text.toUpperCase(),
  //       style: TextStyle(fontSize: 15, color: Colors.black),
  //     ), // sets initials text, set your own style, default Text('')
  //     borderColor: Colors.white, // sets border color, default Colors.white
  //     elevation:
  //         5.0, // sets elevation (shadow of the profile picture), default value is 0.0
  //     //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
  //     cacheImage: true, // allow widget to cache image against provided url
  //     onTap: () {
  //       print('adil');
  //     }, // sets on tap
  //     showInitialTextAbovePicture:
  //         true, // setting it true will show initials text above profile picture, default false
  //   );
  // }
}
