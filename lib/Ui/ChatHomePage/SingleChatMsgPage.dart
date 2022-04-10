import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:bring2book/Ui/ChatHomePage/FirebaseMessagingDetails.dart';
import 'package:bring2book/Ui/ChatHomePage/ChatPageBloc.dart';
import 'package:intl/intl.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:flutter/painting.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';


class SingleChatMsgPage extends StatefulWidget {



  final String reciverid,reciverUserName,senderid,senderName,reciverImage,senderImage,reciverFcm,senderFcm;

  SingleChatMsgPage({this.senderid,this.senderFcm,this.senderName,this.senderImage,this.reciverid,this.reciverFcm,this.reciverImage,this.reciverUserName});

  @override
  _SingleChatMsgPageState createState() => _SingleChatMsgPageState();
}

class _SingleChatMsgPageState extends State<SingleChatMsgPage> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ChatPageBloc _chatPageBloc = ChatPageBloc();
  FirebaseMessagingDetails  _firebaseMessagingDetails = FirebaseMessagingDetails();
  ScrollController _scrollController = new ScrollController();
  TextEditingController _txtCtrl = TextEditingController();
  DatabaseReference ref1 = FirebaseDatabase.instance.reference().child('chats');

  bool visible = false;

  String userProfilePic = '';
  String userProfileName = '';
  String userProfilePhone = '';
  String userProfileEmail = '';
  String userProfileAliasName = '';
  String userProfileAliasFlag = '0';
  String userProfileUserReward = '';

  String reciverid='';
  String reciverFcm='';
  String reciverImage='';
  String reciverUserName='';
  String senderName='';
  String senderImage='';
  String senderFcm='';
  String senderid='';

  String childFirebaseUserId;

  String compareMessageDate="";




  @override
  void initState() {
    super.initState();

    reciverImage=widget.reciverImage;
    reciverUserName=widget.reciverUserName;
    reciverid=widget.reciverid;
    reciverFcm=widget.reciverFcm;
    senderName=widget.senderName;
    senderImage=widget.senderImage;
    senderid=widget.senderid;
    senderFcm=widget.senderFcm;
    print(widget.reciverImage+ '+++++++++++++' + widget.reciverUserName + widget.senderid+ '+++++++++++++' + widget.senderName + widget.senderImage+ '+++++++++++++');

    _chatPageBloc.getUserDetails();
    _firebaseMessagingDetails.setSingleChatListId(
      senderid: widget.senderid,
      senderName: widget.senderName,
      senderImage: widget.senderImage,
      reciverid: widget.reciverid,
      reciverFcm:widget.reciverFcm,
      reciverUserName: widget.reciverUserName,
      reciverImage: widget.reciverImage,);
    listenApi();



  }


  @override
  Widget build(BuildContext context) {
    print(senderid+'senderid');
    return  Stack(
        children: [
          Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.white,
              appBar:  PreferredSizeAppBar(),
              body:
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Padding(
                    padding: EdgeInsets.all(0),
                    child: SingleChildScrollView(
                      child: Column(
                          children: <Widget>[
                            ChatViewListOfAllMessages(),
                            messageSendWidget(),
                          ]

                      ),
                    )
                ),
              )
          ),
        ]);
  }



  Widget PreferredSizeAppBar()
  {
    return  PreferredSize(
      preferredSize: Size.fromHeight( MediaQuery.of(context).size.height * 0.18,),
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: new AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          brightness: Brightness.light,
          flexibleSpace: new Column(
            children: [
              SafeArea(
                child:  Stack(
                  children: [
                    Image.asset(
                      "assets/images/forgotbgnew.png",
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.18,
                      gaplessPlayback: true,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);

                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0,right: 5.0, top: 10),
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
                              padding: const EdgeInsets.only( top: 10),
                              child: Container(
                                width: 45.0,
                                height: 45.0,
                                child:
                                widget.reciverImage!=""?
                                CachedNetworkImage(
                                  imageUrl:widget.reciverImage,
                                  imageBuilder: (context, imageProvider) => Container(
                                    width: 45.0,
                                    height: 45.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider, fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: displayProfilePic(widget.reciverUserName),
                                  ),
                                ) :
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: displayProfilePic( widget.reciverUserName),
                                ),
                              ),
                            ),


                            /*Padding(
                              padding: const EdgeInsets.only( top: 10),
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: displayProfilePic(
                                      widget.reciverUserName),
                                ),
                              ),
                            ),*/


                            Expanded(
                              flex:4,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 5.0, top: 10),
                                    child: Text(widget.reciverUserName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: new TextStyle(
                                          color: CustColors.DarkBlue,
                                          fontSize: 18.0,
                                          fontFamily: 'Formular',
                                        )),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child:   PopupMenuButton<String>(
                                padding: EdgeInsets.zero,
                                icon: new Padding(
                                  padding: const EdgeInsets.only( top: 10, left: 0, right: 0, bottom: 0),
                                  child: new SizedBox(
                                    height: 10,
                                    child: Image.asset("assets/images/chat_three_dots.png",),
                                  ),),
                                onSelected: (result) async {
                                  switch (result) {
                                    case 'Unfollow':
                                      print('click Unfollow');
                                      break;
                                    case 'Chat':
                                      print('click Chat');
                                      break;
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                                  /* const PopupMenuItem<String>(
                                      value: 'Unfollow',
                                      child: ListTile(
                                          title: Text(''))),
                                  const PopupMenuItem<String>(
                                      value: 'Chat',
                                      child: ListTile(
                                          title: Text(''))),*/
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget ChatViewListOfAllMessages()
  {
    return Container(
      height:MediaQuery.of(context).size.height * 0.77-56,
      child:StreamBuilder(
        stream: _firebaseMessagingDetails.singleChatMsgStream,
        builder: (context, snapshot) {




          if (snapshot.hasData) {
            print('list length is');
            print(snapshot.data.length);
            if (snapshot.data.length == 0) {
              return Container();
            } else
              {
                return SingleChildScrollView(
                  reverse: true,
                  child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: new NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {

                      String messageTime = DateFormat("hh:mm a")
                          .format(DateTime.fromMicrosecondsSinceEpoch(
                          int.parse(snapshot.data[index].time) * 1000))
                          .toString();


                      String checkingdate = DateFormat("yyyy-MM-dd")
                          .format(DateTime.fromMicrosecondsSinceEpoch(
                          int.parse(snapshot.data[index].time) * 1000))
                          .toString();

                      String valuedate='';
                      String valuedateTodayTommorow='';

                      if(snapshot.data.length==0 || snapshot.data.length!=1)
                      {
                        if(index==snapshot.data.length-1)
                        {
                          if(snapshot.data[index].dateGroupData==snapshot.data[index-1].dateGroupData)
                          {
                            valuedate="";
                            print("?????????????????????"+'$index' );
                          }
                          else
                          {
                            valuedateTodayTommorow = checkDate(checkingdate);
                            print("111111111111111111111111111" +
                                '$valuedateTodayTommorow');
                            valuedate = valuedateTodayTommorow == 'TODAY' ||
                                valuedateTodayTommorow == 'YESTERDAY' ?
                            valuedateTodayTommorow
                                : snapshot.data[index].dateGroupData;
                          }
                        }
                        else if(snapshot.data[index].dateGroupData!=snapshot.data[index+1].dateGroupData)
                        {
                          valuedateTodayTommorow = checkDate(checkingdate);
                          print("111111111111111111111111111" +
                              '$valuedateTodayTommorow');
                          valuedate = valuedateTodayTommorow == 'TODAY' ||
                              valuedateTodayTommorow == 'YESTERDAY' ?
                          valuedateTodayTommorow
                              : snapshot.data[index].dateGroupData;
                        }
                        else
                        {
                          valuedate="";
                        }
                      }
                      else
                      {
                        valuedate="";
                      }


                      return ListTile(
                        title:
                        Column(

                          children: [


                            valuedate!=""? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      color: CustColors.chatMsgTodayboxcolor ,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          '    $valuedate    ',
                                          style:
                                          TextStyle(
                                              color: CustColors.blueLight, fontWeight: FontWeight.w600,fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ):Container(),

                            snapshot.data[index].senderId==senderid ?
                            SenderUi(senderMsg: snapshot.data[index].message.toString(),sendername:snapshot.data[index].senderName.toString(),messageTime:messageTime)
                            :ReciverUi(reciverMsg: snapshot.data[index].message.toString(),recivername:snapshot.data[index].senderName.toString(),messageTime:messageTime),

                          ],
                        ),
                      );
                    },
                  ),
                );
              }
          }
          else
          {
            return  noDataFound();
          }

        },
      ),

    );
  }

  Widget messageSendWidget() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 0,top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: Column(
                children: [
                  Container(
                    height:55,
                    padding: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                    child:
                    TextField(
                      controller: _txtCtrl,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(2000),
                      ],
                      maxLines: 300,
                      decoration: InputDecoration(
                        prefixIcon:new Padding(
                          padding: const EdgeInsets.only( top: 15, left: 5, right: 0, bottom: 15),
                          child: new SizedBox(
                            height: 5,
                            child: Image.asset('assets/images/chat_smiley.png'),
                          ),),
                        hintText: "Type here...",
                        hintStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16),
                        fillColor: CustColors.LightRose,
                      ),
                    ),
                  ),
                ],
              )),
          SizedBox(
            width: 10,
          ),
          InkWell(
            child: Container(
              height: 45,
              width: 45,
              child: Image.asset('assets/images/chat_send_icon.png'),
            ),
            onTap: () {
              if(_txtCtrl.text==""||_txtCtrl.text.isEmpty)
              {

              }
              else
              {
                _firebaseMessagingDetails.sendMessageOneToOne(
                  _txtCtrl.text,
                  reciverid,
                  reciverFcm,
                  senderid,
                  senderFcm,
                  senderName,
                  senderImage,
                  reciverUserName,
                  reciverImage,
                );
                _txtCtrl.text="";
              }

            },
          )
        ],
      ),
    );
  }

  Widget ReciverUi({String reciverMsg, recivername, messageTime})
  {
    return ChatBubble(
      clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
      alignment: Alignment.topLeft,

      margin: EdgeInsets.only(top: 5),
      backGroundColor: CustColors.chatMsgReciverboxcolor,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child:
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                recivername,
                style: TextStyle(fontSize: 13,color: CustColors.LightDarkBlue,fontWeight: FontWeight.w600,),
              ),
            ),

            Stack(
              children: [
                Text(
                  reciverMsg + '                          ',
                  style: TextStyle(fontSize: 17,color:CustColors.chatMsgReciverlightblueOff,fontWeight: FontWeight.normal,),
                ),
                Positioned(
                  width: 70,
                  height: 20,
                  right: 0,
                  bottom: 0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        messageTime,
                        style: TextStyle(color:CustColors.chatMsgReciverlightblueOff,fontSize: 11),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            )

          ],
        ),

      ),




    );
  }

  Widget SenderUi({String senderMsg, sendername, messageTime})
  {
    return ChatBubble(
      clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: 20),
      backGroundColor: CustColors.DarkBlue,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child:  Container(
          child: new Padding(
            padding: new EdgeInsets.all(7.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right:10),
                      child: Text(
                        '$senderMsg                            ',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 16,color: Colors.white),
                      ),
                    ),
                    Positioned(
                      width: 80,
                      height: 20,
                      right: 0,
                      bottom: 0,
                      child: Row(

                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '       $messageTime',
                            style: TextStyle(color: Colors.white,fontSize: 10),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
                Text('No Messages Yet',
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


  void listenApi() {
    _chatPageBloc.getUserDetailsStream.listen((data) {
      if ((data.status == "success")) {
        print("${data.status}");

        if (data.data.userProfile.length != 0)
        {
          if (data.data.userProfile[0].profilePic != null) {
            userProfilePic = data.data.userProfile[0].profilePic;
          }
          else {
            userProfilePic = "";
          }
        }
        else
        {
          userProfilePic = '';
        }


        if (data.data.userProfile.length != 0)
        {
          userProfileAliasName = '${data.data.userProfile[0].aliasName}';
          userProfileName = '${data.data.userProfile[0].displayName}';
        } else
        {
          userProfileName = '${data.data.username}';
          userProfileAliasName = '';
        }
        if (data.data.userProfile.length != 0) {
          userProfileAliasFlag = '${data.data.userProfile[0].aliasFlag}';
        } else {
          userProfileAliasFlag = '0';
        }
      } else if ((data.status == "error")) {
        toastMsg(data.message);
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



  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }


  String checkDate(String dateString){

    //  example, dateString = "2020-01-26";

    DateTime checkedTime= DateTime.parse(dateString);
    DateTime currentTime= DateTime.now();

    if((currentTime.year == checkedTime.year)
        && (currentTime.month == checkedTime.month)
        && (currentTime.day == checkedTime.day))
    {
      return "TODAY";

    }
    /* else if((currentTime.year == checkedTime.year)
        && (currentTime.month == checkedTime.month))
    {
      if((currentTime.day - checkedTime.day) == 1){
        return "YESTERDAY";
      }else if((currentTime.day - checkedTime.day) == -1){
        return "TOMORROW";
      }else{
        return dateString;
      }

    }*/

  }

}