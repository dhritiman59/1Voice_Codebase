// To parse this JSON data, do
//
//     final caseDetailsModel = caseDetailsModelFromJson(jsonString);

import 'dart:convert';

CaseDetailsModel caseDetailsModelFromJson(String str) => CaseDetailsModel.fromJson(json.decode(str));

String caseDetailsModelToJson(CaseDetailsModel data) => json.encode(data.toJson());

class CaseDetailsModel {
  CaseDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory CaseDetailsModel.fromJson(Map<String, dynamic> json) => CaseDetailsModel(
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
    this.usersRef,
    this.image,
    this.doc,
  });

  UsersRef usersRef;
  List<Doc> image;
  List<Doc> doc;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    usersRef: json["UsersRef"] == null ? null : UsersRef.fromJson(json["UsersRef"]),
    image: json["image"] == null ? null : List<Doc>.from(json["image"].map((x) => Doc.fromJson(x))),
    doc: json["doc"] == null ? null : List<Doc>.from(json["doc"].map((x) => Doc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "UsersRef": usersRef == null ? null : usersRef.toJson(),
    "image": image == null ? null : List<dynamic>.from(image.map((x) => x.toJson())),
    "doc": doc == null ? null : List<dynamic>.from(doc.map((x) => x.toJson())),
  };
}

class Doc {
  Doc({
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

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
    id: json["id"] == null ? null : json["id"],
    caseDocument: json["caseDocument"] == null ? null : json["caseDocument"],
    docType: json["docType"] == null ? null : json["docType"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    caseId: json["caseId"] == null ? null : json["caseId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "caseDocument": caseDocument == null ? null : caseDocument,
    "docType": docType == null ? null : docType,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "caseId": caseId == null ? null : caseId,
  };
}

class UsersRef {
  UsersRef({
    this.id,
    this.caseTitle,
    this.caseDescription,
    this.country,
    this.state,
    this.minAmount,
    this.donationReceived,
    this.commentCount,
    this.rankCount,
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
  String caseTitle;
  String caseDescription;
  String country;
  String state;
  dynamic minAmount;
  dynamic donationReceived;
  int commentCount;
  int rankCount;
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
  List<Doc> caseDocument;
  List<RankCase> rankCase;
  List<JoinedUser> joinedUser;
  List<CoreGroup> coreGroup;

  factory UsersRef.fromJson(Map<String, dynamic> json) => UsersRef(
    id: json["id"] == null ? null : json["id"],
    caseTitle: json["caseTitle"] == null ? null : json["caseTitle"],
    caseDescription: json["caseDescription"] == null ? null : json["caseDescription"],
    country: json["country"] == null ? null : json["country"],
    state: json["state"] == null ? null : json["state"],
    minAmount: json["minAmount"],
    donationReceived: json["donationReceived"],
    commentCount: json["commentCount"] == null ? null : json["commentCount"],
    rankCount: json["rankCount"] == null ? null : json["rankCount"],
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
    caseDocument: json["caseDocument"] == null ? null : List<Doc>.from(json["caseDocument"].map((x) => Doc.fromJson(x))),
    rankCase: json["rankCase"] == null ? null : List<RankCase>.from(json["rankCase"].map((x) => RankCase.fromJson(x))),
    joinedUser: json["joinedUser"] == null ? null : List<JoinedUser>.from(json["joinedUser"].map((x) => JoinedUser.fromJson(x))),
    coreGroup: json["coreGroup"] == null ? null : List<CoreGroup>.from(json["coreGroup"].map((x) => CoreGroup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "caseTitle": caseTitle == null ? null : caseTitle,
    "caseDescription": caseDescription == null ? null : caseDescription,
    "minAmount": minAmount,
    "donationReceived": donationReceived,
    "commentCount": commentCount == null ? null : commentCount,
    "rankCount": rankCount == null ? null : rankCount,
    "approvedFlag": approvedFlag == null ? null : approvedFlag,
    "featuredFlag": featuredFlag == null ? null : featuredFlag,
    "caseTypeFlag": caseTypeFlag == null ? null : caseTypeFlag,
    "caseCategory": caseCategory == null ? null : caseCategory,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userId": userId == null ? null : userId,
    "generalId": generalId == null ? null : generalId,
    "users": users == null ? null : users.toJson(),
    "userProfile": userProfile == null ? null : userProfile.toJson(),
    "caseDocument": caseDocument == null ? null : List<dynamic>.from(caseDocument.map((x) => x.toJson())),
    "rankCase": rankCase == null ? null : List<dynamic>.from(rankCase.map((x) => x.toJson())),
    "joinedUser": joinedUser == null ? null : List<dynamic>.from(joinedUser.map((x) => x.toJson())),
    "coreGroup": coreGroup == null ? null : List<dynamic>.from(coreGroup.map((x) => x.toJson())),
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
class CoreGroup {
  CoreGroup({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.caseId,
    this.userId,
    this.generalId,
    this.isAdmin,
  });

  int id;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int caseId;
  int isAdmin;
  int userId;
  int generalId;

  factory CoreGroup.fromJson(Map<String, dynamic> json) => CoreGroup(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    caseId: json["caseId"] == null ? null : json["caseId"],
    userId: json["userId"] == null ? null : json["userId"],
    generalId: json["generalId"] == null ? null : json["generalId"],
    isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "caseId": caseId == null ? null : caseId,
    "userId": userId == null ? null : userId,
    "generalId": generalId == null ? null : generalId,
    "isAdmin": isAdmin == null ? null : isAdmin,
  };
}

class RankCase {
  RankCase({
    this.caseId,
    this.status,
  });

  int caseId;
  int status;

  factory RankCase.fromJson(Map<String, dynamic> json) => RankCase(
    caseId: json["caseId"] == null ? null : json["caseId"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "caseId": caseId == null ? null : caseId,
    "status": status == null ? null : status,
  };
}

class UserProfile {
  UserProfile({
    this.profilePic,
    this.gender,
    this.aliasName,
    this.aliasFlag,
  });

  dynamic profilePic;
  String gender;
  dynamic aliasName;
  int aliasFlag;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    profilePic: json["profilePic"],
    gender: json["gender"] == null ? null : json["gender"],
    aliasName: json["aliasName"],
    aliasFlag: json["aliasFlag"] == null ? null : json["aliasFlag"],
  );

  Map<String, dynamic> toJson() => {
    "profilePic": profilePic,
    "gender": gender == null ? null : gender,
    "aliasName": aliasName,
    "aliasFlag": aliasFlag == null ? null : aliasFlag,
  };
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

  Map<String, dynamic> toJson() => {
    "displayName": displayName == null ? null : displayName,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "emailId": emailId == null ? null : emailId,
  };
}
