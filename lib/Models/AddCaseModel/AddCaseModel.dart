// To parse this JSON data, do
//
//     final addCaseModel = addCaseModelFromJson(jsonString);

import 'dart:convert';

AddCaseModel addCaseModelFromJson(String str) => AddCaseModel.fromJson(json.decode(str));

String addCaseModelToJson(AddCaseModel data) => json.encode(data.toJson());

class AddCaseModel {
  AddCaseModel({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory AddCaseModel.fromJson(Map<String, dynamic> json) => AddCaseModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
