// To parse this JSON data, do
//
//     final joinedCasesModel = joinedCasesModelFromJson(jsonString);

import 'dart:convert';

JoinedCasesModel joinedCasesModelFromJson(String str) => JoinedCasesModel.fromJson(json.decode(str));

String joinedCasesModelToJson(JoinedCasesModel data) => json.encode(data.toJson());

class JoinedCasesModel {
  JoinedCasesModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory JoinedCasesModel.fromJson(Map<String, dynamic> json) => JoinedCasesModel(
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
    this.status,
    this.createdAt,
    this.updatedAt,
    this.caseId,
    this.userId,
    this.generalId,
    this.userCase,
    this.isUpVote,
    this.isDownVote,
  });

  int id;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int caseId;
  int userId;
  int generalId;
  bool isUpVote = false;
  bool isDownVote = false;
  UserCase userCase;


  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    isUpVote: json["isUpVote"] == null ? false : json["isUpVote"],
    isDownVote: json["isDownVote"] == null ? false : json["isDownVote"],
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    caseId: json["caseId"] == null ? null : json["caseId"],
    userId: json["userId"] == null ? null : json["userId"],
    generalId: json["generalId"] == null ? null : json["generalId"],
    userCase: json["userCase"] == null ? null : UserCase.fromJson(json["userCase"]),
  );

  Map<String, dynamic> toJson() => {
    "isUpVote": isUpVote == null ? false : isUpVote,
    "isDownVote": isDownVote == null ? false : isDownVote,
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "caseId": caseId == null ? null : caseId,
    "userId": userId == null ? null : userId,
    "generalId": generalId == null ? null : generalId,
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
    this.rankCase,
    this.users,
    this.userProfile,
    this.caseDocument,
    this.bannerImage,
    this.caseVideoImage,
    this.caseNetworkImage
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
  List<RankCase> rankCase;
  Users users;
  UserProfile userProfile;
  List<CaseDocument> caseDocument;
  String caseNetworkImage = '';
  String caseVideoImage = '';
  String bannerImage = 'assets/images/casedetailsHuman.png';

  factory UserCase.fromJson(Map<String, dynamic> json) => UserCase(
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
    rankCase: json["rankCase"] == null ? null : List<RankCase>.from(json["rankCase"].map((x) => RankCase.fromJson(x))),
    users: json["users"] == null ? null : Users.fromJson(json["users"]),
    userProfile: json["userProfile"] == null ? null : UserProfile.fromJson(json["userProfile"]),
    caseDocument: json["caseDocument"] == null ? null : List<CaseDocument>.from(json["caseDocument"].map((x) => CaseDocument.fromJson(x))),
    caseNetworkImage: json["caseNetworkImage"] == null ? "" : json["caseNetworkImage"],
    bannerImage: json["bannerImage"] == null ? "" : json["bannerImage"],
    caseVideoImage: json["caseVideoImage"] == null ? "" : json["caseVideoImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "caseCode": caseCode == null ? null : caseCode,
    "caseTitle": caseTitle == null ? null : caseTitle,
    "caseDescription": caseDescription == null ? null : caseDescription,
    "country": country == null ? null : country,
    "state": state == null ? null : state,
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
    "rankCase": rankCase == null ? null : List<dynamic>.from(rankCase.map((x) => x.toJson())),
    "users": users == null ? null : users.toJson(),
    "userProfile": userProfile == null ? null : userProfile.toJson(),
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
    this.id,
    this.displayName,
    this.aliasName,
    this.aboutMe,
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
  String aliasName;
  dynamic aboutMe;
  String dob;
  String gender;
  String country;
  String profilePic;
  int aliasFlag;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["id"] == null ? null : json["id"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    aliasName: json["aliasName"] == null ? null : json["aliasName"],
    aboutMe: json["aboutMe"],
    dob: json["dob"] == null ? null : json["dob"],
    gender: json["gender"] == null ? null : json["gender"],
    country: json["country"] == null ? null : json["country"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    aliasFlag: json["aliasFlag"] == null ? null : json["aliasFlag"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "displayName": displayName == null ? null : displayName,
    "aliasName": aliasName == null ? null : aliasName,
    "aboutMe": aboutMe,
    "dob": dob == null ? null : dob,
    "gender": gender == null ? null : gender,
    "country": country == null ? null : country,
    "profilePic": profilePic == null ? null : profilePic,
    "aliasFlag": aliasFlag == null ? null : aliasFlag,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userId": userId == null ? null : userId,
  };
}

class Users {
  Users({
    this.id,
    this.username,
    this.password,
    this.emailId,
    this.phone,
    this.displayName,
    this.socialId,
    this.loginType,
    this.randomKey,
    this.reportCount,
    this.heroPoints,
    this.deviceId,
    this.stripeId,
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
  int reportCount;
  int heroPoints;
  dynamic deviceId;
  dynamic stripeId;
  int status;
  int verificationStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int userTypeId;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"] == null ? null : json["id"],
    username: json["username"] == null ? null : json["username"],
    password: json["password"] == null ? null : json["password"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phone: json["phone"] == null ? null : json["phone"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    socialId: json["socialId"],
    loginType: json["loginType"] == null ? null : int.parse(json["loginType"].toString()),
    randomKey: json["randomKey"] == null ? null : json["randomKey"],
    reportCount: json["reportCount"] == null ? null : json["reportCount"],
    heroPoints: json["heroPoints"] == null ? null : json["heroPoints"],
    deviceId: json["device_id"],
    stripeId: json["stripe_id"],
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
    "reportCount": reportCount == null ? null : reportCount,
    "heroPoints": heroPoints == null ? null : heroPoints,
    "device_id": deviceId,
    "stripe_id": stripeId,
    "status": status == null ? null : status,
    "verificationStatus": verificationStatus == null ? null : verificationStatus,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userTypeId": userTypeId == null ? null : userTypeId,
  };
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
