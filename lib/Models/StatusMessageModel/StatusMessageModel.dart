// To parse this JSON data, do
//
//     final statusMessageModel = statusMessageModelFromJson(jsonString);

import 'dart:convert';

class StatusMessageModel {
  StatusMessageModel({
    this.status,
    this.message,
    this.error,
  });

  String status;
  String message;
  String error;

  factory StatusMessageModel.fromJson(Map<String, dynamic> json) => StatusMessageModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    error: json["error"] == null ? null : json["error"],
  );
}
