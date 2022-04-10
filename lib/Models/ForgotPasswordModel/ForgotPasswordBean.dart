// To parse this JSON data, do
//
//     final forgotPasswordBean = forgotPasswordBeanFromJson(jsonString);

import 'dart:convert';

ForgotPasswordBean forgotPasswordBeanFromJson(String str) => ForgotPasswordBean.fromJson(json.decode(str));

String forgotPasswordBeanToJson(ForgotPasswordBean data) => json.encode(data.toJson());

class ForgotPasswordBean {
  ForgotPasswordBean({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory ForgotPasswordBean.fromJson(Map<String, dynamic> json) => ForgotPasswordBean(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
