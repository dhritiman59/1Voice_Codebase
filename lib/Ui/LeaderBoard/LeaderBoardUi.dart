
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Models/LeaderBoardModel/LeaderBoardModel.dart';

import 'package:bring2book/Ui/LeaderBoard/LeaderBoardBloc.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';



class LeaderBoardUi extends StatefulWidget {

  LeaderBoardUi();


  @override
  _State createState() => _State();
}

class _State extends State<LeaderBoardUi> {
  final String caseId;
  final String valueFrom;
  bool visibility = false;
  bool visible=true;
  LeaderBloc bloc=LeaderBloc();
  TextEditingController amount = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _State({this.caseId,this.valueFrom});

  @override
  void initState() {
    super.initState();
    bloc.getLeaderBoardList(page:'0');
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
                              padding: const EdgeInsets.only(left: 20.0, top: 30),
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
                            child: Text("Leader Board",
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
                  child:StreamBuilder(
                      stream: bloc.leaderBoardStream,
                      builder:
                          (context, AsyncSnapshot<LeaderModel> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.status == 'error') {
                            return noDataFound();
                          } else if (snapshot.data.data.data.length == 0) {
                            return noDataFound();
                          } else {

                          }
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

                                bloc.getLeaderBoardList(page: page.toString());

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
                                      *//* Padding(
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
                                              ),*//*

                                    ],
                                  ),
                                ),
                                // onTap: () =>pubDetails(snapshot.data.data[index]),
                              );*/
                              ListTile(
                                title: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              width: 60.0,
                                              height: 60.0,
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(20.0),
                                                    child:snapshot.data.data.data[index].userProfile.length!=0 && snapshot.data.data.data[index].userProfile[0].aliasName !=null && snapshot.data.data.data[index].userProfile[0].aliasName !="" &&snapshot.data.data.data[index].userProfile[0].aliasFlag ==1?setProfileName(snapshot.data.data.data[index].userProfile[0].aliasName):setProfileName(snapshot.data.data.data[index].displayName),
                                                  ),Align(alignment: AlignmentDirectional.bottomEnd,
                                                    child: Container(width: 30,height: 30,
                                                        decoration: new BoxDecoration(
                                                          color: Colors.black87, // border color
                                                          shape: BoxShape.circle,
                                                        ),
                                                      child:  CircleAvatar(
                                                          radius: 18,
                                                          backgroundColor:
                                                          Colors.white,
                                                          child: Text('${index+1}')),),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child:snapshot.data.data.data[index].userProfile.length!=0 && snapshot.data.data.data[index].userProfile[0].aliasName !=null && snapshot.data.data.data[index].userProfile[0].aliasName !="" &&snapshot.data.data.data[index].userProfile[0].aliasFlag ==1? Text(
                                                      '${snapshot.data.data.data[index].userProfile[0].aliasName}',
                                                      maxLines: 2,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 18.0),
                                                    ):Text(
                                                      '${snapshot.data.data.data[index].displayName}',
                                                      maxLines: 2,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 18.0),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                      'point +${snapshot.data.data.data[index].heroPoints} ',
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                          FontWeight.normal,
                                                          fontSize: 12.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

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
    bloc.leaderBoardList.listen((value) {
      if ((value.status == "success")) {
        setState(() {
          visible = false;
        });


      } else if ((value.status == "error")) {

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
