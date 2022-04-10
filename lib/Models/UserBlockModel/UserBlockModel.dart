// To parse this JSON data, do
//
//     final userBlockModel = userBlockModelFromJson(jsonString);

import 'dart:convert';

UserBlockModel userBlockModelFromJson(String str) => UserBlockModel.fromJson(json.decode(str));

String userBlockModelToJson(UserBlockModel data) => json.encode(data.toJson());

class UserBlockModel {
  UserBlockModel({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory UserBlockModel.fromJson(Map<String, dynamic> json) => UserBlockModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
