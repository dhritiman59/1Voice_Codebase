// To parse this JSON data, do
//
//     final getCoreMembers = getCoreMembersFromJson(jsonString);

import 'dart:convert';

GetCoreMembers getCoreMembersFromJson(String str) => GetCoreMembers.fromJson(json.decode(str));

String getCoreMembersToJson(GetCoreMembers data) => json.encode(data.toJson());

class GetCoreMembers {
  GetCoreMembers({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory GetCoreMembers.fromJson(Map<String, dynamic> json) => GetCoreMembers(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
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

  Map<String, dynamic> toJson() => {
    "totalItems": totalItems == null ? null : totalItems,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "totalPages": totalPages == null ? null : totalPages,
    "currentPage": currentPage == null ? null : currentPage,
  };
}

class Datum {
  Datum({
    this.id,
    this.isAdmin,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.caseId,
    this.userId,
    this.generalId,
    this.users,
  });

  int id;
  int isAdmin;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int caseId;
  int userId;
  int generalId;
  Users users;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    caseId: json["caseId"] == null ? null : json["caseId"],
    userId: json["userId"] == null ? null : json["userId"],
    generalId: json["generalId"] == null ? null : json["generalId"],
    users: json["users"] == null ? null : Users.fromJson(json["users"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "isAdmin": isAdmin == null ? null : isAdmin,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "caseId": caseId == null ? null : caseId,
    "userId": userId == null ? null : userId,
    "generalId": generalId == null ? null : generalId,
    "users": users == null ? null : users.toJson(),
  };
}

class Users {
  Users({
    this.displayName,
    this.userTypeId,
    this.emailId,
    this.followUser,
    this.userProfile,
  });

  String displayName;
  int userTypeId;
  String emailId;
  List<FollowUser> followUser;
  List<UserProfile> userProfile;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    displayName: json["displayName"] == null ? null : json["displayName"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    followUser: json["followUser"] == null ? null : List<FollowUser>.from(json["followUser"].map((x) => x)),
    userProfile: json["userProfile"] == null ? null : List<UserProfile>.from(json["userProfile"].map((x) => UserProfile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "displayName": displayName == null ? null : displayName,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "emailId": emailId == null ? null : emailId,
    "followUser": followUser == null ? null : List<FollowUser>.from(followUser.map((x) => x)),
    "userProfile": userProfile == null ? null : List<dynamic>.from(userProfile.map((x) => x.toJson())),
  };
}

class FollowUser {
  FollowUser({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.followingUserId,
    this.userId,
  });

  int id;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int followingUserId;
  int userId;

  factory FollowUser.fromJson(Map<String, dynamic> json) => FollowUser(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    followingUserId: json["followingUserId"] == null ? null : json["followingUserId"],
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "followingUserId": followingUserId == null ? null : followingUserId,
    "userId": userId == null ? null : userId,
  };
}

class UserProfile {
  UserProfile({
    this.profilePic,
    this.gender,
    this.aliasName,
    this.aliasFlag,
  });

  String profilePic;
  String gender;
  String aliasName;
  int aliasFlag;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    gender: json["gender"] == null ? null : json["gender"],
    aliasName: json["aliasName"] == null ? null : json["aliasName"],
    aliasFlag: json["aliasFlag"] == null ? null : json["aliasFlag"],
  );

  Map<String, dynamic> toJson() => {
    "profilePic": profilePic == null ? null : profilePic,
    "gender": gender == null ? null : gender,
    "aliasName": aliasName == null ? null : aliasName,
    "aliasFlag": aliasFlag == null ? null : aliasFlag,
  };
}
