// To parse this JSON data, do
//
//     final socialLoginMdl = socialLoginMdlFromJson(jsonString);

import 'dart:convert';

SocialLoginMdl socialLoginMdlFromJson(String str) => SocialLoginMdl.fromJson(json.decode(str));

String socialLoginMdlToJson(SocialLoginMdl data) => json.encode(data.toJson());

class SocialLoginMdl {
  SocialLoginMdl({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  SocialLoginMdlData data;

  factory SocialLoginMdl.fromJson(Map<String, dynamic> json) => SocialLoginMdl(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : SocialLoginMdlData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
}

class SocialLoginMdlData {
  SocialLoginMdlData({
    this.token,
    this.data,
  });

  String token;
  DataData data;

  factory SocialLoginMdlData.fromJson(Map<String, dynamic> json) => SocialLoginMdlData(
    token: json["token"] == null ? null : json["token"],
    data: json["data"] == null ? null : DataData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "data": data == null ? null : data.toJson(),
  };
}

class DataData {
  DataData({
    this.id,
    this.username,
    this.password,
    this.emailId,
    this.phone,
    this.displayName,
    this.socialId,
    this.loginType,
    this.randomKey,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userTypeId,
  });

  int id;
  String username;
  dynamic password;
  String emailId;
  dynamic phone;
  String displayName;
  String socialId;
  int loginType;
  dynamic randomKey;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int userTypeId;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    id: json["id"] == null ? null : json["id"],
    username: json["username"] == null ? null : json["username"],
    password: json["password"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phone: json["phone"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    socialId: json["socialId"] == null ? null : json["socialId"],
    loginType: json["loginType"] == null ? null : int.parse(json["loginType"].toString()),
    randomKey: json["randomKey"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "username": username == null ? null : username,
    "password": password,
    "emailId": emailId == null ? null : emailId,
    "phone": phone,
    "displayName": displayName == null ? null : displayName,
    "socialId": socialId == null ? null : socialId,
    "loginType": loginType == null ? null : loginType,
    "randomKey": randomKey,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userTypeId": userTypeId == null ? null : userTypeId,
  };
}
