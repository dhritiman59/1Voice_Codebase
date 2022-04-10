// To parse this JSON data, do
//
//     final reportUserModel = reportUserModelFromJson(jsonString);

import 'dart:convert';

ReportUserModel reportUserModelFromJson(String str) => ReportUserModel.fromJson(json.decode(str));

String reportUserModelToJson(ReportUserModel data) => json.encode(data.toJson());

class ReportUserModel {
  ReportUserModel({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory ReportUserModel.fromJson(Map<String, dynamic> json) => ReportUserModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
