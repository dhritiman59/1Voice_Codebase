// To parse this JSON data, do
//
//     final myDonationsListModel = myDonationsListModelFromJson(jsonString);

import 'dart:convert';

MyDonationsListModel myDonationsListModelFromJson(String str) => MyDonationsListModel.fromJson(json.decode(str));

String myDonationsListModelToJson(MyDonationsListModel data) => json.encode(data.toJson());

class MyDonationsListModel {
  MyDonationsListModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory MyDonationsListModel.fromJson(Map<String, dynamic> json) => MyDonationsListModel(
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
    this.amount,
    this.transactionId,
    this.paymentStatus,
    this.donationType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.generalId,
    this.caseId,
    this.users,
    this.userProfile,
    this.userCase,
  });

  int id;
  String amount;
  String transactionId;
  String paymentStatus;
  int donationType;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  int generalId;
  int caseId;
  Users users;
  UserProfile userProfile;
  UserCase userCase;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    amount: json["amount"] == null ? null : json["amount"],
    transactionId: json["transaction_id"] == null ? null : json["transaction_id"],
    paymentStatus: json["paymentStatus"] == null ? null : json["paymentStatus"],
    donationType: json["donationType"] == null ? null : json["donationType"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userId: json["userId"] == null ? null : json["userId"],
    generalId: json["generalId"] == null ? null : json["generalId"],
    caseId: json["caseId"] == null ? null : json["caseId"],
    users: json["users"] == null ? null : Users.fromJson(json["users"]),
    userProfile: json["userProfile"] == null ? null : UserProfile.fromJson(json["userProfile"]),
    userCase: json["userCase"] == null ? null : UserCase.fromJson(json["userCase"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "amount": amount == null ? null : amount,
    "transaction_id": transactionId == null ? null : transactionId,
    "paymentStatus": paymentStatus == null ? null : paymentStatus,
    "donationType": donationType == null ? null : donationType,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userId": userId == null ? null : userId,
    "generalId": generalId == null ? null : generalId,
    "caseId": caseId == null ? null : caseId,
    "users": users == null ? null : users.toJson(),
    "userProfile": userProfile == null ? null : userProfile.toJson(),
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
    this.city,
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
  });

  int id;
  dynamic caseCode;
  String caseTitle;
  String caseDescription;
  dynamic country;
  dynamic city;
  String minAmount;
  String donationReceived;
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

  factory UserCase.fromJson(Map<String, dynamic> json) => UserCase(
    id: json["id"] == null ? null : json["id"],
    caseCode: json["caseCode"],
    caseTitle: json["caseTitle"] == null ? null : json["caseTitle"],
    caseDescription: json["caseDescription"] == null ? null : json["caseDescription"],
    country: json["country"],
    city: json["city"],
    minAmount: json["minAmount"] == null ? null : json["minAmount"],
    donationReceived: json["donationReceived"] == null ? null : json["donationReceived"],
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
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "caseCode": caseCode,
    "caseTitle": caseTitle == null ? null : caseTitle,
    "caseDescription": caseDescription == null ? null : caseDescription,
    "country": country,
    "city": city,
    "minAmount": minAmount == null ? null : minAmount,
    "donationReceived": donationReceived == null ? null : donationReceived,
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
  };
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
  String aliasName;
  String dob;
  String gender;
  dynamic country;
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
    dob: json["dob"] == null ? null : json["dob"],
    gender: json["gender"] == null ? null : json["gender"],
    country: json["country"],
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
    "dob": dob == null ? null : dob,
    "gender": gender == null ? null : gender,
    "country": country,
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
    this.heroPoints,
    this.deviceId,
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
  int heroPoints;
  dynamic deviceId;
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
    heroPoints: json["heroPoints"] == null ? null : json["heroPoints"],
    deviceId: json["device_id"],
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
    "heroPoints": heroPoints == null ? null : heroPoints,
    "device_id": deviceId,
    "status": status == null ? null : status,
    "verificationStatus": verificationStatus == null ? null : verificationStatus,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userTypeId": userTypeId == null ? null : userTypeId,
  };
}
