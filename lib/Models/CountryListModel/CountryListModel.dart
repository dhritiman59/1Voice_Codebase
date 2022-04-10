// To parse this JSON data, do
//
//     final countryListModel = countryListModelFromJson(jsonString);

import 'dart:convert';


class CountryListModel {
  CountryListModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory CountryListModel.fromJson(Map<String, dynamic> json) => CountryListModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

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

}

class Datum {
  Datum({
    this.id,
    this.sortname,
    this.name,
    this.phonecode,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String sortname;
  String name;
  String phonecode;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    sortname: json["sortname"] == null ? null : json["sortname"],
    name: json["name"] == null ? null : json["name"],
    phonecode: json["phonecode"] == null ? null : json["phonecode"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

}
