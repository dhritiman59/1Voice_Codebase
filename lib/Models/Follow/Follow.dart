// To parse this JSON data, do
//
//     final joinLeaveCaseModel = joinLeaveCaseModelFromJson(jsonString);

import 'dart:convert';

Follow joinLeaveCaseModelFromJson(String str) => Follow.fromJson(json.decode(str));

String joinLeaveCaseModelToJson(Follow data) => json.encode(data.toJson());

class Follow {
  Follow({
    this.status,
    this.message,
    this.error,
  });

  String status;
  String message;
  String error;

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
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
