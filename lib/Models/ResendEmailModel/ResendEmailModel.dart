// To parse this JSON data, do
//
//     final resendEmailModel = resendEmailModelFromJson(jsonString);

import 'dart:convert';


class ResendEmailModel {
  ResendEmailModel({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory ResendEmailModel.fromJson(Map<String, dynamic> json) => ResendEmailModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

}
