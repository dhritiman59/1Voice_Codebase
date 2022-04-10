// To parse this JSON data, do
//
//     final platFormTermsModel = platFormTermsModelFromJson(jsonString);

import 'dart:convert';

PlatFormTermsModel platFormTermsModelFromJson(String str) => PlatFormTermsModel.fromJson(json.decode(str));

String platFormTermsModelToJson(PlatFormTermsModel data) => json.encode(data.toJson());

class PlatFormTermsModel {
  PlatFormTermsModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory PlatFormTermsModel.fromJson(Map<String, dynamic> json) => PlatFormTermsModel(
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
    this.terms,
    this.privacy,
  });

  String terms;
  String privacy;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    terms: json["terms"] == null ? null : json["terms"],
    privacy: json["privacy"] == null ? null : json["privacy"],
  );

  Map<String, dynamic> toJson() => {
    "terms": terms == null ? null : terms,
    "privacy": privacy == null ? null : privacy,
  };
}
