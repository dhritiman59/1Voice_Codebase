// To parse this JSON data, do
//
//     final joinLeaveCaseModel = joinLeaveCaseModelFromJson(jsonString);

import 'dart:convert';

AddComment joinLeaveCaseModelFromJson(String str) => AddComment.fromJson(json.decode(str));

String joinLeaveCaseModelToJson(AddComment data) => json.encode(data.toJson());

class AddComment {
  AddComment({
    this.status,
    this.message,
    this.error,
  });

  String status;
  String message;
  String error;

  factory AddComment.fromJson(Map<String, dynamic> json) => AddComment(
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
