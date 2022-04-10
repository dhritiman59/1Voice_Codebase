import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class ChatSingleModel {
  String key;

  String message;

  String time;

  String senderId;

  String file;

  String senderName;

  String dateGroupData;

  ChatSingleModel({
    this.key,
    this.message,
    this.senderId,
    this.senderName,
    this.time,
    this.dateGroupData,
    this.file,
  });

  // ChatSingleModel.fromSnapshot(DataSnapshot snapshot)

  //     : key = snapshot.key,

  //       message = snapshot.value["message"],

  //       senderId = snapshot.value["senderid"],

  //       senderName = snapshot.value["senderName"],

  //       file = snapshot.value["file"],

  //       time =  snapshot.value["timestamb"],

  //       dateGroupData = DateFormat("MMMM, dd yyyy")
  //           .format(DateTime.fromMicrosecondsSinceEpoch(
  //           int.parse(snapshot.value["timestamb"],) * 1000))
  //           .toString();

  factory ChatSingleModel.fromSnapshot(DataSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.value;
    return ChatSingleModel(
      key: snapshot.key,
      message: data["message"],
      senderId: data["senderid"],
      senderName: data["senderName"],
      file: data["file"],
      time: data["timestamb"],
      dateGroupData: DateFormat("MMMM, dd yyyy")
          .format(DateTime.fromMicrosecondsSinceEpoch(int.parse(
                data["timestamb"],
              ) *
              1000))
          .toString(),
    );
  }
}
