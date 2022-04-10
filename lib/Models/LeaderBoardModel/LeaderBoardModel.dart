// To parse this JSON data, do
//
//     final leaderModel = leaderModelFromJson(jsonString);

import 'dart:convert';

LeaderModel leaderModelFromJson(String str) => LeaderModel.fromJson(json.decode(str));

String leaderModelToJson(LeaderModel data) => json.encode(data.toJson());

class LeaderModel {
  LeaderModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory LeaderModel.fromJson(Map<String, dynamic> json) => LeaderModel(
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
  int reportCount;
  int heroPoints;
  dynamic deviceId;
  dynamic stripeId;
  int status;
  int verificationStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int userTypeId;
  List<UserProfile> userProfile;
  List<ProUsersDatum> proUsersData;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    userProfile: json["userProfile"] == null ? null : List<UserProfile>.from(json["userProfile"].map((x) => UserProfile.fromJson(x))),
    proUsersData: json["proUsersData"] == null ? null : List<ProUsersDatum>.from(json["proUsersData"].map((x) => ProUsersDatum.fromJson(x))),
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
    "userProfile": userProfile == null ? null : List<dynamic>.from(userProfile.map((x) => x.toJson())),
    "proUsersData": proUsersData == null ? null : List<dynamic>.from(proUsersData.map((x) => x.toJson())),
  };
}

class ProUsersDatum {
  ProUsersDatum({
    this.id,
    this.regno,
    this.experience,
    this.identity,
    this.aboutMe,
    this.city,
    this.docImage,
    this.verifiedUser,
    this.specialization,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  int id;
  String regno;
  String experience;
  String identity;
  String aboutMe;
  String city;
  String docImage;
  int verifiedUser;
  String specialization;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;

  factory ProUsersDatum.fromJson(Map<String, dynamic> json) => ProUsersDatum(
    id: json["id"] == null ? null : json["id"],
    regno: json["regno"] == null ? null : json["regno"],
    experience: json["experience"] == null ? null : json["experience"],
    identity: json["identity"] == null ? null : json["identity"],
    aboutMe: json["aboutMe"] == null ? null : json["aboutMe"],
    city: json["city"] == null ? null : json["city"],
    docImage: json["docImage"] == null ? null : json["docImage"],
    verifiedUser: json["verifiedUser"] == null ? null : json["verifiedUser"],
    specialization: json["specialization"] == null ? null : json["specialization"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "regno": regno == null ? null : regno,
    "experience": experience == null ? null : experience,
    "identity": identity == null ? null : identity,
    "aboutMe": aboutMe == null ? null : aboutMe,
    "city": city == null ? null : city,
    "docImage": docImage == null ? null : docImage,
    "verifiedUser": verifiedUser == null ? null : verifiedUser,
    "specialization": specialization == null ? null : specialization,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userId": userId == null ? null : userId,
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
  String aboutMe;
  dynamic dob;
  String gender;
  String country;
  dynamic profilePic;
  int aliasFlag;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["id"] == null ? null : json["id"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    aliasName: json["aliasName"] == null ? null : json["aliasName"],
    aboutMe: json["aboutMe"] == null ? null : json["aboutMe"],
    dob: json["dob"],
    gender: json["gender"] == null ? null : json["gender"],
    country: json["country"] == null ? null : json["country"],
    profilePic: json["profilePic"],
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
    "aboutMe": aboutMe == null ? null : aboutMe,
    "dob": dob,
    "gender": gender == null ? null : gender,
    "country": country == null ? null : country,
    "profilePic": profilePic,
    "aliasFlag": aliasFlag == null ? null : aliasFlag,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userId": userId == null ? null : userId,
  };
}
