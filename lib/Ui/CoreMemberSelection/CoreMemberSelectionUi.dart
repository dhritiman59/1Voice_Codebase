import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Constants/CheckInternet.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Models/CoreMemberSelection/CoreMemberSelection.dart';
import 'package:bring2book/Models/GetUserDetailsModel/GetUserDetailsModel.dart';
import 'package:bring2book/Ui/AddCase/UploadCaseDocuments.dart';
import 'package:bring2book/Ui/Donation/DonationBloc.dart';
import 'package:bring2book/Ui/ProfileHomePage/ProfileDetailsBloc.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'CoreMembersRequestBloc.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
class CoreMembersSelectionUi extends StatefulWidget {
  String caseId;
  String caseTypeFlag;
  String join;
  String userId;
  CoreMembersSelectionUi(this.caseId, this.join, this.caseTypeFlag,this.userId);



  @override
  _State createState() => _State(caseId,join,caseTypeFlag,userId);
}

class _State extends State<CoreMembersSelectionUi> {
  String id;
  String caseId;
  String caseTypeFlag;
  String join;
  String userId;
  _State(this.caseId, this.join, this.caseTypeFlag,this.id);
  ProfileDetailsBloc _profileDetailsBloc = ProfileDetailsBloc();
  bool visibility = true;
  CoreMembersRequestBloc bloc=CoreMembersRequestBloc();
  TextEditingController amount = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String userType;
  bool visibleButton=false;
  GetUserDetailsModel  userModel=GetUserDetailsModel();
  @override
  void initState() {
    super.initState();
    bloc.getCoremembersList(caseId);
    _profileDetailsBloc.getUserDetails();
    getUserId();
    listen();
  }

  @override
  Widget build(BuildContext context) {
    return
      // SafeArea(
      //     child:
      Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(0),
          child: Stack(
            children: [
              ListView(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        "assets/images/forgotbgnew.png",
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.20,
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
                            child: Text("Core MembersList",
                                style: new TextStyle(
                                  color: CustColors.DarkBlue,
                                  fontSize: 18.0,
                                  fontFamily: 'Formular',
                                )),
                          ),

                        ],
                      ),
                    ],

                  ),
                  StreamBuilder(
                      stream:
                      bloc.getCoreMembers,
                      builder: (context, AsyncSnapshot<CoreMemberSelection> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting ||
                            snapshot.connectionState == ConnectionState.none) {
                          return Center(child: ProgressBarDarkBlue());
                        } else if (snapshot.hasData ||
                            snapshot.data.data.data.length != 0) {
                          if (snapshot.data.status == 'error') {
                            return noDataFound();
                          } else if (snapshot.data.data.data.length == 0) {
                            return noDataFound();
                          }
                        } else {
                          return Center(child: ProgressBarDarkBlue());
                        }

                        return NotificationListener(

                    /*      // ignore: missing_return
                          *//* onNotification: (ScrollNotification scrollInfo) {
              if (!_myCaseAndJoinCaseHomeBloc.paginationLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                // start loading data
                if (snapshot.data.data.currentPage <
                    snapshot.data.data.totalPages) {
                  final page = snapshot.data.data.currentPage + 1;
                  _myCaseAndJoinCaseHomeBloc.MyCasesAPI(
                      page: page.toString());
                }
              }
            },*/

                          child:
                            userId==id||snapshot.data.data.accepted==1
                                ? ListView.builder(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.data.data.length,
                            itemBuilder: (context, index) {

                              return ListTile(
                                onTap: () {


                                },
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
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(20.0),
                                                    child:snapshot.data.data.data[index].users.userProfile[0].aliasName!=null &&snapshot.data.data.data[index].users.userProfile[0].aliasFlag ==1?setProfileName(snapshot.data.data.data[index].users.userProfile[0].aliasName):setProfileName(snapshot.data.data.data[index].users.displayName),
                                                  ),Align(alignment: AlignmentDirectional.bottomEnd,
                                                    child: Container(width: 20,height: 20,
                                                      child:  CircleAvatar(
                                                          radius: 18,
                                                          backgroundColor:
                                                          Colors.white,
                                                          child: ClipOval(
                                                            child: Image.asset(
                                                              'assets/images/core_member.png',
                                                            ),
                                                          )),),
                                                  )
                                                ],
                                              ),
                                            )
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
                                                    child: snapshot.data.data.data[index].users.userProfile[0].aliasName =='aliasName' &&snapshot.data.data.data[index].users.userProfile[0].aliasFlag ==1?
                                                    Text(
                                                      '${ snapshot.data.data.data[index].users.userProfile[0].aliasName}',
                                                      maxLines: 2,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 18.0),
                                                    ): Text(
                                                      '${snapshot.data.data.data[index].users.displayName}',
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
                                                    child: snapshot.data.data.data[index].users.userProfile[0].aliasName =='aliasName' &&snapshot.data.data.data[index].users.userProfile[0].aliasFlag ==1?Text(
                                                      '',
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
                                                    ):Text(
                                                      '${snapshot.data.data.data[index].users.emailId} ',
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
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 3),
                                            child: InkWell(
                                              onTap: (){
                                                bloc.acceptRequest(snapshot.data.data.data[index].id);

                                              },
                                              child:snapshot.data.data.accepted!=1? Container( color:CustColors.DarkBlue ,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 10,right: 10 ,top: 5,bottom: 5),
                                                  child: Text(
                                                    '  Accept ',
                                                    maxLines: 2,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    style: TextStyle(

                                                        color: Colors.white,

                                                        fontSize: 11.0),
                                                  ),
                                                ),
                                              ):Container(),
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
                          )
                                : Container(),
                        );
                      }),
                  visibleButton? Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SubmitFlatButtonWidget(
                          height: 50,
                          width: double.infinity,
                          backgroundColor: CustColors.DarkBlue,
                          buttonText: "Become core member",
                          buttonTextColor: Colors.white,
                          onpressed: () {
                            if(join=='1') {
                              bloc.joinCoreMember(caseId);
                            }
                            else{
                              toastMsg('Please Join this case');
                            }
                          },
                        ),
                      ),
                    ),
                  ):Container(),





                ],
              ),Visibility(
                visible: visibility,
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
    bloc.privateRequest.listen((value) {
      if ((value.status == "success")) {

        toastMsg('Accepted SuccessFully');
        bloc.getCoremembersList(caseId);
        setState(() {

        });

      } else if ((value.status == "error")) {
          toastMsg(value.message);
      }
    });
    bloc.requestCoreMember.listen((value) {
      if ((value.status == "success")) {

        toastMsg('Requested SuccessFully');

      } else if ((value.status == "error")) {
        // toastMsg(value.message);
      }
    });
    bloc.getCoreMembers.listen((value) {
      if ((value.status == "success")) {
        setState(() {
          visibility=false;
        });

      } else if ((value.status == "error")) {
        setState(() {
          visibility=false;
        });
        toastMsg(value.message);
      }
    });
    _profileDetailsBloc.getUserDetailsStream.listen((data) {
      if ((data.status == "success")) {

        setState(() {
          userModel=data;
          userType=data.data.userTypeId.toString();
          if(userType=='2'&&userId!=id){
            visibleButton=true;
          }
          else{
            visibleButton=false;
          }
        });


      }
      else if ((data.status == "error")) {

        //toastMsg(data.message);
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

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   userId = prefs.getString(SharedPrefKey.USER_ID);
  }

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
