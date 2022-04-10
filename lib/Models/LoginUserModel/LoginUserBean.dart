// To parse this JSON data, do
//
//     final loginUserBean = loginUserBeanFromJson(jsonString);

import 'dart:convert';

LoginUserBean loginUserBeanFromJson(String str) => LoginUserBean.fromJson(json.decode(str));

String loginUserBeanToJson(LoginUserBean data) => json.encode(data.toJson());

class LoginUserBean {
  LoginUserBean({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  LoginUserBeanData data;

  factory LoginUserBean.fromJson(Map<String, dynamic> json) => LoginUserBean(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : LoginUserBeanData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
}

class LoginUserBeanData {
  LoginUserBeanData({
    this.token,
    this.data,
  });

  String token;
  DataData data;

  factory LoginUserBeanData.fromJson(Map<String, dynamic> json) => LoginUserBeanData(
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
    this.status,
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
  int status;
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
    status: json["status"] == null ? null : json["status"],
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
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userTypeId": userTypeId == null ? null : userTypeId,
  };
}
