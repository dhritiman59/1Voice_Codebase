import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Models/CaseDetails/CaseDetailsModel.dart';
import 'package:bring2book/Models/Follow/Follow.dart';
import 'package:bring2book/Models/GetComments/GetCommentsModel.dart';
import 'package:bring2book/Models/IsFollow/IsFollow.dart';
import 'package:bring2book/Models/RankComment/RankCommentModel.dart';
import 'package:bring2book/Models/RankUpDown/RankCaseDown.dart';
import 'package:bring2book/Models/RankUpDown/RankUpDown.dart';
import 'package:bring2book/Models/Share/ShareModel.dart';
import 'package:bring2book/Ui/ViewMore//ViewMoreComments.dart';
import 'package:bring2book/Ui/CardListPage/CardListPage.dart';
import 'package:bring2book/Ui/CaseDetails/CaseDetailsBloc.dart';
import 'package:bring2book/Ui/ChatHomePage/GroupChatMsgPage.dart';
import 'package:bring2book/Ui/CoreMemberSelection/CoreMemberSelectionUi.dart';
import 'package:bring2book/Ui/CoreMembersList/CoreMembersUi.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constants/colorConstants.dart';
import '../../Models/CaseDetails/CaseDetailsModel.dart';
import 'package:video_player/video_player.dart';

import 'package:bring2book/Constants/colorConstants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CaseDetailsPage extends StatefulWidget {
  final String caseId;
  final int userId;
  final String caseNetworkImage;
  final String caseVideoImage;
  final String bannerImage;

  const CaseDetailsPage(
      {this.caseId,
      this.userId,
      this.caseNetworkImage,
      this.bannerImage,
      this.caseVideoImage});
  @override
  _State createState() => _State(caseId: caseId, userId: userId);
}

