// To parse this JSON data, do
//
//     final coreMemberSelection = coreMemberSelectionFromJson(jsonString);

import 'dart:convert';

CoreMemberSelection coreMemberSelectionFromJson(String str) => CoreMemberSelection.fromJson(json.decode(str));

String coreMemberSelectionToJson(CoreMemberSelection data) => json.encode(data.toJson());

class CoreMemberSelection {
  CoreMemberSelection({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory CoreMemberSelection.fromJson(Map<String, dynamic> json) => CoreMemberSelection(
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
    this.accepted,
    this.totalItems,
    this.data,
    this.totalPages,
    this.currentPage,
  });

  int accepted;
  int totalItems;
  List<Datum> data;
  int totalPages;
  int currentPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accepted: json["accepted"] == null ? null : json["accepted"],
    totalItems: json["totalItems"] == null ? null : json["totalItems"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
  );

  Map<String, dynamic> toJson() => {
    "accepted": accepted == null ? null : accepted,
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
    this.joinedCaseCount,
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
  int joinedCaseCount;

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
    joinedCaseCount: json["joinedCaseCount"] == null ? null : json["joinedCaseCount"],
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
    "joinedCaseCount": joinedCaseCount == null ? null : joinedCaseCount,
  };
}

class Users {
  Users({
    this.displayName,
    this.userTypeId,
    this.emailId,
    this.userProfile,
    this.proUsersData,
    this.joinedUser,
  });

  String displayName;
  int userTypeId;
  String emailId;
  List<UserProfile> userProfile;
  List<dynamic> proUsersData;
  List<JoinedUser> joinedUser;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    displayName: json["displayName"] == null ? null : json["displayName"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    userProfile: json["userProfile"] == null ? null : List<UserProfile>.from(json["userProfile"].map((x) => UserProfile.fromJson(x))),
    proUsersData: json["proUsersData"] == null ? null : List<dynamic>.from(json["proUsersData"].map((x) => x)),
    joinedUser: json["joinedUser"] == null ? null : List<JoinedUser>.from(json["joinedUser"].map((x) => JoinedUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "displayName": displayName == null ? null : displayName,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "emailId": emailId == null ? null : emailId,
    "userProfile": userProfile == null ? null : List<dynamic>.from(userProfile.map((x) => x.toJson())),
    "proUsersData": proUsersData == null ? null : List<dynamic>.from(proUsersData.map((x) => x)),
    "joinedUser": joinedUser == null ? null : List<dynamic>.from(joinedUser.map((x) => x.toJson())),
  };
}

class JoinedUser {
  JoinedUser({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.caseId,
    this.userId,
    this.generalId,
  });

  int id;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int caseId;
  int userId;
  int generalId;

  factory JoinedUser.fromJson(Map<String, dynamic> json) => JoinedUser(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    caseId: json["caseId"] == null ? null : json["caseId"],
    userId: json["userId"] == null ? null : json["userId"],
    generalId: json["generalId"] == null ? null : json["generalId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "caseId": caseId == null ? null : caseId,
    "userId": userId == null ? null : userId,
    "generalId": generalId == null ? null : generalId,
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
  dynamic gender;
  dynamic aliasName;
  int aliasFlag;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    gender: json["gender"],
    aliasName: json["aliasName"],
    aliasFlag: json["aliasFlag"] == null ? null : json["aliasFlag"],
  );

  Map<String, dynamic> toJson() => {
    "profilePic": profilePic == null ? null : profilePic,
    "gender": gender,
    "aliasName": aliasName,
    "aliasFlag": aliasFlag == null ? null : aliasFlag,
  };
}
