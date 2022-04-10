// To parse this JSON data, do
//
//     final closeCaseModel = closeCaseModelFromJson(jsonString);

import 'dart:convert';

ReportCommentModel closeCaseModelFromJson(String str) => ReportCommentModel.fromJson(json.decode(str));

String closeCaseModelToJson(ReportCommentModel data) => json.encode(data.toJson());

class ReportCommentModel {
  ReportCommentModel({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory ReportCommentModel.fromJson(Map<String, dynamic> json) => ReportCommentModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
