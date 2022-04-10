// To parse this JSON data, do
//
//     final caseDonationModel = caseDonationModelFromJson(jsonString);

import 'dart:convert';

CaseDonationModel caseDonationModelFromJson(String str) => CaseDonationModel.fromJson(json.decode(str));

String caseDonationModelToJson(CaseDonationModel data) => json.encode(data.toJson());

class CaseDonationModel {
  CaseDonationModel({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory CaseDonationModel.fromJson(Map<String, dynamic> json) => CaseDonationModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
