// To parse this JSON data, do
//
//     final followingsResponseModel = followingsResponseModelFromJson(jsonString);

import 'dart:convert';


class FollowingsResponseModel {
  FollowingsResponseModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory FollowingsResponseModel.fromJson(Map<String, dynamic> json) => FollowingsResponseModel(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  Data({
    this.totalItems,
    this.data,
    this.totalPages,
    this.currentPage,
  });

  int totalItems;
  List<Datum> data;
  int totalPages;
  int currentPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalItems: json["totalItems"] == null ? null : json["totalItems"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
  );

}

class Datum {
  Datum({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.followingUserId,
    this.userId,
    this.followingUsers,
  });

  int id;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int followingUserId;
  int userId;
  FollowingUsers followingUsers;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    followingUserId: json["followingUserId"] == null ? null : json["followingUserId"],
    userId: json["userId"] == null ? null : json["userId"],
    followingUsers: json["followingUsers"] == null ? null : FollowingUsers.fromJson(json["followingUsers"]),
  );

}

class FollowingUsers {
  FollowingUsers({
    this.id,
    this.username,
    this.password,
    this.emailId,
    this.phone,
    this.displayName,
    this.socialId,
    this.loginType,
    this.randomKey,
    this.heroPoints,
    this.deviceId,
    this.status,
    this.verificationStatus,
    this.createdAt,
    this.updatedAt,
    this.userTypeId,
    this.userProfile,
    this.proUsersData,
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
  int heroPoints;
  dynamic deviceId;
  int status;
  int verificationStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int userTypeId;
  List<UserProfile> userProfile;
  List<dynamic> proUsersData;

  factory FollowingUsers.fromJson(Map<String, dynamic> json) => FollowingUsers(
    id: json["id"] == null ? null : json["id"],
    username: json["username"] == null ? null : json["username"],
    password: json["password"] == null ? null : json["password"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phone: json["phone"] == null ? null : json["phone"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    socialId: json["socialId"],
    loginType: json["loginType"] == null ? null :  int.parse(json["loginType"].toString()),
    randomKey: json["randomKey"] == null ? null : json["randomKey"],
    heroPoints: json["heroPoints"] == null ? null : json["heroPoints"],
    deviceId: json["device_id"],
    status: json["status"] == null ? null : json["status"],
    verificationStatus: json["verificationStatus"] == null ? null : json["verificationStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    userProfile: json["userProfile"] == null ? null : List<UserProfile>.from(json["userProfile"].map((x) => UserProfile.fromJson(x))),
    proUsersData: json["proUsersData"] == null ? null : List<dynamic>.from(json["proUsersData"].map((x) => x)),
  );

}

class UserProfile {
  UserProfile({
    this.id,
    this.displayName,
    this.aliasName,
    this.dob,
    this.gender,
    this.country,
    this.profilePic,
    this.aliasFlag,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  int id;
  String displayName;
  dynamic aliasName;
  dynamic dob;
  String gender;
  dynamic country;
  dynamic profilePic;
  int aliasFlag;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["id"] == null ? null : json["id"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    aliasName: json["aliasName"],
    dob: json["dob"],
    gender: json["gender"] == null ? null : json["gender"],
    country: json["country"],
    profilePic: json["profilePic"],
    aliasFlag: json["aliasFlag"] == null ? null : json["aliasFlag"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userId: json["userId"] == null ? null : json["userId"],
  );

}
