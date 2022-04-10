// To parse this JSON data, do
//
//     final registrationBean = registrationBeanFromJson(jsonString);

import 'dart:convert';

RegistrationBean registrationBeanFromJson(String str) => RegistrationBean.fromJson(json.decode(str));

String registrationBeanToJson(RegistrationBean data) => json.encode(data.toJson());

class RegistrationBean {
  RegistrationBean({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  RegistrationBeanData data;

  factory RegistrationBean.fromJson(Map<String, dynamic> json) => RegistrationBean(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : RegistrationBeanData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
}

class RegistrationBeanData {
  RegistrationBeanData({
    this.token,
    this.data,
  });

  String token;
  DataData data;

  factory RegistrationBeanData.fromJson(Map<String, dynamic> json) => RegistrationBeanData(
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
    this.verificationStatus,
    this.createdAt,
    this.updatedAt,
    this.userTypeId,
  });

  int id;
  String username;
  String password;
  String emailId;
  String phone;
  String displayName;
  dynamic socialId;
  int loginType;
  String randomKey;
  int status;
  int verificationStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int userTypeId;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    id: json["id"] == null ? null : json["id"],
    username: json["username"] == null ? null : json["username"],
    password: json["password"] == null ? null : json["password"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phone: json["phone"] == null ? null : json["phone"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    socialId: json["socialId"],
    loginType: json["loginType"] == null ? null :int.parse(json["loginType"].toString()),
    randomKey: json["randomKey"] == null ? null : json["randomKey"],
    status: json["status"] == null ? null : json["status"],
    verificationStatus: json["verificationStatus"] == null ? null : json["verificationStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "username": username == null ? null : username,
    "password": password == null ? null : password,
    "emailId": emailId == null ? null : emailId,
    "phone": phone == null ? null : phone,
    "displayName": displayName == null ? null : displayName,
    "socialId": socialId,
    "loginType": loginType == null ? null : loginType,
    "randomKey": randomKey == null ? null : randomKey,
    "status": status == null ? null : status,
    "verificationStatus": verificationStatus == null ? null : verificationStatus,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userTypeId": userTypeId == null ? null : userTypeId,
  };
}
