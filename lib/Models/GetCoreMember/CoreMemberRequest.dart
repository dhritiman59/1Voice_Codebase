// To parse this JSON data, do
//
//     final coreMemberRequest = coreMemberRequestFromJson(jsonString);

import 'dart:convert';

CoreMemberRequest coreMemberRequestFromJson(String str) => CoreMemberRequest.fromJson(json.decode(str));

String coreMemberRequestToJson(CoreMemberRequest data) => json.encode(data.toJson());

class CoreMemberRequest {
  CoreMemberRequest({
    this.status,
    this.message,
  });

  String status;
  String message;
  factory CoreMemberRequest.fromJson(Map<String, dynamic> json) => CoreMemberRequest(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
