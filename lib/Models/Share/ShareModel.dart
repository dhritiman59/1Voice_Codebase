// To parse this JSON data, do
//
//     final joinLeaveCaseModel = joinLeaveCaseModelFromJson(jsonString);

import 'dart:convert';

ShareModel joinLeaveCaseModelFromJson(String str) =>
    ShareModel.fromJson(json.decode(str));

String joinLeaveCaseModelToJson(ShareModel data) => json.encode(data.toJson());

class ShareModel {
  ShareModel({
    this.status,
    this.message,
    this.error,
  });

  String status;
  String message;
  String error;

  factory ShareModel.fromJson(Map<String, dynamic> json) => ShareModel(
        status: json["status"],
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
      };
}
