import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bring2book/Ui/ChatHomePage/SingleChatMsgPage.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:bring2book/Ui/ChatHomePage/GroupChatMsgPage.dart';
import 'package:bring2book/Ui/ProfileHomePage/ProfileDetailsBloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ProfileDetailsBloc _profileDetailsBloc = ProfileDetailsBloc();
  final _firebaseref = FirebaseDatabase.instance;
  String userNameForGroupChat = '';
  String userProfilePic = '';
  String id;
  String senderFcm;

  @override
  void initState() {
    super.initState();
    _profileDetailsBloc.getUserDetails();
    getData();
    listenApi();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString(SharedPrefKey.USER_ID);
    senderFcm = prefs.getString(SharedPrefKey.FCM_TOKEN);
    userNameForGroupChat = prefs.getString(SharedPrefKey.USER_NAME);
  }

  @override
  Widget build(BuildContext context) {
    _profileDetailsBloc.getUserDetails();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: CustColors.DarkBlue,
            elevation: 0,
            flexibleSpace: SafeArea(
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/forgotbgnew.png",
                      width: double.infinity,
                      height: 120,
                      gaplessPlayback: true,
                      fit: BoxFit.fill,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        'Chat',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: Styles.casesBoldBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Flexible(
                child: StreamBuilder(
                    stream: _firebaseref
                        .ref()
                        .child('RecentChats')
                        .child(FirebaseAuth.instance.currentUser.uid)
                        .onValue,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.connectionState == ConnectionState.none) {
                        return Center(child: ProgressBarDarkBlue());
                      } else if (snapshot.hasData &&
                          !snapshot.hasError &&
                          snapshot.data.snapshot.value != null) {
                        Map data = snapshot.data.snapshot.value;
                        List item = [];
                        data.forEach(
                            (index, data) => item.add({"key": index, ...data}));
                        item.sort(
                            (b, a) => a["timestamb"].compareTo(b["timestamb"]));

                        return ListView.builder(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: item.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  if (item[index]['messageType'] == '1') {
                                    signIn("chat1voices@gmail.com", "123456");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SingleChatMsgPage(
                                                  senderid: id,
                                                  senderFcm: senderFcm,
                                                  senderName:
                                                      userNameForGroupChat,
                                                  senderImage: userProfilePic,
                                                  reciverid: item[index]
                                                          ['userId']
                                                      .toString(),
                                                  reciverFcm: item[index]
                                                          ['userFcm']
                                                      .toString(),
                                                  reciverImage: item[index]
                                                      ['userimage'],
                                                  reciverUserName: item[index]
                                                          ['username']
                                                      .toString(),
                                                )));
                                  } else {
                                    signIn("chat1voices@gmail.com", "123456");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GroupChatMsgPage(
                                                  caseId: item[index]['caseId']
                                                      .toString(),
                                                  caseTitleForGroupChat:
                                                      item[index]['caseName']
                                                          .toString(),
                                                  caseImage: item[index]
                                                      ['caseImage'],
                                                  senderId: id,
                                                  senderName:
                                                      userNameForGroupChat)),
                                    );
                                  }
                                },
                                title: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          item[index]['messageType'] == '1'
                                              ? SizedBox(
                                                  width: 45.0,
                                                  height: 45.0,
                                                  child: item[index]
                                                              ['userimage'] !=
                                                          ""
                                                      ? CachedNetworkImage(
                                                          imageUrl: item[index]
                                                              ['userimage'],
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            width: 45.0,
                                                            height: 45.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                          ),
                                                          placeholder:
                                                              (context, url) =>
                                                                  ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                            child: displayProfilePic(
                                                                item[index][
                                                                        'username']
                                                                    .toString()),
                                                          ),
                                                        )
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          child: displayProfilePic(
                                                              item[index][
                                                                      'username']
                                                                  .toString()),
                                                        ),
                                                )
                                              : SizedBox(
                                                  width: 45.0,
                                                  height: 45.0,
                                                  child: item[index]
                                                              ['caseImage'] !=
                                                          ""
                                                      ? SizedBox(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                              child:
                                                                  CircleAvatar(
                                                                      radius:
                                                                          50,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      child:
                                                                          ClipOval(
                                                                        child: Image
                                                                            .asset(
                                                                          item[index]
                                                                              [
                                                                              'caseImage'],
                                                                        ),
                                                                      ))),
                                                        )
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          child: displayProfilePic(
                                                              item[index][
                                                                      'caseName']
                                                                  .toString()),
                                                        ),
                                                ),
                                          Flexible(
                                            flex: 5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 3, 10),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  children: [
                                                    item[index]['messageType'] ==
                                                            '1'
                                                        ? Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: AutoSizeText(
                                                              item[index][
                                                                      'username']
                                                                  .toString(),
                                                              style: Styles
                                                                  .textRecentChatDisplayNameBlue25,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          )
                                                        : Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: AutoSizeText(
                                                              item[index][
                                                                      'caseName']
                                                                  .toString(),
                                                              style: Styles
                                                                  .textRecentChatDisplayNameBlue25,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                    item[index]['messageType'] ==
                                                            '1'
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0, 5, 0, 0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child:
                                                                  AutoSizeText(
                                                                item[index]['senderid']
                                                                            .toString() ==
                                                                        id
                                                                    ? 'you: ${item[index]['message'].toString()}'
                                                                    : '${item[index]['username'].toString()}: ${item[index]['message'].toString()}',
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
                                                          )
                                                        : StreamBuilder(
                                                            stream: _firebaseref
                                                                .ref()
                                                                .child(
                                                                    'RecentChats')
                                                                .child(
                                                                    item[index]
                                                                        ['key'])
                                                                .onValue,
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot.connectionState ==
                                                                      ConnectionState
                                                                          .waiting ||
                                                                  snapshot.connectionState ==
                                                                      ConnectionState
                                                                          .none) {
                                                                return const Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      AutoSizeText(
                                                                    "",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: Styles
                                                                        .textRecentChatMessage,
                                                                  ),
                                                                );
                                                              } else if (snapshot
                                                                      .hasData &&
                                                                  !snapshot
                                                                      .hasError &&
                                                                  snapshot
                                                                          .data
                                                                          .snapshot
                                                                          .value !=
                                                                      null) {
                                                                return Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      AutoSizeText(
                                                                    snapshot.data.snapshot.value["senderId"].toString() ==
                                                                            id
                                                                        ? 'you: ${snapshot.data.snapshot.value["message"].toString()}'
                                                                        : '${snapshot.data.snapshot.value["senderName"].toString()}: ${snapshot.data.snapshot.value["message"].toString()}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: Styles
                                                                        .textRecentChatMessage,
                                                                  ),
                                                                );
                                                              } else {
                                                                return const Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      AutoSizeText(
                                                                    "",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: Styles
                                                                        .textRecentChatMessage,
                                                                  ),
                                                                );
                                                              }
                                                            }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return noDataFound();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  toastMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
    ));
  }

  Widget ProgressBarDarkBlue() {
    return const SizedBox(
      height: 60.0,
      child: Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(CustColors.DarkBlue),
      )),
    );
  }

  Widget ProgressBarLightRose() {
    return const SizedBox(
      height: 60.0,
      child: Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(CustColors.Radio),
      )),
    );
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
                const Text('No Chats Found',
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
            userNameForGroupChat = data.data.userProfile[0].aliasName;
          } else {
            userNameForGroupChat = data.data.userProfile[0].displayName;
          }
        } else {
          userNameForGroupChat = data.data.username;
        }
      } else if ((data.status == "error")) {}
    });
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
