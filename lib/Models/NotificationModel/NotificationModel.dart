// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
    this.heading,
    this.message,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.requestedUserId,
    this.userId,
    this.caseId,
    this.users,
    this.userCase,
  });

  int id;
  String heading;
  String message;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int requestedUserId;
  int userId;
  int caseId;
  Users users;
  UserCase userCase;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    heading: json["heading"] == null ? null : json["heading"],
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    requestedUserId: json["requestedUserId"] == null ? null : json["requestedUserId"],
    userId: json["userId"] == null ? null : json["userId"],
    caseId: json["caseId"] == null ? null : json["caseId"],
    users: json["users"] == null ? null : Users.fromJson(json["users"]),
    userCase: json["userCase"] == null ? null : UserCase.fromJson(json["userCase"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "heading": heading == null ? null : heading,
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "requestedUserId": requestedUserId == null ? null : requestedUserId,
    "userId": userId == null ? null : userId,
    "caseId": caseId == null ? null : caseId,
    "users": users == null ? null : users.toJson(),
    "userCase": userCase == null ? null : userCase.toJson(),
  };
}

class UserCase {
  UserCase({
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
    this.caseDocument,
  });

  int id;
  dynamic caseCode;
  String caseTitle;
  String caseDescription;
  dynamic country;
  dynamic state;
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
  List<CaseDocument> caseDocument;

  factory UserCase.fromJson(Map<String, dynamic> json) => UserCase(
    id: json["id"] == null ? null : json["id"],
    caseCode: json["caseCode"],
    caseTitle: json["caseTitle"] == null ? null : json["caseTitle"],
    caseDescription: json["caseDescription"] == null ? null : json["caseDescription"],
    country: json["country"],
    state: json["state"],
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
    caseDocument: json["caseDocument"] == null ? null : List<CaseDocument>.from(json["caseDocument"].map((x) => CaseDocument.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "caseCode": caseCode,
    "caseTitle": caseTitle == null ? null : caseTitle,
    "caseDescription": caseDescription == null ? null : caseDescription,
    "country": country,
    "state": state,
    "minAmount": minAmount == null ? null : minAmount,
    "donationReceived": donationReceived == null ? null : donationReceived,
    "commentCount": commentCount == null ? null : commentCount,
    "rankCount": rankCount == null ? null : rankCount,
    "reportCount": reportCount == null ? null : reportCount,
    "approvedFlag": approvedFlag == null ? null : approvedFlag,
    "featuredFlag": featuredFlag == null ? null : featuredFlag,
    "caseTypeFlag": caseTypeFlag == null ? null : caseTypeFlag,
    "caseCategory": caseCategory == null ? null : caseCategory,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userId": userId == null ? null : userId,
    "generalId": generalId == null ? null : generalId,
    "caseDocument": caseDocument == null ? null : List<dynamic>.from(caseDocument.map((x) => x.toJson())),
  };
}

class CaseDocument {
  CaseDocument({
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

  factory CaseDocument.fromJson(Map<String, dynamic> json) => CaseDocument(
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

class Users {
  Users({
    this.displayName,
    this.userTypeId,
    this.emailId,
    this.followUser,
  });

  String displayName;
  int userTypeId;
  String emailId;
  List<FollowUser> followUser;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    displayName: json["displayName"] == null ? null : json["displayName"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    followUser: json["followUser"] == null ? null : List<FollowUser>.from(json["followUser"].map((x) => FollowUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "displayName": displayName == null ? null : displayName,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "emailId": emailId == null ? null : emailId,
    "followUser": followUser == null ? null : List<dynamic>.from(followUser.map((x) => x.toJson())),
  };
}
class FollowUser {
  FollowUser({
    this.status,
    this.userId,
    this.followingUserId,
  });

  int status;
  int userId;
  int followingUserId;

  factory FollowUser.fromJson(Map<String, dynamic> json) => FollowUser(
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
    followingUserId: json["followingUserId"] == null ? null : json["followingUserId"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
    "followingUserId": followingUserId == null ? null : followingUserId,
  };
}