// To parse this JSON data, do
//
//     final joinLeaveCaseModel = joinLeaveCaseModelFromJson(jsonString);

import 'dart:convert';

RankCaseDown joinLeaveCaseModelFromJson(String str) => RankCaseDown.fromJson(json.decode(str));

String joinLeaveCaseModelToJson(RankCaseDown data) => json.encode(data.toJson());

class RankCaseDown {
  RankCaseDown({
    this.status,
    this.message,
    this.error,
  });

  String status;
  String message;
  String error;

  factory RankCaseDown.fromJson(Map<String, dynamic> json) => RankCaseDown(
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
