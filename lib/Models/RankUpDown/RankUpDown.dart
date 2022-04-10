// To parse this JSON data, do
//
//     final joinLeaveCaseModel = joinLeaveCaseModelFromJson(jsonString);

import 'dart:convert';

RankUpDown joinLeaveCaseModelFromJson(String str) => RankUpDown.fromJson(json.decode(str));

String joinLeaveCaseModelToJson(RankUpDown data) => json.encode(data.toJson());

class RankUpDown {
  RankUpDown({
    this.status,
    this.message,
    this.error,
  });

  String status;
  String message;
  String error;

  factory RankUpDown.fromJson(Map<String, dynamic> json) => RankUpDown(
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
