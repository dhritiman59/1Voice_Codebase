// To parse this JSON data, do
//
//     final followersResponseModel = followersResponseModelFromJson(jsonString);

import 'dart:convert';

FollowersResponseModel followersResponseModelFromJson(String str) => FollowersResponseModel.fromJson(json.decode(str));

String followersResponseModelToJson(FollowersResponseModel data) => json.encode(data.toJson());

class FollowersResponseModel {
  FollowersResponseModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory FollowersResponseModel.fromJson(Map<String, dynamic> json) => FollowersResponseModel(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
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
    this.followingUserId,
    this.userId,
    this.users,
  });

  int id;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int followingUserId;
  int userId;
  Users users;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    followingUserId: json["followingUserId"] == null ? null : json["followingUserId"],
    userId: json["userId"] == null ? null : json["userId"],
    users: json["users"] == null ? null : Users.fromJson(json["users"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "followingUserId": followingUserId == null ? null : followingUserId,
    "userId": userId == null ? null : userId,
    "users": users == null ? null : users.toJson(),
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
    this.status,
    this.verificationStatus,
    this.createdAt,
    this.updatedAt,
    this.userTypeId,
    this.userProfile,
    this.proUsersData,
    this.followUser,
  });

  int id;
  String username;
  String password;
  String emailId;
  String phone;
  String displayName;
  String socialId;
  int loginType;
  String randomKey;
  int reportCount;
  int heroPoints;
  dynamic deviceId;
  int status;
  int verificationStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int userTypeId;
  List<UserProfile> userProfile;
  List<dynamic> proUsersData;
  List<FollowUser> followUser;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"] == null ? null : json["id"],
    username: json["username"] == null ? null : json["username"],
    password: json["password"] == null ? null : json["password"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phone: json["phone"] == null ? null : json["phone"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    socialId: json["socialId"] == null ? null : json["socialId"],
    loginType: json["loginType"] == null ? null : int.parse(json["loginType"].toString()),
    randomKey: json["randomKey"] == null ? null : json["randomKey"],
    reportCount: json["reportCount"] == null ? null : json["reportCount"],
    heroPoints: json["heroPoints"] == null ? null : json["heroPoints"],
    deviceId: json["device_id"],
    status: json["status"] == null ? null : json["status"],
    verificationStatus: json["verificationStatus"] == null ? null : json["verificationStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    userProfile: json["userProfile"] == null ? null : List<UserProfile>.from(json["userProfile"].map((x) => UserProfile.fromJson(x))),
    proUsersData: json["proUsersData"] == null ? null : List<dynamic>.from(json["proUsersData"].map((x) => x)),
    followUser: json["followUser"] == null ? null : List<FollowUser>.from(json["followUser"].map((x) => FollowUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "username": username == null ? null : username,
    "password": password == null ? null : password,
    "emailId": emailId == null ? null : emailId,
    "phone": phone == null ? null : phone,
    "displayName": displayName == null ? null : displayName,
    "socialId": socialId == null ? null : socialId,
    "loginType": loginType == null ? null : loginType,
    "randomKey": randomKey == null ? null : randomKey,
    "reportCount": reportCount == null ? null : reportCount,
    "heroPoints": heroPoints == null ? null : heroPoints,
    "device_id": deviceId,
    "status": status == null ? null : status,
    "verificationStatus": verificationStatus == null ? null : verificationStatus,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userTypeId": userTypeId == null ? null : userTypeId,
    "userProfile": userProfile == null ? null : List<dynamic>.from(userProfile.map((x) => x.toJson())),
    "proUsersData": proUsersData == null ? null : List<dynamic>.from(proUsersData.map((x) => x)),
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
    aboutMe: json["aboutMe"],
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
    "aboutMe": aboutMe,
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
