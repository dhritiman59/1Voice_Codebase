// To parse this JSON data, do
//
//     final categoryCausesModel = categoryCausesModelFromJson(jsonString);

import 'dart:convert';

CategoryCausesModel categoryCausesModelFromJson(String str) => CategoryCausesModel.fromJson(json.decode(str));

String categoryCausesModelToJson(CategoryCausesModel data) => json.encode(data.toJson());

class CategoryCausesModel {
  CategoryCausesModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory CategoryCausesModel.fromJson(Map<String, dynamic> json) => CategoryCausesModel(
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
    this.causeName,
    this.causesIcon,
    this.causesImage,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String causeName;
  String causesIcon;
  String causesImage;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    causeName: json["causeName"] == null ? null : json["causeName"],
    causesIcon: json["causesIcon"] == null ? null : json["causesIcon"],
    causesImage: json["causesImage"] == null ? null : json["causesImage"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "causeName": causeName == null ? null : causeName,
    "causesIcon": causesIcon == null ? null : causesIcon,
    "causesImage": causesImage == null ? null : causesImage,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
