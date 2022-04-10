import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:bring2book/Models/ChatGroupModel/ChatGroupModel.dart';
import 'package:bring2book/Models/ChatSingleModel/ChatSingleModel.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseMessagingDetails {
  String groupChatListId;
  String singlechatListId;
  String userId;
  var recieverid = '';
  var _onTodoAddedSubscription;
  final List<ChatGroupModel> _chatList = [];

  final List<ChatSingleModel> _singleChatList = [];

  String recieverName;
  String recieverId;
  String recieverImage;
  String senderName;
  String senderId;
  String senderImage;
  String senderFcmToken;
  String receiverFcmToken;

  final firebaseref = FirebaseDatabase.instance.reference();

  StreamController groupChatController =
      StreamController<List<ChatGroupModel>>();
  Stream<List<ChatGroupModel>> get chaMsgStream => groupChatController.stream;
  StreamSink<List<ChatGroupModel>> get chaMsgSink => groupChatController.sink;

  StreamController singleChatController =
      StreamController<List<ChatSingleModel>>();
  Stream<List<ChatSingleModel>> get singleChatMsgStream =>
      singleChatController.stream;
  StreamSink<List<ChatSingleModel>> get singleChatMsgSink =>
      singleChatController.sink;

  //ScrollController chatListController = ScrollController();

  void setGroupChatListId(
      {String caseId,
      String caseTitleForGroupChat,
      String caseImage,
      String senderName,
      String senderId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _userId = prefs.getString(SharedPrefKey.USER_ID);
    userId = _userId;
    print('userid is $userId');

    int groupCaseId = int.parse(caseId);
    String childFirebaseUserId;
    childFirebaseUserId = 'Group@_ID$groupCaseId';
    groupChatListId = childFirebaseUserId;
    print(groupChatListId);
    getMessages();
  }

  void getMessages() {
    final query = firebaseref.child('chats').child(groupChatListId);

    query.limitToLast(50).once().then((snapshot) {
      print("Done loading all data for query");
    });

    FirebaseDatabase.instance
        .reference()
        .child('chats')
        .child(groupChatListId)
        .onChildAdded
        .listen((event) {
      print('child added');

      _chatList.insert(0, ChatGroupModel.fromSnapshot(event.snapshot));
      chaMsgSink.add(_chatList);
      /*chatListController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);*/
    });
  }

  void setSingleChatListId({
    String senderid,
    String senderName,
    String senderImage,
    String reciverid,
    String reciverFcm,
    String reciverUserName,
    String reciverImage,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _userId = prefs.getString(SharedPrefKey.USER_ID);
    userId = _userId;
    print('userid is $userId');

    int reciverid1 = int.parse(reciverid);
    int senderid1 = int.parse(userId);
    String childFirebaseUserId;

    if (reciverid1 > senderid1) {
      childFirebaseUserId = 'S$senderid1@_R$reciverid1';
    } else {
      childFirebaseUserId = 'S$reciverid1@_R$senderid1';
    }

    singlechatListId = childFirebaseUserId;
    print(singlechatListId);
    getSingleChatMessages();
  }

  void getSingleChatMessages() {
    final query = firebaseref.child('chats').child(singlechatListId);

    query.limitToLast(50).once().then((snapshot) {
      print("Done loading all data for query");
    });

    FirebaseDatabase.instance
        .reference()
        .child('chats')
        .child(singlechatListId)
        .onChildAdded
        .listen((event) {
      print('child added');

      _singleChatList.insert(0, ChatSingleModel.fromSnapshot(event.snapshot));
      singleChatMsgSink.add(_singleChatList);
      /* chatListController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);*/
    });
  }

  DatabaseReference ref1 = FirebaseDatabase.instance.reference().child('chats');

  sendMessageOneToOne(
    String text,
    String reciverid,
    String reciverFcm,
    String senderid,
    String senderFcm,
    String senderName,
    String senderImage,
    String reciverUserName,
    String reciverImage,
  ) {
    int reciverid1 = int.parse(reciverid);
    int senderid1 = int.parse(senderid);
    String childFirebaseUserId;

    if (reciverid1 > senderid1) {
      childFirebaseUserId = 'S$senderid1@_R$reciverid1';
    } else {
      childFirebaseUserId = 'S$reciverid1@_R$senderid1';
    }
    ref1.child(childFirebaseUserId).push().set({
      "senderid": senderid,
      "senderName": senderName,
      "message": text,
      "file": '',
      "timestamb": DateTime.now().millisecondsSinceEpoch.toString()
    });

    // firebaseref.child('RecentChats').child(senderid).child(reciverid).once().then((DataSnapshot snapshot) {
    //   print('Data : ${snapshot.value}-------------------');
    //   if (snapshot.value == null) {
    //     firebaseref.child('RecentChats').child(senderid).child(reciverid).set({

    //       "senderid": senderid,
    //       "senderName": senderName,
    //       "senderImage": senderImage,
    //       "message": text,
    //       "timestamb": DateTime.now().millisecondsSinceEpoch.toString(),
    //       "userId": reciverid,
    //       "userFcm": reciverFcm,
    //       "username": reciverUserName,
    //       "userimage": reciverImage,
    //       "messageType":'1'
    //     });

    //     print("Item doesn't exist in the db");
    //   } else {
    //     firebaseref.child('RecentChats').child(senderid).child(reciverid).update({
    //       "senderid": senderid,
    //       "senderName": senderName,
    //       "senderImage": senderImage,
    //       "message": text,
    //       "timestamb": DateTime.now().millisecondsSinceEpoch.toString(),
    //       "userId": reciverid,
    //       "userFcm": reciverFcm,
    //       "username": reciverUserName,
    //       "userimage": reciverImage,
    //       "messageType":'1'
    //     });
    //     print("Item exists in the db");
    //   }
    // });

    // firebaseref.child('RecentChats').child(reciverid).child(senderid).once().then((DataSnapshot snapshot) {
    //   print('Data : ${snapshot.value}-------------------');
    //   if (snapshot.value == null) {
    //     firebaseref.child('RecentChats').child(reciverid).child(senderid).set({
    //       "senderid": senderid,
    //       "senderName": senderName,
    //       "senderImage": senderImage,
    //       "message": text,
    //       "timestamb": DateTime.now().millisecondsSinceEpoch.toString(),
    //       "userId": senderid,
    //       "userFcm": senderFcm,
    //       "username": senderName,
    //       "userimage": senderImage,
    //       "messageType":'1'
    //     });

    //     print("Item doesn't exist in the db");
    //   } else {
    //     firebaseref.child('RecentChats').child(reciverid).child(senderid).update({
    //       "senderid": senderid,
    //       "senderName": senderName,
    //       "senderImage": senderImage,
    //       "message": text,
    //       "timestamb": DateTime.now().millisecondsSinceEpoch.toString(),
    //       "userId": senderid,
    //       "userFcm": senderFcm,
    //       "username": senderName,
    //       "userimage": senderImage,
    //       "messageType":'1'
    //     });
    //     print("Item exists in the db");
    //   }
    // });
  }

  sendMessageGroupChat(String text, String caseId, String caseTitleForGroupChat,
      String caseImage, String senderid, String userProfileName) {
    int groupCaseId = int.parse(caseId);
    String childFirebaseUserId;
    childFirebaseUserId = 'Group@_ID$groupCaseId';

    ref1.child(childFirebaseUserId).push().set({
      "caseId": caseId,
      "caseName": caseTitleForGroupChat,
      "senderId": senderid,
      "senderName": userProfileName,
      "message": text,
      "file": '',
      "timestamb": DateTime.now().millisecondsSinceEpoch.toString(),
    });

    // firebaseref.child('RecentChats').child(childFirebaseUserId).once().then((DataSnapshot snapshot) {
    //   print('Data : ${snapshot.value}-------------------');
    //   if (snapshot.value == null) {
    //     firebaseref.child('RecentChats').child(senderid).child(childFirebaseUserId).set({
    //       "caseId":caseId,
    //       "caseName":caseTitleForGroupChat,
    //       "caseImage":caseImage,
    //       "timestamb": DateTime.now().millisecondsSinceEpoch.toString(),
    //       "messageType":'2'
    //     });

    //     print("Item doesn't exist in the db");
    //   } else {
    //     firebaseref.child('RecentChats').child(senderid).child(childFirebaseUserId).update({
    //       "caseId":caseId,
    //       "caseName":caseTitleForGroupChat,
    //       "caseImage":caseImage,
    //       "timestamb": DateTime.now().millisecondsSinceEpoch.toString(),
    //       "messageType":'2'
    //     });
    //     print("Item exists in the db");
    //   }
    // });

    firebaseref.child('RecentChats').child(childFirebaseUserId).set({
      "caseId": caseId,
      "caseName": caseTitleForGroupChat,
      "senderId": senderid,
      "senderName": userProfileName,
      "message": text,
      "file": '',
      "timestamb": DateTime.now().millisecondsSinceEpoch.toString(),
      "messageType": '2'
    });
  }
}
