// To parse this JSON data, do
//
//     final generalDonationModel = generalDonationModelFromJson(jsonString);

import 'dart:convert';

GeneralDonationModel generalDonationModelFromJson(String str) => GeneralDonationModel.fromJson(json.decode(str));

String generalDonationModelToJson(GeneralDonationModel data) => json.encode(data.toJson());

class GeneralDonationModel {
  GeneralDonationModel({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory GeneralDonationModel.fromJson(Map<String, dynamic> json) => GeneralDonationModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
