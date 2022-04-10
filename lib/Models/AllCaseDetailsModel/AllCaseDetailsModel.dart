// To parse this JSON data, do
//
//     final allCaseDetailsModel = allCaseDetailsModelFromJson(jsonString);

import 'dart:convert';

AllCaseDetailsModel allCaseDetailsModelFromJson(String str) => AllCaseDetailsModel.fromJson(json.decode(str));

String allCaseDetailsModelToJson(AllCaseDetailsModel data) => json.encode(data.toJson());

class AllCaseDetailsModel {
  AllCaseDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory AllCaseDetailsModel.fromJson(Map<String, dynamic> json) => AllCaseDetailsModel(
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
    this.isUpVote,
    this.isDownVote,
    this.userId,
    this.generalId,
    this.users,
    this.userProfile,
    this.rankCase,
    this.joinedUser,
    this.caseDocument,
    this.bannerImage,
    this.caseNetworkImage,
    this.caseVideoImage
  });
  String caseNetworkImage = '';
  String caseVideoImage = '';
  String bannerImage = 'assets/images/casedetailsHuman.png';
  bool isUpVote = false;
  bool isDownVote = false;
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
  List<RankCase> rankCase;
  List<JoinedUser> joinedUser;
  List<CaseDocument> caseDocument;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    caseVideoImage: json["caseVideoImage"] == null ? "" : json["caseVideoImage"],
    caseNetworkImage: json["caseNetworkImage"] == null ? "" : json["caseNetworkImage"],
    bannerImage: json["bannerImage"] == null ? "" : json["bannerImage"],
    isUpVote: json["isUpVote"] == null ? false : json["isUpVote"],
    isDownVote: json["isDownVote"] == null ? false : json["isDownVote"],
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
    rankCase: json["rankCase"] == null ? null : List<RankCase>.from(json["rankCase"].map((x) => RankCase.fromJson(x))),
    joinedUser: json["joinedUser"] == null ? null : List<JoinedUser>.from(json["joinedUser"].map((x) => JoinedUser.fromJson(x))),
    caseDocument: json["caseDocument"] == null ? null : List<CaseDocument>.from(json["caseDocument"].map((x) => CaseDocument.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isUpVote": isUpVote == null ? false : isUpVote,
    "isDownVote": isDownVote == null ? false : isDownVote,
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
    "caseCategory": caseCategory   == null ? null : caseCategory,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userId": userId == null ? null : userId,
    "generalId": generalId == null ? null : generalId,
    "users": users == null ? null : users.toJson(),
    "userProfile": userProfile == null ? null : userProfile.toJson(),
    "rankCase": rankCase == null ? null : List<dynamic>.from(rankCase.map((x) => x.toJson())),
    "joinedUser": joinedUser == null ? null : List<dynamic>.from(joinedUser.map((x) => x.toJson())),
  };
}

enum CaseCategory { HUMAN_TRAFFIC }

final caseCategoryValues = EnumValues({
  "Human Traffic": CaseCategory.HUMAN_TRAFFIC
});

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

enum Gender { FEMALE, MALE }

final genderValues = EnumValues({
  "female": Gender.FEMALE,
  "Male": Gender.MALE
});

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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}



class CaseDocument {
  CaseDocument({
    this.caseDocument,
    this.docType,
  });

  String caseDocument;
  String docType;

  factory CaseDocument.fromJson(Map<String, dynamic> json) => CaseDocument(
    caseDocument: json["caseDocument"] == null ? null : json["caseDocument"],
    docType: json["docType"] == null ? null : json["docType"],
  );

  Map<String, dynamic> toJson() => {
    "caseDocument": caseDocument == null ? null : caseDocument,
    "docType": docType == null ? null : docType,
  };
}
