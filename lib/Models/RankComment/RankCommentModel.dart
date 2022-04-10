// To parse this JSON data, do
//
//     final joinLeaveCaseModel = joinLeaveCaseModelFromJson(jsonString);

import 'dart:convert';

RankCommentModel joinLeaveCaseModelFromJson(String str) => RankCommentModel.fromJson(json.decode(str));

String joinLeaveCaseModelToJson(RankCommentModel data) => json.encode(data.toJson());

class RankCommentModel {
  RankCommentModel({
    this.status,
    this.message,
    this.error,
  });

  String status;
  String message;
  String error;

  factory RankCommentModel.fromJson(Map<String, dynamic> json) => RankCommentModel(
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
