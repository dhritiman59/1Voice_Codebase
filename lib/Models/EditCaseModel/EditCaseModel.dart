// To parse this JSON data, do
//
//     final editCaseModel = editCaseModelFromJson(jsonString);

import 'dart:convert';

class EditCaseModel {
  EditCaseModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory EditCaseModel.fromJson(Map<String, dynamic> json) => EditCaseModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.usersRef,
    this.images,
    this.doc,
    this.video,
  });

  UsersRef usersRef;
  List<Images> images;
  List<dynamic> doc;
  List<dynamic> video;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    usersRef: json["UsersRef"] == null ? null : UsersRef.fromJson(json["UsersRef"]),
    images: json["image"] == null ? null : List<Images>.from(json["image"].map((x) => Images.fromJson(x))),
    doc: json["doc"] == null ? null : List<dynamic>.from(json["doc"].map((x) => x)),
    video: json["video"] == null ? null : List<dynamic>.from(json["video"].map((x) => x)),
  );
}

class Images {
  Images({
    this.id,
    this.caseDocument,
    this.docType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.caseId,
  });

  int id;
  String caseDocument;
  String docType;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int caseId;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    id: json["id"] == null ? null : json["id"],
    caseDocument: json["caseDocument"] == null ? null : json["caseDocument"],
    docType: json["docType"] == null ? null : json["docType"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    caseId: json["caseId"] == null ? null : json["caseId"],
  );
}

class UsersRef {
  UsersRef({
    this.id,
    this.caseCode,
    this.caseTitle,
    this.caseDescription,
    this.country,
    this.state,
    this.minAmount,
    this.donationReceived,
    this.commentCount,
    this.rankCount,
    this.reportCount,
    this.approvedFlag,
    this.featuredFlag,
    this.caseTypeFlag,
    this.caseCategory,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.generalId,
    this.users,
    this.userProfile,
    this.caseDocument,
    this.rankCase,
    this.joinedUser,
    this.coreGroup,
  });

  int id;
  String caseCode;
  String caseTitle;
  String caseDescription;
  String country;
  String state;
  String minAmount;
  String donationReceived;
  int commentCount;
  int rankCount;
  int reportCount;
  int approvedFlag;
  int featuredFlag;
  int caseTypeFlag;
  String caseCategory;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  int generalId;
  Users users;
  UserProfile userProfile;
  List<Images> caseDocument;
  List<dynamic> rankCase;
  List<dynamic> joinedUser;
  List<dynamic> coreGroup;

  factory UsersRef.fromJson(Map<String, dynamic> json) => UsersRef(
    id: json["id"] == null ? null : json["id"],
    caseCode: json["caseCode"] == null ? null : json["caseCode"],
    caseTitle: json["caseTitle"] == null ? null : json["caseTitle"],
    caseDescription: json["caseDescription"] == null ? null : json["caseDescription"],
    country: json["country"] == null ? null : json["country"],
    state: json["state"] == null ? null : json["state"],
    minAmount: json["minAmount"] == null ? null : json["minAmount"],
    donationReceived: json["donationReceived"] == null ? null : json["donationReceived"],
    commentCount: json["commentCount"] == null ? null : json["commentCount"],
    rankCount: json["rankCount"] == null ? null : json["rankCount"],
    reportCount: json["reportCount"] == null ? null : json["reportCount"],
    approvedFlag: json["approvedFlag"] == null ? null : json["approvedFlag"],
    featuredFlag: json["featuredFlag"] == null ? null : json["featuredFlag"],
    caseTypeFlag: json["caseTypeFlag"] == null ? null : json["caseTypeFlag"],
    caseCategory: json["caseCategory"] == null ? null : json["caseCategory"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userId: json["userId"] == null ? null : json["userId"],
    generalId: json["generalId"] == null ? null : json["generalId"],
    users: json["users"] == null ? null : Users.fromJson(json["users"]),
    userProfile: json["userProfile"] == null ? null : UserProfile.fromJson(json["userProfile"]),
    caseDocument: json["caseDocument"] == null ? null : List<Images>.from(json["caseDocument"].map((x) => Images.fromJson(x))),
    rankCase: json["rankCase"] == null ? null : List<dynamic>.from(json["rankCase"].map((x) => x)),
    joinedUser: json["joinedUser"] == null ? null : List<dynamic>.from(json["joinedUser"].map((x) => x)),
    coreGroup: json["coreGroup"] == null ? null : List<dynamic>.from(json["coreGroup"].map((x) => x)),
  );
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
}

class Users {
  Users({
    this.displayName,
    this.userTypeId,
    this.emailId,
  });

  String displayName;
  int userTypeId;
  String emailId;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    displayName: json["displayName"] == null ? null : json["displayName"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    emailId: json["emailId"] == null ? null : json["emailId"],
  );
}
