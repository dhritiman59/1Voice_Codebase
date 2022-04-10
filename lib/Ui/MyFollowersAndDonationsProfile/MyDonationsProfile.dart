import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Ui/MyFollowersAndDonationsProfile/MyFollowersAndDonationsBloc.dart';
import 'package:bring2book/Models/MyDonationsListModel/MyDonationsListModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';



class MyDonationsProfile extends StatefulWidget {
  MyDonationsProfile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyDonationsProfileState createState() => _MyDonationsProfileState();
}

class _MyDonationsProfileState extends State<MyDonationsProfile> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MyFollowersAndDonationsBloc _myFollowersAndDonationsBloc = MyFollowersAndDonationsBloc();

  bool visible = false;
  var formatted;

  bool isLoading = false;


  String userProfilePic = '';

  @override
  void initState() {
    super.initState();


    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMMM, dd yyyy');
    formatted = formatter.format(now);
    print('formatted$formatted');


    _myFollowersAndDonationsBloc.MyDonationListAPI(page: "0");
    listenApi();
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
                            child: Text("My Donations",
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
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder(
                            stream: _myFollowersAndDonationsBloc.myDonationListRespStream,
                            builder: (context, AsyncSnapshot<MyDonationsListModel> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                                  snapshot.connectionState == ConnectionState.none) {
                                return Center(child: ProgressBarDarkBlue());
                              }
                              else if (snapshot.hasData || snapshot.data.data.data.length != 0) {
                                if (snapshot.data.status == 'error') {
                                  return noDataFound();
                                }
                                else if (snapshot.data.data.data.length == 0) {
                                  return noDataFound();
                                }
                              } else {
                                return Center(child: ProgressBarDarkBlue());
                              }
                              return NotificationListener(
                                // ignore: missing_return
                                onNotification: (ScrollNotification scrollInfo) {
                                  if (!_myFollowersAndDonationsBloc.paginationLoading &&
                                      scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                                    // start loading data
                                    if (snapshot.data.data.currentPage < snapshot.data.data.totalPages) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      final page = snapshot.data.data.currentPage + 1;
                                      _myFollowersAndDonationsBloc.MyDonationListAPI(page: page.toString());
                                    }
                                  }
                                },

                                child: ListView.builder(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.data.data.length,
                                  itemBuilder: (context, index) {
                                    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
                                    DateTime dateTime = dateFormat.parse('${snapshot.data.data.data[index].createdAt}');
                                    DateTime currentdateTimeNow = DateTime.now();

                                    final differenceInDays = currentdateTimeNow.difference(dateTime).inDays;
                                    String str = differenceInDays.toString();
                                    var arr = str.split('.');
                                    String numberOfdays=arr[0];

                                    print(index.toString() +'index' + snapshot.data.data.data.length.toString() + "length");

                                    /*if ((index) == snapshot.data.data.data.length)
                                    {
                                      print(index.toString() +'indexgdgg22222' + snapshot.data.data.currentPage.toString() + "length");
                                      //pagination loader
                                       return Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child:
                                        snapshot.data.data.currentPage + 1 < snapshot.data.data.totalPages
                                        ?  Center(child: ProgressBarDarkBlue(),)
                                        : Container(),
                                      );
                                    }*/


                                    return ListTile(
                                      onTap: () {
                                        /// Navigate To CaseDetails
                                      },
                                      title: Padding(
                                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child:Container(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(20.0),
                                                        child: displayProfilePic(
                                                            snapshot.data.data.data[index].userCase==null?'General Donation':snapshot.data.data.data[index].userCase.caseTitle),
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex:4,
                                                    child:Padding(
                                                      padding: EdgeInsets.fromLTRB(
                                                          10, 0, 0, 0),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            width: double.infinity,
                                                            child: Text(
                                                              'Donated To',
                                                              maxLines: 1,
                                                              overflow:
                                                              TextOverflow.ellipsis,
                                                              softWrap: false,
                                                              style: TextStyle(
                                                                  color: CustColors.blueLight,
                                                                  fontWeight:
                                                                  FontWeight.normal,
                                                                  fontSize: 18.0),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: double.infinity,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(top: 1),
                                                              child: Text(
                                                                snapshot.data.data.data[index].userCase==null?'General Donation':
                                                                "${snapshot.data.data.data[index].userCase.caseTitle}",
                                                                maxLines: 1,
                                                                overflow:
                                                                TextOverflow.ellipsis,
                                                                softWrap: false,
                                                                textAlign:
                                                                TextAlign.start,
                                                                style: TextStyle(
                                                                    color: Colors.grey,
                                                                    fontWeight:
                                                                    FontWeight.normal,
                                                                    fontSize: 16.0),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: double.infinity,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(top: 3),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    "Transaction_id: ",
                                                                    maxLines: 1,
                                                                    overflow:
                                                                    TextOverflow.visible,
                                                                    softWrap: false,
                                                                    textAlign:
                                                                    TextAlign.start,
                                                                    style: TextStyle(
                                                                        color: Colors.grey,
                                                                        fontWeight:
                                                                        FontWeight.normal,
                                                                        fontSize: 14.0),
                                                                  ),
                                                                  Text(
                                                                    "${snapshot.data.data.data[index].transactionId.toString()}",
                                                                    maxLines: 2,
                                                                    overflow:
                                                                    TextOverflow.visible,
                                                                    softWrap: false,
                                                                    textAlign:
                                                                    TextAlign.start,
                                                                    style: TextStyle(
                                                                        color: Colors.grey,
                                                                        fontWeight:
                                                                        FontWeight.normal,
                                                                        fontSize: 14.0),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex:2,
                                                    child:SizedBox(
                                                      width: double.infinity,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(bottom: 12),
                                                        child: Text(
                                                          '\$${snapshot.data.data.data[index].amount}',
                                                          maxLines: 1,
                                                          softWrap: false,
                                                          textAlign:
                                                          TextAlign.end,
                                                          style: TextStyle(
                                                              color:CustColors.blueLight,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              fontSize: 18.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    flex:4,
                                                    child:Padding(
                                                      padding: EdgeInsets.fromLTRB(
                                                          10, 0, 0, 0),
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        child: Text(numberOfdays=='0'?'Today':(numberOfdays=='1'?
                                                        '$numberOfdays day ago': '$numberOfdays days ago'),
                                                          maxLines: 1,
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontWeight:
                                                              FontWeight.normal,
                                                              fontSize: 12.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                 /* Flexible(
                                                    flex:2,
                                                    child:SizedBox(
                                                      width: double.infinity,
                                                      child: Text(
                                                        "Debited From bank",
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        textAlign:
                                                        TextAlign.end,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight.normal,
                                                            fontSize: 12.0),
                                                      ),
                                                    ),
                                                  ),*/
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsets.fromLTRB(10, 10, 10, 10),
                                              child: Divider(
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                            )
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

                      isLoading
                          ? Center(child: ProgressBarDarkBlue(),)
                          : Container(),

                    ],
                  ),
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
  }



  void toastMsg(String s) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(s),
      duration: Duration(seconds: 1),
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
                Text('No Data Found',
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
      height: 50.0,
      width: 50,
      child: new Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(CustColors.Radio),
          )),
    );
  }



  void listenApi() {
    _myFollowersAndDonationsBloc.myDonationListRespStream.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          isLoading = false;
        });
        print(" ${data.status}");
        userProfilePic = data.data.data[0].userProfile.profilePic;
        setState(() {
          userProfilePic = data.data.data[0].userProfile.profilePic;
        });


      } else if ((data.status == "error")) {
        setState(() {
          isLoading = false;
        });
        print("${data.status}");
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