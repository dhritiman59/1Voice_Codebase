import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class ChatGroupModel {
  String key;

  String message;

  String time;

  String senderId;

  String senderName;

  String file;

  String caseId;

  String caseName;

  String dateGroupData;

  ChatGroupModel(
      {this.key,
      this.message,
      this.senderId,
      this.senderName,
      this.time,
      this.caseId,
      this.caseName,
      this.dateGroupData,
      this.file});

  // ChatGroupModel.fromSnapshot(DataSnapshot snapshot)

  //     : key = snapshot.key,

  //       message = snapshot.value["message"],

  //       senderId = snapshot.value["senderId"],

  //       senderName = snapshot.value["senderName"],

  //       caseId = snapshot.value["caseId"],

  //       caseName = snapshot.value["caseName"],

  //       file =  snapshot.value["file"],

  //       time =  snapshot.value["timestamb"],

  //      dateGroupData = DateFormat("MMMM, dd yyyy")
  //          .format(DateTime.fromMicrosecondsSinceEpoch(
  //          int.parse( snapshot.value["timestamb"]) * 1000))
  //          .toString();

  factory ChatGroupModel.fromSnapshot(DataSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.value;
    return ChatGroupModel(
      key: snapshot.key,
      message: map["message"],
      senderId: map["senderId"],
      senderName: map["senderName"],
      caseId: map["caseId"],
      caseName: map["caseName"],
      file: map["file"],
      time: map["timestamb"],
      dateGroupData: DateFormat("MMMM, dd yyyy")
          .format(DateTime.fromMicrosecondsSinceEpoch(
              int.parse(map["timestamb"]) * 1000))
          .toString(),
    );
  }
}
