// To parse this JSON data, do
//
//     final removeFollowersModel = removeFollowersModelFromJson(jsonString);

import 'dart:convert';


class RemoveFollowersModel {
  RemoveFollowersModel({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory RemoveFollowersModel.fromJson(Map<String, dynamic> json) => RemoveFollowersModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );
}
