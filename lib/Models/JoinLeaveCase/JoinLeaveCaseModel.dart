// To parse this JSON data, do
//
//     final joinLeaveCaseModel = joinLeaveCaseModelFromJson(jsonString);

import 'dart:convert';

JoinLeaveCaseModel joinLeaveCaseModelFromJson(String str) => JoinLeaveCaseModel.fromJson(json.decode(str));

String joinLeaveCaseModelToJson(JoinLeaveCaseModel data) => json.encode(data.toJson());

class JoinLeaveCaseModel {
  JoinLeaveCaseModel({
    this.status,
    this.message,
    this.error,
  });

  String status;
  String message;
  String error;

  factory JoinLeaveCaseModel.fromJson(Map<String, dynamic> json) => JoinLeaveCaseModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    error: json["error"] == null ? null : json["error"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "error": error == null ? null : error,
  };
}
