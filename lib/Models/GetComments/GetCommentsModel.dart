// // To parse this JSON data, do
// //
// //     final getCommentsModel = getCommentsModelFromJson(jsonString);

// import 'dart:convert';

// GetCommentsModel getCommentsModelFromJson(String str) =>
//     GetCommentsModel.fromJson(json.decode(str));

// String getCommentsModelToJson(GetCommentsModel data) =>
//     json.encode(data.toJson());

// class GetCommentsModel {
//   GetCommentsModel({
//     this.status,
//     this.message,
//     this.data,
//   });

//   String status;
//   String message;
//   Data data;

//   factory GetCommentsModel.fromJson(Map<String, dynamic> json) =>
//       GetCommentsModel(
//         status: json["status"] == null ? null : json["status"],
//         message: json["message"] == null ? null : json["message"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status == null ? null : status,
//         "message": message == null ? null : message,
//         "data": data == null ? null : data.toJson(),
//       };
// }

// class Data {
//   Data({
//     this.totalItems,
//     this.data,
//     this.totalPages,
//     this.currentPage,
//   });

//   int totalItems;
//   List<Datum> data;
//   int totalPages;
//   int currentPage;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         totalItems: json["totalItems"] == null ? null : json["totalItems"],
//         data: json["data"] == null
//             ? null
//             : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         totalPages: json["totalPages"] == null ? null : json["totalPages"],
//         currentPage: json["currentPage"] == null ? null : json["currentPage"],
//       );

//   Map<String, dynamic> toJson() => {
//         "totalItems": totalItems == null ? null : totalItems,
//         "data": data == null
//             ? null
//             : List<dynamic>.from(data.map((x) => x.toJson())),
//         "totalPages": totalPages == null ? null : totalPages,
//         "currentPage": currentPage == null ? null : currentPage,
//       };
// }

// class Datum {
//   Datum({
//     this.isUpVote,
//     this.isDownVote,
//     this.id,
//     this.status,
//     this.comment,
//     this.rankCount,
//     this.createdAt,
//     this.updatedAt,
//     this.caseId,
//     this.userId,
//     this.generalId,
//     this.users,
//     this.userProfile,
//     this.commentFile,
//   });
//   bool isUpVote = false;
//   bool isDownVote = false;
//   int id;
//   int status;
//   String comment;
//   int rankCount;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int caseId;
//   int userId;
//   int generalId;
//   Users users;
//   UserProfile userProfile;
//   List<dynamic> commentFile;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         isUpVote: json["isUpVote"] == null ? false : json["isUpVote"],
//         isDownVote: json["isDownVote"] == null ? false : json["isDownVote"],
//         id: json["id"] == null ? null : json["id"],
//         status: json["status"] == null ? null : json["status"],
//         comment: json["comment"] == null ? null : json["comment"],
//         rankCount: json["rankCount"] == null ? null : json["rankCount"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         caseId: json["caseId"] == null ? null : json["caseId"],
//         userId: json["userId"] == null ? null : json["userId"],
//         generalId: json["generalId"] == null ? null : json["generalId"],
//         users: json["users"] == null ? null : Users.fromJson(json["users"]),
//         userProfile: json["userProfile"] == null
//             ? null
//             : UserProfile.fromJson(json["userProfile"]),
//         commentFile: json["commentFile"] == null
//             ? null
//             : List<dynamic>.from(json["commentFile"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "isUpVote": isUpVote == null ? false : isUpVote,
//         "isDownVote": isDownVote == null ? false : isDownVote,
//         "id": id == null ? null : id,
//         "status": status == null ? null : status,
//         "comment": comment == null ? null : comment,
//         "rankCount": rankCount == null ? null : rankCount,
//         "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
//         "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
//         "caseId": caseId == null ? null : caseId,
//         "userId": userId == null ? null : userId,
//         "generalId": generalId == null ? null : generalId,
//         "users": users == null ? null : users.toJson(),
//         "userProfile": userProfile == null ? null : userProfile.toJson(),
//         "commentFile": commentFile == null
//             ? null
//             : List<dynamic>.from(commentFile.map((x) => x)),
//       };
// }

