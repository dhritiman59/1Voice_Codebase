import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Constants/CheckInternet.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Models/GetCoreMember/GetCoreMembersModel.dart';
import 'package:bring2book/Models/GetUserDetailsModel/GetUserDetailsModel.dart';
import 'package:bring2book/Ui/AddCase/UploadCaseDocuments.dart';
import 'package:bring2book/Ui/CaseDetails/CaseDetailsBloc.dart';
import 'package:bring2book/Ui/CoreMembersList/CoreMembersBloc.dart';
import 'package:bring2book/Ui/Donation/DonationBloc.dart';
import 'package:bring2book/Ui/ProfileHomePage/ProfileDetailsBloc.dart';
import 'package:bring2book/Ui/SignInScreen/SignInActivity.dart';
import 'package:bring2book/Ui/TermsAndPrivacy/PlatformTermsBloc.dart';
import 'package:bring2book/Ui/TermsAndPrivacy/PrivacyPolicyBloc.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
class CoreMembersUi extends StatefulWidget {
  String caseId;
  String caseTypeFlag;
  String join;
  String userId;
  CoreMembersUi(this.caseId, this.join, this.caseTypeFlag,this.userId);





  @override
  _State createState() => _State(caseId,join,caseTypeFlag,userId);
}

class _State extends State<CoreMembersUi> {
  String caseId;
  String caseTypeFlag;
  String join;
  String id;
  GetCoreMembers model=GetCoreMembers();

  _State(this.caseId, this.join, this.caseTypeFlag,this.id);
  bool visibility = true;
  bool alreadyMember = false;

  CoreMembersBloc bloc=CoreMembersBloc();
  TextEditingController amount = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ProfileDetailsBloc _profileDetailsBloc = ProfileDetailsBloc();
GetUserDetailsModel  userModel=GetUserDetailsModel();
  CaseDetailsBloc bloc2 = CaseDetailsBloc();
String userType;
  bool visibleButton=false;
  int listCount;
  String userId;
  String text='.  Follow';
  @override
  void initState() {
    print('comes'+join);
    super.initState();
    getUserId();
    bloc.getCoremembersList(caseId);
    _profileDetailsBloc.getUserDetails();
    listen();
    print(userType);
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
                            child: Text("Core Members",
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
                      builder: (context, AsyncSnapshot<GetCoreMembers> snapshot) {
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

                          // ignore: missing_return
                          /* onNotification: (ScrollNotification scrollInfo) {
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

                          child: ListView.builder(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.data.data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
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
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(20.0),
                                                    child:snapshot.data.data.data[index].users.userProfile[0].aliasName !=null &&snapshot.data.data.data[index].users.userProfile[0].aliasFlag ==1?setProfileName(snapshot.data.data.data[index].users.userProfile[0].aliasName):setProfileName(snapshot.data.data.data[index].users.displayName),
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
                                                    child:snapshot.data.data.data[index].users.userProfile[0].aliasName !=null &&snapshot.data.data.data[index].users.userProfile[0].aliasFlag ==1? Text(
                                                      '${snapshot.data.data.data[index].users.userProfile[0].aliasName}',
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
                                                      snapshot.data.data.data[index].users.displayName.length>10?'${snapshot.data.data.data[index].users.displayName.substring(0,8)}'+'...':'${snapshot.data.data.data[index].users.displayName}',
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
                                                    child:snapshot.data.data.data[index].users.userProfile[0].aliasName !=null &&snapshot.data.data.data[index].users.userProfile[0].aliasFlag ==1? Text(
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
                                            )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 20),
                                            child: InkWell(
                                              onTap: (){
                                                if( snapshot.data.data.data[index].users.followUser.length==0){
                                                  bloc2.followUser(snapshot.data.data.data[index].userId.toString());

                                                }
                                                else{
                                                  if( snapshot.data.data.data[index].users.followUser[0].status==1){

                                                    bloc2.unFollowUser(snapshot.data.data.data[index].userId.toString());

                                                  }
                                                  else{
                                                    bloc2.followUser(snapshot.data.data.data[index].userId.toString());
                                                  }

                                                }

                                              },
                                              child: setFollowStatus(snapshot.data.data.data[index].users.followUser),

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

            visibleButton ?
     Padding(
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
                if(join=='1'){
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



  void listen() {

    bloc2.follow_him.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          bloc.getCoremembersList(caseId);
        });
        toastMsg(data.message);
      } else if ((data.status == "error")) {
        setState(() {
          bloc.getCoremembersList(caseId);
        });
        toastMsg(data.message);
      }
    });
    bloc.getCoreMembers.listen((value) {
      if ((value.status == "success")) {
        print(userId+"praveennnnnnnnnnnnnnnnnnn");
       if(value.data.data.length!=0){
         for(int i=0;i<value.data.data.length;i++){
           print(value.data.data[i].userId );
           // ignore: unrelated_type_equality_checks
           if(value.data.data[i].userId.toString()==userId){
             alreadyMember = true;
             print("praveennnnnnnnnnnnnnnnnnn");
             visibleButton=false;
           }
         }
       }

        setState(() {

          visibility=false;
        });
        //toastMsg(value.message);

      } else if ((value.status == "error")) {
        //  toastMsg(value.message);
        setState(() {
          visibility=false;
        });
      }
    });
    bloc.requestCoreMember.listen((value) {

      if ((value.status == "success")) {

        toastMsg('Requested SuccessFully');

      } else if ((value.status == "error")) {
         toastMsg(value.message);
      }
    });
    _profileDetailsBloc.getUserDetailsStream.listen((data) {
      if ((data.status == "success")) {

        setState(() {
          userModel=data;
          userType=data.data.userTypeId.toString();
          if(userType=='2'&& userId!=id&&alreadyMember==false){
            setState(() {
              visibleButton=true;
            });

          }
          else{
            setState(() {
              visibleButton=false;
            });

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

  toastMsg(String msg) {
    /*_scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    ));*/
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    ));
  }

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(SharedPrefKey.USER_ID);
  }

  Widget setProfileName(String displayName) {
    String text = displayName.substring(0, 1);
    return CircularProfileAvatar(
      '',
      radius: 50, // sets radius, default 50.0
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

  setFollowStatus(List<FollowUser> followUser) {
    if(followUser.length==0){
      text='.  Follow';
      return  Text(
        text,
        maxLines: 2,
        overflow:
        TextOverflow.ellipsis,
        softWrap: false,
        style: TextStyle(
            color: CustColors.DarkBlue,

            fontSize: 18.0),
      );
    }
    else{
      if(followUser[0].status==1){
        text='        .  UnFollow';
        return  Text(
          text,
          maxLines: 2,
          overflow:
          TextOverflow.ellipsis,
          softWrap: false,
          style: TextStyle(
              color: CustColors.DarkBlue,

              fontSize: 18.0),
        );
      }
      else if(followUser[0].status==2){
        text='.  Follow';
        return  Text(
          text,
          maxLines: 2,
          overflow:
          TextOverflow.ellipsis,
          softWrap: false,
          style: TextStyle(
              color: CustColors.DarkBlue,

              fontSize: 18.0),
        );
      }
    }


  }






}
