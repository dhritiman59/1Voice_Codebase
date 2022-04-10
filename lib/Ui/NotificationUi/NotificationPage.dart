import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Constants/CheckInternet.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Models/NotificationModel/NotificationModel.dart';
import 'package:bring2book/Ui/AddCase/UploadCaseDocuments.dart';
import 'package:bring2book/Ui/CaseDetails/CaseDetailsBloc.dart';
import 'package:bring2book/Ui/CaseDetails/CaseDetailsPage.dart';
import 'package:bring2book/Ui/Donation/DonationBloc.dart';
import 'package:bring2book/Ui/SignInScreen/SignInActivity.dart';
import 'package:bring2book/Ui/TermsAndPrivacy/PlatformTermsBloc.dart';
import 'package:bring2book/Ui/TermsAndPrivacy/PrivacyPolicyBloc.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'NotificationBloc.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage();

  @override
  _State createState() => _State();
}

class _State extends State<NotificationPage> {
  final String caseId;
  final String valueFrom;
  bool visibility = false;
  CaseDetailsBloc bloc2 = CaseDetailsBloc();
  NotificationBloc bloc = NotificationBloc();
  bool visible = true;
  TextEditingController amount = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _State({this.caseId, this.valueFrom});

  @override
  void initState() {
    super.initState();
    bloc.getNotificationList(page: '0');
    listen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Stack(
          children: [
            Column(
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
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 30),
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
                            child: Text("Notification",
                                style: new TextStyle(
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
                Flexible(
                  child: StreamBuilder(
                      stream: bloc.notificationList,
                      builder:
                          (context, AsyncSnapshot<NotificationModel> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.status == 'error') {
                            return noDataFound();
                          } else if (snapshot.data.data.data.length == 0) {
                            return noDataFound();
                          } else {}
                        } else {
                          return Center(child: ProgressBarDarkBlue());
                        }
                        return NotificationListener(
                          // ignore: missing_return
                          onNotification: (ScrollNotification scrollInfo) {
                            if (!bloc.paginationLoading &&
                                scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                              // start loading data
                              if (snapshot.data.data.currentPage <
                                  snapshot.data.data.totalPages) {
                                final page = snapshot.data.data.currentPage + 1;

                                bloc.getNotificationList(page: page.toString());
                              }
                            }
                          },

                          child: ListView.builder(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: false,
                            itemCount: snapshot.data.data.data.length,
                            itemBuilder: (context, index) {
                              return /*ListTile(
                                title: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            flex: 1,
                                            child:  Container(
                                              width: 50.0,
                                              height: 50.0,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(20.0),
                                                child:setProfileName(snapshot.data.data.data[index].users.displayName),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                      '${snapshot.data.data.data[index].message}',
                                                      style: TextStyle(
                                                          color: CustColors.blueLight,
                                                          fontSize: 15.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      */ /* Padding(
                                                padding:
                                                EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: AutoSizeText(
                                                    '${snapshot.data.data.data[index].caseDescription}',
                                                    style: TextStyle(
                                                        color: Colors.grey, fontSize: 12),
                                                    minFontSize: 10,
                                                    stepGranularity: 1,
                                                    maxLines: 4,
                                                    textAlign: TextAlign.justify,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),*/ /*

                                    ],
                                  ),
                                ),
                                // onTap: () =>pubDetails(snapshot.data.data[index]),
                              );*/
                                  ListTile(
                                onTap: () {
                                  if (snapshot.data.data.data[index].caseId !=
                                      null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CaseDetailsPage(
                                                  caseId: snapshot.data.data
                                                      .data[index].caseId
                                                      .toString(),
                                                  userId: snapshot
                                                      .data
                                                      .data
                                                      .data[index]
                                                      .userCase
                                                      .userId,
                                                  caseNetworkImage: "",
                                                  bannerImage:
                                                      'assets/images/casedetailsHuman.png',
                                                  caseVideoImage: "",
                                                )));
                                  }
                                },
                                title: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              width: 50.0,
                                              height: 50.0,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: setProfileName(snapshot
                                                    .data
                                                    .data
                                                    .data[index]
                                                    .users
                                                    .displayName),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 4,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  '${snapshot.data.data.data[index].message}',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      color:
                                                          CustColors.blueLight,
                                                      fontSize: 15.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          snapshot.data.data.data[index].users
                                                          .followUser.length ==
                                                      0 &&
                                                  snapshot.data.data.data[index]
                                                          .heading ==
                                                      'You got a new follower!!'
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 3),
                                                  child: InkWell(
                                                    onTap: () {
                                                      bloc2.followUser(snapshot
                                                          .data
                                                          .data
                                                          .data[index]
                                                          .userId
                                                          .toString());
                                                      setState(() {
                                                        snapshot
                                                            .data
                                                            .data
                                                            .data[index]
                                                            .users
                                                            .followUser
                                                            .length = 1;
                                                      });
                                                    },
                                                    child: Container(
                                                      color:
                                                          CustColors.DarkBlue,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10,
                                                                top: 5,
                                                                bottom: 5),
                                                        child: Text(
                                                          '  Follow ',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 11.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // onTap: () =>pubDetails(snapshot.data.data[index]),
                              );
                            },
                          ),
                        );
                      }),
                ),
              ],
            ),
            Visibility(
              visible: visible,
              child: Container(
                color: Colors.white70,
                child: Center(
                  child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          CustColors.DarkBlue)),
                ),
              ),
            )
          ],
        ),
      ),
    );
    //);
  }

  toastMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    ));
  }

  void listen() {
    bloc.notificationList.listen((value) {
      if ((value.status == "success")) {
        setState(() {
          visible = false;
        });
      } else if ((value.status == "error")) {}
    });
    bloc2.isFollow.listen((data) {
      if (data != null) {
        if ((data.status == "success")) {
          toastMsg('Followed SuccessFully');
        }
      } else if ((data.status == "error")) {
        toastMsg('Followed SuccessFully');
      }
    });
  }

  ProgressBarDarkBlue() {}

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
                Align(
                  alignment: Alignment.topCenter,
                  child: Text('No Data Found',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: Colors.blueGrey)),
                )
              ],
            ),
          ),
        ),
      ),
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

  setProfileName(name) {
    String text = name.substring(0, 1);
    return CircularProfileAvatar(
      '',
      radius: 100, // sets radius, default 50.0
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
}
