

import 'dart:convert';

BecomProUserModel becomProUserModelFromJson(String str) => BecomProUserModel.fromJson(json.decode(str));

String becomProUserModelToJson(BecomProUserModel data) => json.encode(data.toJson());

class BecomProUserModel {
  BecomProUserModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory BecomProUserModel.fromJson(Map<String, dynamic> json) => BecomProUserModel(
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
    this.verifiedUser,
    this.status,
    this.id,
    this.specialization,
    this.userId,
    this.docImage,
    this.city,
    this.regno,
    this.experience,
    this.identity,
    this.updatedAt,
    this.createdAt,
  });

  int verifiedUser;
  int status;
  int id;
  String specialization;
  int userId;
  String docImage;
  String city;
  String regno;
  String experience;
  String identity;
  DateTime updatedAt;
  DateTime createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    verifiedUser: json["verifiedUser"] == null ? null : json["verifiedUser"],
    status: json["status"] == null ? null : json["status"],
    id: json["id"] == null ? null : json["id"],
    specialization: json["specialization"] == null ? null : json["specialization"],
    userId: json["userId"] == null ? null : json["userId"],
    docImage: json["docImage"] == null ? null : json["docImage"],
    city: json["city"] == null ? null : json["city"],
    regno: json["regno"] == null ? null : json["regno"],
    experience: json["experience"] == null ? null : json["experience"],
    identity: json["identity"] == null ? null : json["identity"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "verifiedUser": verifiedUser == null ? null : verifiedUser,
    "status": status == null ? null : status,
    "id": id == null ? null : id,
    "specialization": specialization == null ? null : specialization,
    "userId": userId == null ? null : userId,
    "docImage": docImage == null ? null : docImage,
    "city": city == null ? null : city,
    "regno": regno == null ? null : regno,
    "experience": experience == null ? null : experience,
    "identity": identity == null ? null : identity,
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
  };
}