// class UserProfile {
//   UserProfile({
//     this.profilePic,
//   });

//   dynamic profilePic;

//   factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
//         profilePic: json["profilePic"],
//       );

//   Map<String, dynamic> toJson() => {
//         "profilePic": profilePic,
//       };
// }

// class Users {
//   Users({
//     this.id,
//     this.displayName,
//     this.userTypeId,
//     this.emailId,
//   });

//   int id;
//   String displayName;
//   int userTypeId;
//   String emailId;

//   factory Users.fromJson(Map<String, dynamic> json) => Users(
//         id: json["id"] == null ? null : json["id"],
//         displayName: json["displayName"] == null ? null : json["displayName"],
//         userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
//         emailId: json["emailId"] == null ? null : json["emailId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "displayName": displayName == null ? null : displayName,
//         "userTypeId": userTypeId == null ? null : userTypeId,
//         "emailId": emailId == null ? null : emailId,
//       };
// }

// class CommentFile {
//   CommentFile({
//     this.commentFile,
//     this.docType,
//     this.status,
//   });

//   String commentFile;
//   DocType docType;
//   int status;

//   factory CommentFile.fromJson(Map<String, dynamic> json) => CommentFile(
//         commentFile: json["commentFile"] == null ? null : json["commentFile"],
//         docType:
//             json["docType"] == null ? null : docTypeValues.map[json["docType"]],
//         status: json["status"] == null ? null : json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "commentFile": commentFile == null ? null : commentFile,
//         "docType": docType == null ? null : docTypeValues.reverse[docType],
//         "status": status == null ? null : status,
//       };
// }

// enum DocType { IMAGE_JPEG, APPLICATION_MSWORD }

// final docTypeValues = EnumValues({
//   "application/msword": DocType.APPLICATION_MSWORD,
//   "image/jpeg": DocType.IMAGE_JPEG
// });

// To parse this JSON data, do
//
//     final getCommentsModel = getCommentsModelFromJson(jsonString);

import 'dart:convert';

GetCommentsModel getCommentsModelFromJson(String str) =>
    GetCommentsModel.fromJson(json.decode(str));

String getCommentsModelToJson(GetCommentsModel data) =>
    json.encode(data.toJson());

class GetCommentsModel {
  GetCommentsModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory GetCommentsModel.fromJson(Map<String, dynamic> json) =>
      GetCommentsModel(
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
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        totalPages: json["totalPages"] == null ? null : json["totalPages"],
        currentPage: json["currentPage"] == null ? null : json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalItems": totalItems == null ? null : totalItems,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "totalPages": totalPages == null ? null : totalPages,
        "currentPage": currentPage == null ? null : currentPage,
      };
}

class Datum {
  Datum({
    this.id,
    this.status,
    this.comment,
    this.rankCount,
    this.createdAt,
    this.updatedAt,
    this.isUpVote,
    this.isDownVote,
    this.caseId,
    this.userId,
    this.generalId,
    this.users,
    this.userProfile,
    this.commentFile,
    this.rankComment,
  });

