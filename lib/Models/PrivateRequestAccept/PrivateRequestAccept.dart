// To parse this JSON data, do
//
//     final privateRequestAccept = privateRequestAcceptFromJson(jsonString);

import 'dart:convert';

PrivateRequestAccept privateRequestAcceptFromJson(String str) => PrivateRequestAccept.fromJson(json.decode(str));

String privateRequestAcceptToJson(PrivateRequestAccept data) => json.encode(data.toJson());

class PrivateRequestAccept {
  PrivateRequestAccept({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory PrivateRequestAccept.fromJson(Map<String, dynamic> json) => PrivateRequestAccept(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
