// To parse this JSON data, do
//
//     final deleteCommentModel = deleteCommentModelFromJson(jsonString);

import 'dart:convert';

DeleteCommentModel deleteCommentModelFromJson(String str) => DeleteCommentModel.fromJson(json.decode(str));

String deleteCommentModelToJson(DeleteCommentModel data) => json.encode(data.toJson());

class DeleteCommentModel {
  DeleteCommentModel({
    this.status,
  });

  String status;

  factory DeleteCommentModel.fromJson(Map<String, dynamic> json) => DeleteCommentModel(
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
  };
}
