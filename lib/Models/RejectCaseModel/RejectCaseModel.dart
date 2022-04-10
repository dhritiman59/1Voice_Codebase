// To parse this JSON data, do
//
//     final rejectCaseModel = rejectCaseModelFromJson(jsonString);

import 'dart:convert';


class RejectCaseModel {
  RejectCaseModel({
    this.status,
    this.message,
    this.error,
  });

  String status;
  String message;
  String error;

  factory RejectCaseModel.fromJson(Map<String, dynamic> json) => RejectCaseModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    error: json["error"] == null ? null : json["error"],
  );

}
