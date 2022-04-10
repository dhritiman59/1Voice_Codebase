// To parse this JSON data, do
//
//     final closeCaseModel = closeCaseModelFromJson(jsonString);

import 'dart:convert';

CloseCaseModel closeCaseModelFromJson(String str) => CloseCaseModel.fromJson(json.decode(str));

String closeCaseModelToJson(CloseCaseModel data) => json.encode(data.toJson());

class CloseCaseModel {
  CloseCaseModel({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory CloseCaseModel.fromJson(Map<String, dynamic> json) => CloseCaseModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