class _State extends State<CaseDetailsPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  final String caseId;
  final int userId;
  _State({this.caseId, this.userId});
  bool voteUpClicked;
  TextEditingController commentReport = TextEditingController();
  TextEditingController commentUserReport = TextEditingController();
  final FocusNode _commentFocus = FocusNode();
  String join = 'assets/images/join_grey_icon.png';
  String leave = 'assets/images/leave.png';
  String joinLeave;
  String voteUpColored = 'assets/images/coloredUp.png';
  String voteUp = 'assets/images/vote_up_icon.png';
  String voteDownColored = 'assets/images/coloredDown.png';
  String voteDown = 'assets/images/vote_down_icon.png';
  bool visibility = false;
  String follow = 'Follow';
  double heightofappbar = 210;
  bool view;
  bool up;
  bool down;
  String firstHalf;
  String name = 'v';
  String secondHalf;
  CaseDetailsBloc bloc = CaseDetailsBloc();
  CaseDetailsModel _caseDetailsModel;
  GetCommentsModel model = GetCommentsModel();
  ShareModel shareModel = ShareModel();
  RankUpDown rankUpDown = RankUpDown();
  RankCaseDown rankCaseDown = RankCaseDown();
  RankCommentModel rankCommentModel = RankCommentModel();
  Follow followModel = Follow();
  IsFollow isFollow = IsFollow();
  bool flag = true;
  bool joinBool = false;
  bool coreMember = false;
  bool isAdmin = false;
  // String Category = "";
  // String caseTitle = '';
  // String createdAt = '';

  String userNameForGroupChat = '';
  String caseTitleForGroupChat = '';

  String caseOwnerStatus = '';
  String caseDescription = '';
  String caseStatus;
  String followStatus = 'Follow';
  int _selectedIndex;
  String userTypeId;
  String id;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> notes = [
    "fluttermaster.com",
    "Update Android Studio to 3.3",
    "Implement ListView widget",
  ];
  List<String> imagePaths = [];

  StateSetter myReportComment1, myReportUserComment1;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.caseVideoImage);
    _initializeVideoPlayerFuture = _controller.initialize();

    if (widget.caseVideoImage != "") {
      _controller.play();
      _controller.setLooping(true);
    }

    getData();
    visibility = true;
    bloc.getCaseDetails(caseId);
    bloc.isFollowUser(userId);
    // bloc.getAllComments('1');
    bloc.getAllComments1(caseId, '0');
    if (caseDescription.length > 10) {
      if (caseDescription.length < 50) {
        firstHalf = caseDescription.substring(0, caseDescription.length - 1);
        secondHalf = caseDescription.substring(
            caseDescription.length - 1, caseDescription.length);
      } else {
        firstHalf = caseDescription.substring(0, caseDescription.length - 1);
        secondHalf = caseDescription.substring(
            caseDescription.length - 1, caseDescription.length);
      }
    } else {
      firstHalf = caseDescription;
      secondHalf = "";
    }

    listen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: caseDetailBody(),
    );
  }

  Widget caseDetailBody() {
    return Stack(
      children: [
        _buildBannerChild(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  child: bloc.caseStatus == '3'
                      ? const Align(
                          alignment: Alignment.center,
                          child: Text("CLOSED",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CustColors.DarkBlue,
                                fontSize: 15.0,
                              )),
                        )
                      : bloc.caseStatus == '2'
                          ? const Align(
                              alignment: Alignment.center,
                              child: Text("Waiting for approval",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CustColors.DarkBlue,
                                    fontSize: 15.0,
                                  )),
                            )
                          : bloc.caseStatus == '4'
                              ? const Align(
                                  alignment: Alignment.center,
                                  child: Text("REJECTED",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: CustColors.DarkBlue,
                                        fontSize: 15.0,
                                      )),
                                )
                              : InkWell(
                                  onTap: () {
                                    String join;
                                    if (_caseDetailsModel
                                        .data.usersRef.joinedUser.isEmpty) {
                                      join = '0';
                                    } else {
                                      join = '1';
                                    }
                                    if (_caseDetailsModel
                                            .data.usersRef.caseTypeFlag ==
                                        1) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CoreMembersUi(
                                                      caseId,
                                                      join,
                                                      _caseDetailsModel.data
                                                          .usersRef.caseTypeFlag
                                                          .toString(),
                                                      _caseDetailsModel
                                                          .data.usersRef.userId
                                                          .toString())));
                                    } else if (_caseDetailsModel
                                            .data.usersRef.caseTypeFlag ==
                                        2) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CoreMembersSelectionUi(
                                                      caseId,
                                                      join,
                                                      _caseDetailsModel.data
                                                          .usersRef.caseTypeFlag
                                                          .toString(),
                                                      _caseDetailsModel
                                                          .data.usersRef.userId
                                                          .toString())));
                                    }
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 150,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text("Core Member  ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: CustColors.DarkBlue,
                                                fontSize: 15.0,
                                              )),
                                          Image.asset(
                                            "assets/images/core_member.png",
                                            width: 25,
                                            height: 25,
                                            fit: BoxFit.contain,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                ),
              ),
            ],
            automaticallyImplyLeading: false,
            title: const Text(
              "",
              style: TextStyle(color: Colors.amber),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: Container(
                child: bloc.isArrowVisible
                    ? InkWell(
                        child: Container(),
                        onTap: () {
                          Navigator.pop(context);
                        })
                    : IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: CustColors.DarkBlue,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: Stack(
            children: [
              caseDetailsPageui(),
            ],
          ),

          /*  floatingActionButton: Align(
              alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,top: 100),
                  child: _buildFloatingActionButton(),
                )
            ),*/
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    if (widget.caseNetworkImage != "") {
      return Container();
    } else if (widget.caseVideoImage != "") {
      return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              color: Colors.transparent,
              height: 50,
              child: FloatingActionButton(
                backgroundColor: CustColors.Radio,
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      );
    } else if (widget.bannerImage != "") {
      return Container();
    } else {
      return Container();
    }
  }

  Widget _buildBannerChild() {
    if (widget.caseNetworkImage != "") {
      return CachedNetworkImage(
        imageUrl: widget.caseNetworkImage,
        imageBuilder: (context, imageProvider) => Container(
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
          ),
        ),
        //placeholder: (context, url) => ProgressBarLightRose(),
      );
    } else if (widget.caseVideoImage != "") {
      return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Container(
                  color: Colors.black87,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ],
            );
          } else {
            return Container(
              color: Colors.black87,
              height: MediaQuery.of(context).size.height / 2,
              child: const Center(
                  child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(CustColors.Radio),
                ),
              )),
            );
          }
        },
      );
    } else if (widget.bannerImage != "") {
      return Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.bannerImage),
              fit: BoxFit.fill,
              //alignment: Alignment.topCenter
            ),
            color: Colors.blueAccent),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/casedetailsHuman.png'),
              fit: BoxFit.fill,
              //alignment: Alignment.topCenter
            ),
            color: Colors.blueAccent),
      );
    }
  }

  Widget caseDetailsPageui() {
    return StreamBuilder(
        stream: bloc.details,
        builder: (context, AsyncSnapshot<CaseDetailsModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none) {
            return Center(child: ProgressBarDarkBlue());
          } else if (snapshot.hasData) {
            if (snapshot.data.status == 'error') {
              return noDataFound();
            } else {
              caseOwnerStatus = snapshot.data.data.usersRef.userId.toString();
              caseTitleForGroupChat = snapshot.data.data.usersRef.caseTitle;
              caseDescription =
                  snapshot.data.data.usersRef.caseDescription + "    ";
              name = snapshot.data.data.usersRef.users.displayName;
              if (caseDescription.length > 10) {
                if (caseDescription.length < 50) {
                  firstHalf =
                      caseDescription.substring(0, caseDescription.length - 1);
                  secondHalf = caseDescription.substring(
                      caseDescription.length - 1, caseDescription.length);
                } else {
                  firstHalf =
                      caseDescription.substring(0, caseDescription.length - 1);
                  secondHalf = caseDescription.substring(
                      caseDescription.length - 1, caseDescription.length);
                }
              } else {
                firstHalf = caseDescription;
                secondHalf = "";
              }
              return NotificationListener(
                // ignore: missing_return
                onNotification: (ScrollNotification scrollInfo) {
                  if (!bloc.paginationLoading &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    if (model.data.currentPage < model.data.totalPages) {
                      final page = model.data.currentPage + 1;
                      bloc.getAllComments1(caseId, page.toString());
                    }
                  }
                },
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(
                          top: 0,
                          bottom: 0,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 2 -
                                      110,
                                  bottom: 0),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Colors.white,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 30, 10, 0),
                                        child: Text(
                                          snapshot.data.data.usersRef.caseTitle
                                              .toString(),
                                          style: Styles.textHeadNormalBlue22,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 10, 0),
                                      child: Container(
                                        child: secondHalf.isEmpty
                                            ? Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(firstHalf,
                                                    style: const TextStyle(
                                                        color:
                                                            CustColors.TextGray,
                                                        fontSize: 16)),
                                              )
                                            : Column(
                                                children: <Widget>[
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                        flag
                                                            ? (firstHalf + "")
                                                            : (firstHalf +
                                                                secondHalf),
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: CustColors
                                                                .TextGray)),
                                                  ),
                                                  InkWell(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        Text(
                                                          flag
                                                              ? "Read more…."
                                                              : "Read less....",
                                                          style: const TextStyle(
                                                              color: CustColors
                                                                  .DarkBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        flag = !flag;
                                                        print(flag);
                                                      });
                                                    },
                                                  ),
                                                  flag == true
                                                      ? const Text("")
                                                      : _expandText(
                                                          snapshot.data)
                                                ],
                                              ),
                                      ),
                                    ),
                                    actionsSectionUi(snapshot.data),
                                    dateCategorySection(snapshot.data),
                                    fundraiserSectionUi(snapshot.data),
                                    donationRecievedSectionUi(snapshot.data)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 2 -
                                    130,
                                bottom: 0),
                            child: _buildFloatingActionButton(),
                          )),
                    ],
                  ),
                ),
              );
            }
          } else {
            return Center(child: ProgressBarDarkBlue());
          }
        });
  }

  Widget actionsSectionUi(CaseDetailsModel _caseDetailsModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 10, 0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Row(
                children: [
                  InkWell(
                    child:
                        setVoteDown(_caseDetailsModel.data.usersRef.rankCase),
                    onTap: () {
                      if (bloc.caseStatus == '3') {
                        toastMsg('This Case is already closed');
                      } else if (bloc.caseStatus == '2') {
                        toastMsg('This Case is not accepted');
                      } else if (bloc.caseStatus == '4') {
                        toastMsg('This Case is already rejected');
                      } else {
                        voteUpClicked = false;
                        if (_caseDetailsModel
                            .data.usersRef.rankCase.isNotEmpty) {
                          if (_caseDetailsModel
                                  .data.usersRef.rankCase[0].status ==
                              2) {
                            toastMsg("Already Ranked");
                          } else {
                            bloc.rankDown(caseId);
                            setState(() {
                              _caseDetailsModel
                                  .data.usersRef.rankCase[0].status = 2;
                              _caseDetailsModel.data.usersRef.rankCount =
                                  _caseDetailsModel.data.usersRef.rankCount - 2;
                            });
                          }
                        } else {
                          bloc.rankDown(caseId);
                          setState(() {
                            RankCase _rankCase =
                                RankCase(caseId: int.parse(caseId), status: 2);
                            _caseDetailsModel.data.usersRef.rankCase
                                .add(_rankCase);
                            _caseDetailsModel.data.usersRef.rankCount =
                                _caseDetailsModel.data.usersRef.rankCount - 1;
                          });
                        }
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        _caseDetailsModel.data.usersRef.rankCount.toString(),
                        style: const TextStyle(
                            color: Colors.blueGrey, fontSize: 14),
                        minFontSize: 10,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  InkWell(
                      child:
                          setVoteUp(_caseDetailsModel.data.usersRef.rankCase),
                      onTap: () {
                        if (bloc.caseStatus == '3') {
                          toastMsg('This Case is already closed');
                        } else if (bloc.caseStatus == '2') {
                          toastMsg('This Case is not accepted');
                        } else if (bloc.caseStatus == '4') {
                          toastMsg('This Case is already Rejected');
                        } else {
                          voteUpClicked = true;
                          if (_caseDetailsModel
                              .data.usersRef.rankCase.isNotEmpty) {
                            if (_caseDetailsModel
                                    .data.usersRef.rankCase[0].status ==
                                1) {
                              toastMsg("Already Ranked");
                            } else {
                              bloc.rankUp(caseId);
                              setState(() {
                                _caseDetailsModel
                                    .data.usersRef.rankCase[0].status = 1;
                                _caseDetailsModel.data.usersRef.rankCount =
                                    _caseDetailsModel.data.usersRef.rankCount +
                                        2;
                              });
                            }
                          } else {
                            bloc.rankUp(caseId);
                            setState(() {
                              RankCase _rankCase = RankCase(
                                  caseId: int.parse(caseId), status: 1);
                              _caseDetailsModel.data.usersRef.rankCase
                                  .add(_rankCase);
                              _caseDetailsModel.data.usersRef.rankCount =
                                  _caseDetailsModel.data.usersRef.rankCount + 1;
                            });
                          }
                        }
                      }),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset('assets/images/commenticonsmall.png',
                        width: 20, height: 20),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Align(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          _caseDetailsModel.data.usersRef.commentCount
                              .toString(),
                          style: const TextStyle(
                              color: Colors.blueGrey, fontSize: 14),
                          minFontSize: 10,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  if (bloc.caseStatus == '2') {
                    toastMsg('This Case is not accepted');
                  } else if (bloc.caseStatus == '4') {
                    toastMsg('This Case is already rejected');
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Share Case"),
                            content: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    child: Image.asset(
                                        'assets/images/mobile-phone.png',
                                        width: 70,
                                        height: 70),
                                    onTap: () {
                                      bloc.shareCase(caseId);

                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    child: Image.asset(
                                        'assets/images/social-media.png',
                                        width: 70,
                                        height: 70),
                                    onTap: () {
                                      urlFileShare(_caseDetailsModel);
                                      Navigator.pop(context);
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        });

                    /*    showDialog(
                        context: context,
                        child: new AlertDialog(
                          title: new Text("Share Case"),
                          content: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  child: Image.asset(
                                      'assets/images/mobile-phone.png',
                                      width: 70,
                                      height: 70),
                                  onTap: () {
                                    bloc.shareCase(caseId);

                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  child: Image.asset(
                                      'assets/images/social-media.png',
                                      width: 70,
                                      height: 70),
                                  onTap: () {
                                    urlFileShare(_caseDetailsModel);
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                            ],
                          ),
                        ));*/
                  }
                },
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset('assets/images/shareiconsmall.png',
                          width: 20, height: 20),
                    ),
                    const Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            'Share',
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 14),
                            minFontSize: 10,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                if (bloc.caseStatus == '3') {
                  toastMsg('Case is closed');
                } else if (bloc.caseStatus == '2') {
                  toastMsg('This Case is not accepted');
                } else if (bloc.caseStatus == '4') {
                  toastMsg('Case is rejected');
                } else {
                  if (caseStatus == 'Join') {
                    bloc.joinCase(
                        _caseDetailsModel.data.usersRef.id.toString());
                    setState(() {
                      _caseDetailsModel.data.usersRef.joinedUser.length = 1;
                      _caseDetailsModel.data.usersRef.rankCount =
                          _caseDetailsModel.data.usersRef.rankCount;
                    });
                  } else {
                    bloc.leaveCase(
                        _caseDetailsModel.data.usersRef.id.toString());
                    setState(() {
                      _caseDetailsModel.data.usersRef.joinedUser.length = 0;
                      _caseDetailsModel.data.usersRef.rankCount =
                          _caseDetailsModel.data.usersRef.rankCount;
                    });
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: id != _caseDetailsModel.data.usersRef.userId.toString()
                    ? Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: setJoinedImage(
                                _caseDetailsModel.data.usersRef.joinedUser),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Align(
                                alignment: Alignment.center,
                                child: setJoinText(
                                    _caseDetailsModel.data.usersRef.joinedUser),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dateCategorySection(CaseDetailsModel _caseDetailsModel) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisSize: MainAxisSize.max,
          //   children: [
          //     SizedBox(
          //       width: 30,
          //     ),
          //     Container(
          //       child: Row(
          //         children: <Widget>[
          //           Text('Country:',
          //               style: new TextStyle(
          //                   fontSize: 14.0,
          //                   fontWeight: FontWeight.w600,
          //                   color: CustColors.Grey)),
          //           Text(_caseDetailsModel.data.usersRef.country.toString(),
          //               style: new TextStyle(
          //                   fontSize: 12.0,
          //                   fontWeight: FontWeight.w600,
          //                   color: CustColors.DarkBlueLight)),
          //         ],
          //       ),
          //     ),
          //     // SizedBox(
          //     //   width: 20,
          //     // ),
          //     // //Padding(
          //     // //  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
          //     // Container(
          //     //   margin: EdgeInsets.only(top: 20),
          //     //   child: Image.asset('assets/images/view.png',
          //     //       width: 10, height: 40),
          //     // ),
          //     // SizedBox(
          //     //   width: 20,
          //     // ),
          //     //  ),
          //     Expanded(flex: 3, child: Container()),
          //     Container(
          //       child: Row(
          //         children: <Widget>[
          //           Text('State:',
          //               style: new TextStyle(
          //                   fontSize: 14.0,
          //                   fontWeight: FontWeight.w600,
          //                   color: CustColors.Grey)),
          //           Text(_caseDetailsModel.data.usersRef.state.toString(),
          //               style: new TextStyle(
          //                   fontSize: 12.0,
          //                   fontWeight: FontWeight.w600,
          //                   color: CustColors.DarkBlueLight)),
          //         ],
          //       ),
          //     ),
          //     Expanded(flex: 2, child: Container()),
          //     SizedBox(
          //       width: 10,
          //     )
          //   ],
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(3.0),
          //   child: Row(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(top: 5, left: 25),
          //         child: Text('Country:',
          //             style: new TextStyle(
          //                 fontSize: 14.0,
          //                 fontWeight: FontWeight.w600,
          //                 color: CustColors.Grey)),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 5, left: 5),
          //         child: Text(
          //             _caseDetailsModel.data.usersRef.country.toString(),
          //             style: new TextStyle(
          //                 fontSize: 12.0,
          //                 fontWeight: FontWeight.w600,
          //                 color: CustColors.DarkBlueLight)),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 5, left: 45),
          //         child: Text('State:',
          //             style: new TextStyle(
          //                 fontSize: 14.0,
          //                 fontWeight: FontWeight.w600,
          //                 color: CustColors.Grey)),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 5, left: 5),
          //         child: Text(_caseDetailsModel.data.usersRef.state.toString(),
          //             style: new TextStyle(
          //                 fontSize: 12.0,
          //                 fontWeight: FontWeight.w600,
          //                 color: CustColors.DarkBlueLight)),
          //       ),
          //     ],
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text('Country:',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: CustColors.Grey)),
                      Text(_caseDetailsModel.data.usersRef.country.toString(),
                          style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: CustColors.DarkBlueLight)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Image.asset('assets/images/menu.png',
                            width: 15, height: 15),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text("Category",
                                style: TextStyle(
                                    fontSize: 14.0, color: CustColors.Grey)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                            ),
                            child: Text(
                                _caseDetailsModel.data.usersRef.caseCategory
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: CustColors.DarkBlue)),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )),
              const SizedBox(
                width: 20,
              ),
              //Padding(
              //  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Image.asset('assets/images/view.png',
                    width: 10, height: 100),
              ),
              const SizedBox(
                width: 20,
              ),
              //  ),
              Container(
                  child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text('State:',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: CustColors.Grey)),
                      Text(_caseDetailsModel.data.usersRef.state.toString(),
                          style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: CustColors.DarkBlueLight)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Image.asset('assets/images/date.png',
                            width: 15, height: 15),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text("Date",
                                style: TextStyle(
                                    fontSize: 14.0, color: CustColors.Grey)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                                _caseDetailsModel.data.usersRef.createdAt
                                    .toString()
                                    .substring(0, 10),
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: CustColors.DarkBlue)),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ],
      ),
    );
  }

  //  Widget dateCategorySection(CaseDetailsModel _caseDetailsModel) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 15),
  //     child: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(3.0),
  //           child: Row(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 5, left: 25),
  //                 child: Text('Country:',
  //                     style: new TextStyle(
  //                         fontSize: 14.0,
  //                         fontWeight: FontWeight.w600,
  //                         color: CustColors.Grey)),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 5, left: 5),
  //                 child: Text(
  //                     _caseDetailsModel.data.usersRef.country.toString(),
  //                     style: new TextStyle(
  //                         fontSize: 12.0,
  //                         fontWeight: FontWeight.w600,
  //                         color: CustColors.DarkBlueLight)),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 5, left: 45),
  //                 child: Text('State:',
  //                     style: new TextStyle(
  //                         fontSize: 14.0,
  //                         fontWeight: FontWeight.w600,
  //                         color: CustColors.Grey)),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 5, left: 5),
  //                 child: Text(_caseDetailsModel.data.usersRef.state.toString(),
  //                     style: new TextStyle(
  //                         fontSize: 12.0,
  //                         fontWeight: FontWeight.w600,
  //                         color: CustColors.DarkBlueLight)),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             SizedBox(
  //               width: 30,
  //             ),
  //             Container(
  //               child: Row(
  //                 children: <Widget>[
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 8),
  //                     child: Image.asset('assets/images/menu.png',
  //                         width: 15, height: 15),
  //                   ),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 20),
  //                         child: Text("Category",
  //                             style: new TextStyle(
  //                                 fontSize: 14.0, color: CustColors.Grey)),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(
  //                           top: 5,
  //                         ),
  //                         child: Text(
  //                             _caseDetailsModel.data.usersRef.caseCategory
  //                                 .toString(),
  //                             style: new TextStyle(
  //                                 fontSize: 12.0,
  //                                 fontWeight: FontWeight.w600,
  //                                 color: CustColors.DarkBlue)),
  //                       )
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               width: 20,
  //             ),
  //             //Padding(
  //             //  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
  //             Container(
  //               margin: EdgeInsets.only(top: 20),
  //               child: Image.asset('assets/images/view.png',
  //                   width: 10, height: 40),
  //             ),
  //             SizedBox(
  //               width: 20,
  //             ),
  //             //  ),
  //             Container(
  //               child: Row(
  //                 children: <Widget>[
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 8),
  //                     child: Image.asset('assets/images/date.png',
  //                         width: 15, height: 15),
  //                   ),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 20),
  //                         child: Text("Date",
  //                             style: new TextStyle(
  //                                 fontSize: 14.0, color: CustColors.Grey)),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 5),
  //                         child: Text(
  //                             _caseDetailsModel.data.usersRef.createdAt
  //                                 .toString()
  //                                 .substring(0, 10),
  //                             style: new TextStyle(
  //                                 fontSize: 12.0,
  //                                 fontWeight: FontWeight.w600,
  //                                 color: CustColors.DarkBlue)),
  //                       )
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               width: 10,
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget fundraiserSectionUi(CaseDetailsModel _caseDetailsModel) {
    return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Stack(
          children: [
            Image.asset('assets/images/roseRectangle.png',
                width: MediaQuery.of(context).size.width, height: 130),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 45, top: 15),
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text("Case Creator",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                            color: CustColors.DarkBlue)),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 25,
                      child:
                          _caseDetailsModel.data.usersRef.userId.toString() ==
                                  id
                              ? Container()
                              : RaisedButton(
                                  textColor: Colors.white,
                                  color: CustColors.followBtn,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  onPressed: () {
                                    if (followStatus == "Follow") {
                                      bloc.followUser(_caseDetailsModel
                                          .data.usersRef.userId
                                          .toString());
                                    } else {
                                      bloc.unFollowUser(_caseDetailsModel
                                          .data.usersRef.userId
                                          .toString());
                                    }
                                  },
                                  child: setFollowStatus(),
                                ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 50),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: _caseDetailsModel
                                        .data.usersRef.userProfile.aliasName !=
                                    null &&
                                _caseDetailsModel
                                        .data.usersRef.userProfile.aliasFlag ==
                                    1
                            ? setProfileName(_caseDetailsModel
                                .data.usersRef.userProfile.aliasName)
                            : setProfileName(name),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: _caseDetailsModel.data.usersRef.userProfile
                                            .aliasName !=
                                        null &&
                                    _caseDetailsModel.data.usersRef.userProfile
                                            .aliasFlag ==
                                        1
                                ? Container(
                                    child: Text(
                                        _caseDetailsModel
                                            .data.usersRef.userProfile.aliasName
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            color: CustColors.DarkBlue,
                                            fontWeight: FontWeight.normal)),
                                  )
                                : Container(
                                    child: Text(name.toString(),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            color: CustColors.DarkBlue,
                                            fontWeight: FontWeight.normal)),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Image.asset(
                              'assets/images/accountVerified.png',
                              width: 130,
                              height: 40),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget donationRecievedSectionUi(CaseDetailsModel _caseDetailsModel) {
    String donationRecieved = '0';
    if (_caseDetailsModel.data.usersRef.donationReceived != null) {
      donationRecieved = _caseDetailsModel.data.usersRef.donationReceived;
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  "Donation Received",
                  style: Styles.textHeadNormalBlue17,
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    '₹' + donationRecieved,
                    style: Styles.textHeadNormalBlue17,
                  ),
                ),
              )
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 20, bottom: 20, left: 5),
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 3, right: 3),
        //     child:
        Container(
          margin:
              const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  //   width: 60.0,
                  height: 50.0,
                  decoration: const BoxDecoration(
                      color: CustColors.DarkBlue,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 4,
                        ),
                        child: Image.asset('assets/images/chatWhiteIcon.png',
                            width: 18, height: 18),
                      ),
                      InkWell(
                        onTap: () {
                          postComment();
                        },
                        child: const Text(
                          "Comment",
                          style: Styles.textBoldwhite14,
                        ),
                      ),
                    ],
                  )),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child:
                    //  Padding(
                    //   padding: const EdgeInsets.only(left: 3, right: 3),
                    //   child:
                    InkWell(
                  onTap: () {
                    print(bloc.bannerImage);

                    if (caseOwnerStatus != id) {
                      if (caseStatus == 'Join') {
                        toastMsg('Only joined members can chat');
                      } else {
                        signIn("chat1voices@gmail.com", "123456");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GroupChatMsgPage(
                                  caseId: caseId,
                                  caseTitleForGroupChat: caseTitleForGroupChat,
                                  caseImage: bloc.bannerImage,
                                  senderId: id,
                                  senderName: userNameForGroupChat)),
                        );
                      }
                    } else {
                      signIn("chat1voices@gmail.com", "123456");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GroupChatMsgPage(
                                caseId: caseId,
                                caseTitleForGroupChat: caseTitleForGroupChat,
                                caseImage: bloc.bannerImage,
                                senderId: id,
                                senderName: userNameForGroupChat)),
                      );
                    }
                  },
                  child: Container(
                    //    width: 60.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                        color: CustColors.DarkBlue,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 4,
                          ),
                          child: Image.asset('assets/images/chat.png',
                              width: 18, height: 18),
                        ),
                        const Text(
                          "Chat",
                          style: Styles.textBoldwhite14,
                        ),
                      ],
                    )),
                  ),
                ),
                // ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child:
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 3, right: 3),
                    //   child:
                    Container(
                  // width: 60.0,
                  height: 50.0,
                  decoration: const BoxDecoration(
                      color: CustColors.DarkGreen,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Center(
                      child: InkWell(
                    onTap: () {
                      callDonation();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 4,
                          ),
                          child: Image.asset('assets/images/heart.png',
                              width: 20, height: 20),
                        ),
                        const Text(
                          "Donate",
                          style: Styles.textBoldwhite14,
                        ),
                      ],
                    ),
                  )),
                ),
                // ),
              ),
            ],
          ),
        ),
        //  ),
        //  ),
        coreMember
            ? Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                child: Container(
                  height: 50.0,
                  decoration: const BoxDecoration(
                      color: CustColors.Grey,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Center(
                      child: InkWell(
                    onTap: () {
                      bloc.closingCase(caseId);
                    },
                    child: const Text(
                      "Close Case",
                      style: Styles.textBoldwhite14,
                    ),
                  )),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget _expandText(CaseDetailsModel _caseDetailsModel) {
    return SizedBox(
      // height: (_caseDetailsModel.data.doc.length) * 200.toDouble(),
      width: MediaQuery.of(context).size.width,
      //   color: Colors.purpleAccent,
      child: Column(
        children: [
          Container(
            //   color: Colors.redAccent,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Files",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Formular',
                        fontWeight: FontWeight.w600,
                      )),
                ),
                /*ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      _caseDetailsModel.data.usersRef.caseDocument.length,
                  itemBuilder: (context, pos) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: setImage(_caseDetailsModel
                                  .data.usersRef.caseDocument[pos]),
                            ),
                            */ /*Expanded(
                              child: InkWell(
                                onTap: () {
                                  launchURL(_caseDetailsModel.data.usersRef
                                      .caseDocument[pos].caseDocument);
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        _caseDetailsModel.data.usersRef
                                            .caseDocument[pos].caseDocument,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 55),
                                      child: Text(
                                        'Created at' +
                                            _caseDetailsModel.data.usersRef
                                                .caseDocument[pos].createdAt
                                                .toString(),
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: CustColors.TextGray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),*/ /*
                          ],
                        ),
                      ),
                    );
                  },
                )*/
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 55,
                    color: Colors.white,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount:
                          _caseDetailsModel.data.usersRef.caseDocument.length,
                      itemBuilder: (context, pos) {
                        if (pos == 0) {
                          return setImage(_caseDetailsModel
                              .data.usersRef.caseDocument[pos]);
                        } else {
                          return setPaddedImage(_caseDetailsModel
                              .data.usersRef.caseDocument[pos]);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          /* Row(
            children: [
              Text("Images",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Formular',
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),*/
          const SizedBox(
            height: 20,
          ),
          /* Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 110,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: _caseDetailsModel.data.image.length,
                itemBuilder: (context, pos) {
                  if (pos == 0) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                          _caseDetailsModel.data.image[pos].caseDocument,
                          width: 120,
                          fit: BoxFit.fill),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                            _caseDetailsModel.data.image[pos].caseDocument,
                            width: 120,
                            fit: BoxFit.fill),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),*/

          Container(
            //   color: Colors.redAccent,
            child: Column(
              children: [
                /*Row(
                children: [
                  Text("Documents",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Formular',
                        fontWeight: FontWeight.w600,
                      )),
                ],
              )*/
                Container(
                  //     color: Colors.teal,
                  child: model.data.data.isNotEmpty
                      ? Column(
                          children: [
                            const Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("Comments",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Formular',
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                            // NotificationListener(
                            //   // ignore: missing_return
                            //   onNotification: (ScrollNotification scrollInfo) {
                            //     if (!bloc.paginationLoading &&
                            //         scrollInfo.metrics.pixels ==
                            //             scrollInfo.metrics.maxScrollExtent) {
                            //       if (model.data.currentPage <
                            //           model.data.totalPages) {
                            //         final page = model.data.currentPage + 1;
                            //         bloc.getAllComments1('1', page.toString());
                            //       }
                            //     }
                            //   },
                            //  child:
                            setContainer(),
                            Container(
                              height: 30,
                              color: Colors.transparent,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewMoreUi(caseId.toString())));
                                },
                                textColor: CustColors.Radio,
                                color: CustColors.Radio,
                                child: const Text(
                                  'View More',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            //  ),
                          ],
                        )
                      : Container(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void listen() {
    bloc.deleteComments.listen((data) {
      if (data != null) {
        if ((data.status == "success")) {
          toastMsg('Deleted successfully');
        } else if ((data.status == "error")) {
          toastMsg('');
        }
      }
    });
    bloc.blockUsers.listen((data) {
      if (data != null) {
        if ((data.status == "success")) {
          toastMsg('Blocked successfully');
        } else if ((data.status == "error")) {
          toastMsg('');
        }
      }
    });
    bloc.reportUser.listen((data) {
      if (data != null) {
        if ((data.status == "success")) {
          toastMsg(data.message);
        } else if ((data.status == "error")) {
          toastMsg(data.message);
        }
      }
    });
    bloc.reportComment.listen((data) {
      if (data != null) {
        if ((data.status == "success")) {
          toastMsg(data.message);
        } else if ((data.status == "error")) {
          toastMsg(data.message);
        }
      }
    });
    bloc.isFollow.listen((data) {
      if (data != null) {
        if ((data.status == "success")) {
          isFollow = data;
          print("followorunfollow");
          print(isFollow.data.status);
          print("followorunfollow");
          if (isFollow.data.status == 2) {
            setState(() {
              followStatus = 'Follow';
            });
          } else {
            setState(() {
              followStatus = 'UnFollow';
            });
          }
        } else if ((data.status == "error")) {
          followStatus = 'Follow';
        }
      }
    });
    bloc.closeCase.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          toastMsg(data.message);
        });
      } else if ((data.status == "error")) {
        toastMsg(data.message);
      }
    });
    bloc.rankComment.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          rankCommentModel = data;
          toastMsg(data.message);
        });
      } else if ((data.status == "error")) {
        toastMsg(data.message);
      }
    });
    bloc.shareStream.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          shareModel = data;

          toastMsg(data.message);
        });
      } else if ((data.status == "error")) {
        toastMsg(data.message);
      }
    });
    bloc.follow_him.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          followModel = data;
          if (followStatus == "Follow") {
            followStatus = "UnFollow";
          } else {
            followStatus = "Follow";
          }
          toastMsg(data.message);
        });
      } else if ((data.status == "error")) {
        toastMsg(data.message);
      }
    });
    bloc.rank.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          rankUpDown = data;

          // bloc.getCaseDetails(caseId);
          toastMsg(data.message);
        });
      } else if ((data.status == "error")) {
        toastMsg(data.message);
      }
    });
    bloc.rankCaseDown.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          rankCaseDown = data;
          //  bloc.getCaseDetails(caseId);
          toastMsg(data.message);
        });
      } else if ((data.status == "error")) {
        toastMsg(data.message);
      }
    });
    bloc.comments1.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          visibility = false;
          model = data;
          if (model.data.data.isNotEmpty) {
            for (int i = 0; i <= model.data.data.length; i++) {
              if (model.data.data[i].rankComment.isNotEmpty) {
                if (model.data.data[i].rankComment[0].status == 1) {
                  model.data.data[i].isUpVote = true;
                } else {
                  model.data.data[i].isUpVote = false;
                }
                if (model.data.data[i].rankComment[0].status == 2) {
                  model.data.data[i].isDownVote = true;
                } else {
                  model.data.data[i].isDownVote = false;
                }
              }
            }
          }
        });
      } else if ((data.status == "error")) {}
    });
    bloc.details.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          //       visibility = false;
          _caseDetailsModel = CaseDetailsModel();
          _caseDetailsModel = data;
          //       caseTitle = _caseDetailsModel.data.usersRef.caseTitle;
          //       caseDescription = _caseDetailsModel.data.usersRef.caseDescription;
          //       Category = _caseDetailsModel.data.usersRef.caseCategory;
          //       createdAt = _caseDetailsModel.data.usersRef.createdAt
          //           .toString()
          //           .substring(0, 10);
          //       name = _caseDetailsModel.data.usersRef.users.displayName;

          //       if (caseDescription.length > 50) {
          //         firstHalf = caseDescription.substring(0, 50);
          //         secondHalf = caseDescription.substring(50, caseDescription.length);
          //       } else {
          //         firstHalf = caseDescription;
          //         secondHalf = "";
          //       }
          //     });
          //   } else if ((data.status == "error")) {
          //     setState(() {
          //       // visible = false;
        });
        //     print("error ");
        //     String msg = data.message;
        //     toastMsg(msg);
        if (_caseDetailsModel.data.usersRef.coreGroup.isNotEmpty) {
          for (int i = 0;
              i <= _caseDetailsModel.data.usersRef.coreGroup.length;
              i++) {
            if (_caseDetailsModel.data.usersRef.coreGroup[i].userId
                    .toString() ==
                id) {
              if (_caseDetailsModel.data.usersRef.coreGroup[i].status == 1) {
                coreMember = true;
                if (_caseDetailsModel.data.usersRef.coreGroup[i].isAdmin == 1) {
                  isAdmin = true;
                }
              } else {
                coreMember = false;
              }
            }
          }
        }
      }
    });
    bloc.joinStream.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          //bloc.getCaseDetails(caseId);
          caseStatus = "Leave";
          toastMsg(data.message);
        });
      } else if ((data.status == "error")) {
        setState(() {
          // visible = false;
        });
        print("error ");
        String msg = data.message;
        toastMsg(msg);
      }
    });
    bloc.leaveStream.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          //  bloc.getCaseDetails(caseId);
          caseStatus = "Join";
          joinBool = false;
          toastMsg(data.message);
        });
      } else if ((data.status == "error")) {
        setState(() {
          // visible = false;
        });
        print("error ");
        String msg = data.message;
        toastMsg(msg);
      }
    });
  }

  toastMsg(String msg) {
    /*_scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    ));*/
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
    ));
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

  void urlFileShare(CaseDetailsModel _caseDetailsModel) async {
    final RenderBox box = context.findRenderObject();
    // imagePaths.add(_caseDetailsModel.data.image[0].caseDocument);
    // if (imagePaths.isEmpty) {

    /* await Share.shareFiles(imagePaths,
          text: 'text',
          subject: 'subject',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);*/
    await Share.share(
        "1 VOICES"
                "                                            "
                "                                            " +
            _caseDetailsModel.data.usersRef.caseTitle +
            " Visit: " +
            "https://www.1voices.com/cases/${_caseDetailsModel.data.usersRef.id}",
        subject: "                                            " +
            _caseDetailsModel.data.usersRef.caseTitle +
            "                                            " +
            _caseDetailsModel.data.usersRef.caseDescription,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    // }
    /*else {

    }*/
  }

  void _onSelected(i) {
    setState(() {
      _selectedIndex = i;
    });
  }

  launchURL(String link) async {
    final urlLink = Uri.encodeFull(link);
    if (await canLaunch(urlLink)) {
      await launch(urlLink);
    } else {
      throw 'Could not launch $urlLink';
    }
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

  Widget noDataFound() {
    return SingleChildScrollView(
      child: Container(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            //color: Colors.green,
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/caseimagedummy.png',
                    width: 300, height: 300),
                const SizedBox(
                  height: 2,
                ),
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

  setImage(Doc caseDocument) {
    return InkWell(
      onTap: () {
        launchURL(caseDocument.caseDocument);
      },
      child: Image.asset('assets/images/doc.png', width: 50, fit: BoxFit.fill),
    );
  }

  setPaddedImage(Doc caseDocument) {
    return InkWell(
      onTap: () {
        launchURL(caseDocument.caseDocument);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child:
            Image.asset('assets/images/doc.png', width: 50, fit: BoxFit.fill),
      ),
    );
  }

  Widget setFollowStatus() {
    /* if(isFollow.data.status==1){
      followStatus="UnFollow";
    }
    else{
      followStatus="Follow";
    }*/
    return Text(followStatus,
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
        ));
  }

  setJoinText(List<JoinedUser> joinedUser) {
    print('enter function');
    if ((joinedUser.isEmpty)) {
      print('enter boole');

      caseStatus = "Join";
      return AutoSizeText(
        caseStatus,
        style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
        minFontSize: 10,
        maxLines: 1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      );
    } else {
      caseStatus = "Leave";
      print('enter leave');
      return AutoSizeText(
        caseStatus,
        style: const TextStyle(color: CustColors.DarkBlue, fontSize: 12),
        minFontSize: 10,
        maxLines: 1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      );
    }
  }

  setJoinedImage(List<JoinedUser> joinedUser) {
    if ((joinedUser.isEmpty)) {
      return Image.asset('assets/images/join_grey_icon.png',
          width: 20, height: 20);
    } else {
      return Image.asset('assets/images/leave.png', width: 20, height: 20);
    }
  }

  setVoteDown(List<RankCase> rankCase) {
    if (rankCase.isEmpty) {
      return Image.asset('assets/images/vote_down_icon.png',
          width: 18, height: 18);
    } else {
      if (rankCase[0].status == 2) {
        return Image.asset('assets/images/coloredDown.png',
            width: 18, height: 18);
      } else if (rankCase[0].status == 1) {
        return Image.asset('assets/images/vote_down_icon.png',
            width: 18, height: 18);
      }
    }
  }

  setVoteUp(List<RankCase> rankCase) {
    print('called setVoteup');
    print('called setVoteup ${rankCase.length}');
    if (rankCase.isEmpty) {
      return Image.asset('assets/images/vote_up_icon.png',
          width: 18, height: 18);
    } else {
      if (rankCase[0].status == 2) {
        return Image.asset('assets/images/vote_up_icon.png',
            width: 18, height: 18);
      } else if (rankCase[0].status == 1) {
        return Image.asset('assets/images/coloredUp.png',
            width: 18, height: 18);
      }
    }
  }

  void postComment() async {
    final callApi = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ViewMoreUi(caseId.toString())));
    if (callApi == true) {
      print('commented ');
      bloc.getAllComments1(caseId, '0');
    }
  }

  Widget setContainer() {
    if (model.data.data.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'No comments yet',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: model.data.data.length,
        itemBuilder: (context, pos) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: model.data.data[pos].userProfile.aliasName !=
                                        null &&
                                    model.data.data[pos].userProfile
                                            .aliasFlag ==
                                        1
                                ? displayProfilePic(
                                    model.data.data[pos].userProfile.aliasName)
                                : displayProfilePic(model
                                    .data.data[pos].userProfile.displayName),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: model.data.data[pos].userProfile
                                                .aliasName !=
                                            null &&
                                        model.data.data[pos].userProfile
                                                .aliasFlag ==
                                            1
                                    ? Text(
                                        model.data.data[pos].userProfile
                                            .aliasName,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      )
                                    : Text(
                                        model.data.data[pos].userProfile
                                            .displayName,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 0,
                        child: PopupMenuButton<String>(
                          padding: EdgeInsets.zero,
                          offset: const Offset(0, 40),
                          icon: const Icon(Icons.more_vert),
                          onSelected: (result) async {
                            switch (result) {
                              case 'Report comment':
                                if (int.parse(id) ==
                                    model.data.data[pos].userId) {
                                  return toastMsg(
                                      "Can't Report Your Own Comment");
                                } else {
                                  return showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Row(
                                          children: [
                                            const Expanded(
                                              flex: 5,
                                              child:
                                                  Text('Reason for reporting'),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: IconButton(
                                                  icon: const Icon(
                                                    Icons.clear,
                                                    color: Colors.black87,
                                                    size: 24,
                                                  ),
                                                  onPressed: () {
                                                    commentReport.text = "";
                                                    Navigator.pop(context);
                                                  }),
                                            ),
                                          ],
                                        ),
                                        content: StatefulBuilder(builder:
                                            (BuildContext context,
                                                StateSetter myReportComment) {
                                          myReportComment1 = myReportComment;
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 0,
                                                              top: 5),
                                                      child: Container(
                                                        color: CustColors
                                                            .LightRose,
                                                        width: 250,
                                                        height: 150,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        child: ConstrainedBox(
                                                          constraints:
                                                              const BoxConstraints(
                                                            maxHeight: 150.0,
                                                          ),
                                                          child: Scrollbar(
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              reverse: true,
                                                              child: SizedBox(
                                                                height: 150.0,
                                                                child:
                                                                    TextField(
                                                                  onChanged:
                                                                      (text) {
                                                                    myReportComment1(
                                                                        () {});
                                                                  },
                                                                  controller:
                                                                      commentReport,
                                                                  maxLines: 250,
                                                                  onSubmitted:
                                                                      (text) {
                                                                    _commentFocus
                                                                        .unfocus();
                                                                  },
                                                                  decoration:
                                                                      InputDecoration(
                                                                    fillColor:
                                                                        CustColors
                                                                            .LightRose,
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.0),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                        color: CustColors
                                                                            .TextGray,
                                                                        style: BorderStyle
                                                                            .solid,
                                                                      ),
                                                                    ),
                                                                    hintText:
                                                                        'Type here…..',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              commentReport.text == '' ||
                                                      commentReport.text
                                                              .trim() ==
                                                          ''
                                                  ? const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.0, left: 2),
                                                      child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            ' * Enter a message',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Formular',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12,
                                                              color: Colors.red,
                                                            ),
                                                          )),
                                                    )
                                                  : Container(),
                                            ],
                                          );
                                        }),
                                        actions: [
                                          FlatButton(
                                            color: CustColors.DarkBlue,
                                            child: const Text('Submit'),
                                            onPressed: () {
                                              print(id);
                                              print(
                                                  model.data.data[pos].userId);
                                              if (commentReport.text == '' ||
                                                  commentReport.text.trim() ==
                                                      '') {
                                              } else {
                                                bloc.reportComments(
                                                    commentReport.text
                                                        .toString(),
                                                    model.data.data[pos].caseId,
                                                    model.data.data[pos].id);
                                                commentReport.text = '';
                                                Navigator.of(context).pop();
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }

                                break;
                              case 'Report User':
                                print('click Edit');
                                if (int.parse(id) ==
                                    model.data.data[pos].userId) {
                                  return toastMsg("Can't Report Yourself");
                                } else {
                                  return showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Row(
                                          children: [
                                            const Expanded(
                                              flex: 5,
                                              child:
                                                  Text('Reason for reporting'),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: IconButton(
                                                  icon: const Icon(
                                                    Icons.clear,
                                                    color: Colors.black87,
                                                    size: 24,
                                                  ),
                                                  onPressed: () {
                                                    commentUserReport.text = "";
                                                    Navigator.pop(context);
                                                  }),
                                            ),
                                          ],
                                        ),
                                        content: StatefulBuilder(builder:
                                            (BuildContext context,
                                                StateSetter
                                                    myReportUserComment) {
                                          myReportUserComment1 =
                                              myReportUserComment;
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 0,
                                                              top: 5),
                                                      child: Container(
                                                        color: CustColors
                                                            .LightRose,
                                                        width: 250,
                                                        height: 150,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        child: ConstrainedBox(
                                                          constraints:
                                                              const BoxConstraints(
                                                            maxHeight: 150.0,
                                                          ),
                                                          child: Scrollbar(
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              reverse: true,
                                                              child: SizedBox(
                                                                height: 150.0,
                                                                child:
                                                                    TextField(
                                                                  onChanged:
                                                                      (text) {
                                                                    myReportUserComment1(
                                                                        () {});
                                                                  },
                                                                  controller:
                                                                      commentUserReport,
                                                                  maxLines: 250,
                                                                  onSubmitted:
                                                                      (text) {
                                                                    _commentFocus
                                                                        .unfocus();
                                                                  },
                                                                  decoration:
                                                                      InputDecoration(
                                                                    fillColor:
                                                                        CustColors
                                                                            .LightRose,
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.0),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                        color: CustColors
                                                                            .TextGray,
                                                                        style: BorderStyle
                                                                            .solid,
                                                                      ),
                                                                    ),
                                                                    hintText:
                                                                        'Type here…..',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              commentUserReport.text == '' ||
                                                      commentUserReport.text
                                                              .trim() ==
                                                          ''
                                                  ? const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.0, left: 2),
                                                      child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            ' * Enter a message',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Formular',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12,
                                                              color: Colors.red,
                                                            ),
                                                          )),
                                                    )
                                                  : Container(),
                                            ],
                                          );
                                        }),
                                        actions: [
                                          FlatButton(
                                            color: CustColors.DarkBlue,
                                            child: const Text('Submit'),
                                            onPressed: () {
                                              print(id);
                                              print(
                                                  model.data.data[pos].userId);
                                              if (commentUserReport.text ==
                                                      '' ||
                                                  commentUserReport.text
                                                          .trim() ==
                                                      '') {
                                              } else {
                                                bloc.reportUserComment(
                                                    commentUserReport.text
                                                        .toString(),
                                                    model.data.data[pos].userId,
                                                    model
                                                        .data.data[pos].caseId);
                                                commentUserReport.text = '';
                                                Navigator.of(context).pop();
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }

                                break;
                              case 'Delete Comment':
                                print('click Edit');
                                bloc.deleteComment(model.data.data[pos].id);
                                setState(() {
                                  model.data.data.removeAt(pos);
                                });

                                break;
                              case 'Block User':
                                print('click Edit');
                                bloc.blockUser(model.data.data[pos].userId);
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) => isAdmin
                              ? <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                      value: 'Delete Comment',
                                      child: ListTile(
                                          title: Text('Delete Comment'))),
                                  const PopupMenuItem<String>(
                                      value: 'Block User',
                                      child:
                                          ListTile(title: Text('Block User'))),
                                ]
                              : <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                      value: 'Report comment',
                                      child: ListTile(
                                          title: Text('Report comment'))),
                                  const PopupMenuItem<String>(
                                      value: 'Report User',
                                      child:
                                          ListTile(title: Text('Report User'))),
                                ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        model.data.data[pos].comment,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                        minFontSize: 10,
                        stepGranularity: 1,
                        maxLines: 4,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: model.data.data[pos].commentFile.isNotEmpty
                        ? SizedBox(
                            height: 50,
                            //  color: Colors.blue,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount:
                                    model.data.data[pos].commentFile.length,
                                itemBuilder: (context, index) {
                                  print(
                                      model.data.data[pos].commentFile.length);
                                  var imgUrl = model.data.data[pos]
                                      .commentFile[index].commentFile;

                                  print('image url is $imgUrl');

                                  return GestureDetector(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'assets/images/doc.jpg',
                                        fit: BoxFit.contain,
                                        //'assets/images/userimagedummy.png',
                                        //  width: 50,
                                        //   height: 50
                                      ),
                                    ),
                                    onTap: () {
                                      launchURL(imgUrl);
                                    },
                                  );
                                }
                                //}
                                ),
                          )
                        : Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Row(
                              children: [
                                InkWell(
                                  child: model.data.data[pos].isDownVote
                                      ? Image.asset(
                                          'assets/images/coloredDown.png',
                                          width: 16,
                                          height: 16)
                                      : Image.asset(
                                          'assets/images/vote_down_icon.png',
                                          width: 16,
                                          height: 16),
                                  onTap: () {
                                    // _onSelected(pos);
                                    if (model.data.data[pos].isDownVote) {
                                      toastMsg('Already Ranked');
                                    } else {
                                      setState(() {
                                        model.data.data[pos].isDownVote = true;

                                        model.data.data[pos].rankCount =
                                            model.data.data[pos].rankCount - 1;
                                        bloc.rankComments(
                                            model.data.data[pos].id,
                                            model.data.data[pos].caseId,
                                            '2');
                                        model.data.data[pos].isUpVote = false;
                                      });
                                    }
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      model.data.data[pos].rankCount.toString(),
                                      style: const TextStyle(
                                          color: Colors.blueGrey, fontSize: 10),
                                      minFontSize: 10,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  child: model.data.data[pos].isUpVote
                                      ? Image.asset(
                                          'assets/images/coloredUp.png',
                                          width: 16,
                                          height: 16)
                                      : Image.asset(
                                          'assets/images/vote_up_icon.png',
                                          width: 16,
                                          height: 16),
                                  onTap: () {
                                    // _onSelected(pos);
                                    if (model.data.data[pos].isUpVote) {
                                      toastMsg('Already Ranked');
                                    } else {
                                      setState(() {
                                        if (model.data.data[pos].rankCount ==
                                            -1) {
                                          model.data.data[pos].isUpVote = true;
                                          model.data.data[pos].isDownVote =
                                              false;
                                          model.data.data[pos].rankCount =
                                              model.data.data[pos].rankCount +
                                                  2;
                                          bloc.rankComments(
                                              model.data.data[pos].id,
                                              model.data.data[pos].caseId,
                                              '1');
                                        } else {
                                          model.data.data[pos].isUpVote = true;
                                          model.data.data[pos].isDownVote =
                                              false;
                                          model.data.data[pos].rankCount =
                                              model.data.data[pos].rankCount +
                                                  1;
                                          bloc.rankComments(
                                              model.data.data[pos].id,
                                              model.data.data[pos].caseId,
                                              '1');
                                        }
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userTypeId = prefs.getString(SharedPrefKey.USER_TYPE);
    id = prefs.getString(SharedPrefKey.USER_ID);
    userNameForGroupChat = prefs.getString(SharedPrefKey.USER_NAME);
  }

  Future<void> callDonation() async {
    if (bloc.caseStatus == '3') {
      toastMsg('This Case is already closed');
    } else if (bloc.caseStatus == '2') {
      toastMsg('This Case is not accepted');
    } else if (bloc.caseStatus == '4') {
      toastMsg('This Case is already rejected');
    } else {
      final callApi = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CardListPage(caseId.toString(), '1', bloc.caseTitle)));
      if (callApi == true) {
        print('commented ');
        bloc.getCaseDetails(caseId);
      }
    }
    /* Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddCardUi(
            )));*/
  }

  Future _asyncInputDialog(BuildContext context) async {}

  Widget setProfileName(String displayName) {
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

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
