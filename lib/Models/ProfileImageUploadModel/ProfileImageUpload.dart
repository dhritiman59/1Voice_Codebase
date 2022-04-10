// To parse this JSON data, do
//
//     final profileImageUpload = profileImageUploadFromJson(jsonString);

import 'dart:convert';


class ProfileImageUpload {
  ProfileImageUpload({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory ProfileImageUpload.fromJson(Map<String, dynamic> json) => ProfileImageUpload(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  Data({
    this.userId,
    this.profilePic,
  });

  int userId;
  String profilePic;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["userId"] == null ? null : json["userId"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
  );

}
