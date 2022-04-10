// To parse this JSON data, do
//
//     final deviceIdModel = deviceIdModelFromJson(jsonString);

import 'dart:convert';

DeviceIdModel deviceIdModelFromJson(String str) => DeviceIdModel.fromJson(json.decode(str));

String deviceIdModelToJson(DeviceIdModel data) => json.encode(data.toJson());

class DeviceIdModel {
  DeviceIdModel({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory DeviceIdModel.fromJson(Map<String, dynamic> json) => DeviceIdModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
