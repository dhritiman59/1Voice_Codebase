// To parse this JSON data, do
//
//     final getUserDetailsModel = getUserDetailsModelFromJson(jsonString);

import 'dart:convert';

GetUserDetailsModel getUserDetailsModelFromJson(String str) => GetUserDetailsModel.fromJson(json.decode(str));

String getUserDetailsModelToJson(GetUserDetailsModel data) => json.encode(data.toJson());

class GetUserDetailsModel {
  GetUserDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory GetUserDetailsModel.fromJson(Map<String, dynamic> json) => GetUserDetailsModel(
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
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.password,
    this.emailId,
    this.countryCode,
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
    this.joinedUser,
    this.caseDonations,
    this.joinedCaseCount,
    this.totalDontions,
  });

  int id;
  String username;
  dynamic firstName;
  dynamic lastName;
  String password;
  String emailId;
  dynamic countryCode;
  String phone;
  String displayName;
  dynamic socialId;
  int loginType;
  String randomKey;
  int reportCount;
  int heroPoints;
  String deviceId;
  String stripeId;
  int status;
  int verificationStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int userTypeId;
  List<UserProfile> userProfile;
  List<ProUsersDatum> proUsersData;
  List<JoinedUser> joinedUser;
  List<CaseDonation> caseDonations;
  int joinedCaseCount;
  int totalDontions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    username: json["username"] == null ? null : json["username"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    password: json["password"] == null ? null : json["password"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    countryCode: json["countryCode"],
    phone: json["phone"] == null ? null : json["phone"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    socialId: json["socialId"],
    loginType: json["loginType"] == null ? null : int.parse(json["loginType"].toString()),
    randomKey: json["randomKey"] == null ? null : json["randomKey"],
    reportCount: json["reportCount"] == null ? null : json["reportCount"],
    heroPoints: json["heroPoints"] == null ? null : json["heroPoints"],
    deviceId: json["device_id"] == null ? null : json["device_id"],
    stripeId: json["stripe_id"] == null ? null : json["stripe_id"],
    status: json["status"] == null ? null : json["status"],
    verificationStatus: json["verificationStatus"] == null ? null : json["verificationStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    userProfile: json["userProfile"] == null ? null : List<UserProfile>.from(json["userProfile"].map((x) => UserProfile.fromJson(x))),
    proUsersData: json["proUsersData"] == null ? null : List<ProUsersDatum>.from(json["proUsersData"].map((x) => ProUsersDatum.fromJson(x))),
    joinedUser: json["joinedUser"] == null ? null : List<JoinedUser>.from(json["joinedUser"].map((x) => JoinedUser.fromJson(x))),
    caseDonations: json["caseDonations"] == null ? null : List<CaseDonation>.from(json["caseDonations"].map((x) => CaseDonation.fromJson(x))),
    joinedCaseCount: json["joinedCaseCount"] == null ? null : json["joinedCaseCount"],
    totalDontions: json["totalDontions"] == null ? null : json["totalDontions"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "username": username == null ? null : username,
    "firstName": firstName,
    "lastName": lastName,
    "password": password == null ? null : password,
    "emailId": emailId == null ? null : emailId,
    "countryCode": countryCode,
    "phone": phone == null ? null : phone,
    "displayName": displayName == null ? null : displayName,
    "socialId": socialId,
    "loginType": loginType == null ? null : loginType,
    "randomKey": randomKey == null ? null : randomKey,
    "reportCount": reportCount == null ? null : reportCount,
    "heroPoints": heroPoints == null ? null : heroPoints,
    "device_id": deviceId == null ? null : deviceId,
    "stripe_id": stripeId == null ? null : stripeId,
    "status": status == null ? null : status,
    "verificationStatus": verificationStatus == null ? null : verificationStatus,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userTypeId": userTypeId == null ? null : userTypeId,
    "userProfile": userProfile == null ? null : List<dynamic>.from(userProfile.map((x) => x.toJson())),
    "proUsersData": proUsersData == null ? null : List<dynamic>.from(proUsersData.map((x) => x.toJson())),
    "joinedUser": joinedUser == null ? null : List<dynamic>.from(joinedUser.map((x) => x.toJson())),
    "caseDonations": caseDonations == null ? null : List<dynamic>.from(caseDonations.map((x) => x.toJson())),
    "joinedCaseCount": joinedCaseCount == null ? null : joinedCaseCount,
    "totalDontions": totalDontions == null ? null : totalDontions,
  };
}

class CaseDonation {
  CaseDonation({
    this.id,
    this.amount,
    this.commission,
    this.transactionId,
    this.paymentStatus,
    this.donationType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.generalId,
    this.caseId,
  });

  int id;
  String amount;
  String commission;
  String transactionId;
  String paymentStatus;
  int donationType;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  int generalId;
  int caseId;

  factory CaseDonation.fromJson(Map<String, dynamic> json) => CaseDonation(
    id: json["id"] == null ? null : json["id"],
    amount: json["amount"] == null ? null : json["amount"],
    commission: json["commission"] == null ? null : json["commission"],
    transactionId: json["transaction_id"] == null ? null : json["transaction_id"],
    paymentStatus: json["paymentStatus"] == null ? null : json["paymentStatus"],
    donationType: json["donationType"] == null ? null : json["donationType"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userId: json["userId"] == null ? null : json["userId"],
    generalId: json["generalId"] == null ? null : json["generalId"],
    caseId: json["caseId"] == null ? null : json["caseId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "amount": amount == null ? null : amount,
    "commission": commission == null ? null : commission,
    "transaction_id": transactionId == null ? null : transactionId,
    "paymentStatus": paymentStatus == null ? null : paymentStatus,
    "donationType": donationType == null ? null : donationType,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userId": userId == null ? null : userId,
    "generalId": generalId == null ? null : generalId,
    "caseId": caseId == null ? null : caseId,
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
    this.state,
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
  String dob;
  String gender;
  dynamic country;
  dynamic state;
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
    aboutMe: json["aboutMe"] == null ? null : json["aboutMe"],
    dob: json["dob"] == null ? null : json["dob"],
    gender: json["gender"] == null ? null : json["gender"],
    country: json["country"],
    state: json["state"],
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
    "aboutMe": aboutMe == null ? null : aboutMe,
    "dob": dob == null ? null : dob,
    "gender": gender == null ? null : gender,
    "country": country,
    "state": state,
    "profilePic": profilePic == null ? null : profilePic,
    "aliasFlag": aliasFlag == null ? null : aliasFlag,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "userId": userId == null ? null : userId,
  };
}
