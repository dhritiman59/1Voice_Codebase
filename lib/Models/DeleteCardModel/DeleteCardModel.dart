// To parse this JSON data, do
//
//     final deleteCardtModel = deleteCardtModelFromJson(jsonString);

import 'dart:convert';

DeleteCardtModel deleteCardtModelFromJson(String str) => DeleteCardtModel.fromJson(json.decode(str));

String deleteCardtModelToJson(DeleteCardtModel data) => json.encode(data.toJson());

class DeleteCardtModel {
  DeleteCardtModel({
    this.status,
  });

  String status;


  factory DeleteCardtModel.fromJson(Map<String, dynamic> json) => DeleteCardtModel(
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
  };
}
