// To parse this JSON data, do
//
//     final isFollow = isFollowFromJson(jsonString);

import 'dart:convert';

IsFollow isFollowFromJson(String str) => IsFollow.fromJson(json.decode(str));

String isFollowToJson(IsFollow data) => json.encode(data.toJson());

class IsFollow {
  IsFollow({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory IsFollow.fromJson(Map<String, dynamic> json) => IsFollow(
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
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.followingUserId,
    this.userId,
  });

  int id;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int followingUserId;
  int userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    followingUserId: json["followingUserId"] == null ? null : json["followingUserId"],
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "followingUserId": followingUserId == null ? null : followingUserId,
    "userId": userId == null ? null : userId,
  };
}