  int id;
  int status;
  String comment;
  int rankCount;
  DateTime createdAt;
  DateTime updatedAt;
  int caseId;
  int userId;
  int generalId;
  Users users;
  UserProfile userProfile;
  List<CommentFile> commentFile;
  List<RankComment> rankComment;
  bool isUpVote = false;
  bool isDownVote = false;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        isUpVote: json["isUpVote"] == null ? false : json["isUpVote"],
        isDownVote: json["isDownVote"] == null ? false : json["isDownVote"],
        id: json["id"] == null ? null : json["id"],
        status: json["status"] == null ? null : json["status"],
        comment: json["comment"] == null ? null : json["comment"],
        rankCount: json["rankCount"] == null ? null : json["rankCount"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        caseId: json["caseId"] == null ? null : json["caseId"],
        userId: json["userId"] == null ? null : json["userId"],
        generalId: json["generalId"] == null ? null : json["generalId"],
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
        userProfile: json["userProfile"] == null
            ? null
            : UserProfile.fromJson(json["userProfile"]),
        commentFile: json["commentFile"] == null
            ? null
            : List<CommentFile>.from(
                json["commentFile"].map((x) => CommentFile.fromJson(x))),
        rankComment: json["rankComment"] == null
            ? null
            : List<RankComment>.from(
                json["rankComment"].map((x) => RankComment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isUpVote": isUpVote == null ? false : isUpVote,
        "isDownVote": isDownVote == null ? false : isDownVote,
        "id": id == null ? null : id,
        "status": status == null ? null : status,
        "comment": comment == null ? null : commentValues.reverse[comment],
        "rankCount": rankCount == null ? null : rankCount,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "caseId": caseId == null ? null : caseId,
        "userId": userId == null ? null : userId,
        "generalId": generalId == null ? null : generalId,
        "users": users == null ? null : users.toJson(),
        "userProfile": userProfile == null ? null : userProfile.toJson(),
        "commentFile": commentFile == null
            ? null
            : List<dynamic>.from(commentFile.map((x) => x.toJson())),
        "rankComment": rankComment == null
            ? null
            : List<dynamic>.from(rankComment.map((x) => x.toJson())),
      };
}

enum Comment { USE_FUL, H, SFH }

final commentValues =
    EnumValues({"h": Comment.H, "sfh": Comment.SFH, "UseFul": Comment.USE_FUL});

class CommentFile {
  CommentFile({
    this.commentFile,
    this.docType,
    this.status,
  });

  String commentFile;
  DocType docType;
  int status;

  factory CommentFile.fromJson(Map<String, dynamic> json) => CommentFile(
        commentFile: json["commentFile"] == null ? null : json["commentFile"],
        docType:
            json["docType"] == null ? null : docTypeValues.map[json["docType"]],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "commentFile": commentFile == null ? null : commentFile,
        "docType": docType == null ? null : docTypeValues.reverse[docType],
        "status": status == null ? null : status,
      };
}

enum DocType { IMAGE_JPEG, APPLICATION_MSWORD }

final docTypeValues = EnumValues({
  "application/msword": DocType.APPLICATION_MSWORD,
  "image/jpeg": DocType.IMAGE_JPEG
});

class RankComment {
  RankComment({
    this.status,
    this.id,
    this.commentId,
  });

  int status;
  int id;
  int commentId;

  factory RankComment.fromJson(Map<String, dynamic> json) => RankComment(
        status: json["status"] == null ? null : json["status"],
        id: json["id"] == null ? null : json["id"],
        commentId: json["commentId"] == null ? null : json["commentId"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "id": id == null ? null : id,
        "commentId": commentId == null ? null : commentId,
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

class Users {
  Users({
    this.id,
    this.displayName,
    this.userTypeId,
    this.emailId,
  });

  int id;
  String displayName;
  int userTypeId;
  String emailId;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"] == null ? null : json["id"],
        displayName: json["displayName"] == null ? null : json["displayName"],
        userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
        emailId: json["emailId"] == null ? null : json["emailId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "displayName":
            displayName == null ? null : displayNameValues.reverse[displayName],
        "userTypeId": userTypeId == null ? null : userTypeId,
        "emailId": emailId == null ? null : emailIdValues.reverse[emailId],
      };
}

enum DisplayName { BACKEND_VYSHNA, MARIYA }

final displayNameValues = EnumValues({
  "backend vyshna": DisplayName.BACKEND_VYSHNA,
  "Mariya": DisplayName.MARIYA
});

enum EmailId { VYSHNA123_TECHWARE_GMAIL_COM, MKMINNU29071996_GMAIL_COM }

final emailIdValues = EnumValues({
  "mkminnu29071996@gmail.com": EmailId.MKMINNU29071996_GMAIL_COM,
  "vyshna123.techware@gmail.com": EmailId.VYSHNA123_TECHWARE_GMAIL_COM
});

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
