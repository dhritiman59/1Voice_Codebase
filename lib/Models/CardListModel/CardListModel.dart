// To parse this JSON data, do
//
//     final cardListModel = cardListModelFromJson(jsonString);

import 'dart:convert';

CardListModel cardListModelFromJson(String str) => CardListModel.fromJson(json.decode(str));

String cardListModelToJson(CardListModel data) => json.encode(data.toJson());

class CardListModel {
  CardListModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  dynamic message;
  List<Datum> data;

  factory CardListModel.fromJson(Map<String, dynamic> json) => CardListModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.object,
    this.addressCity,
    this.addressCountry,
    this.addressLine1,
    this.addressLine1Check,
    this.addressLine2,
    this.addressState,
    this.addressZip,
    this.addressZipCheck,
    this.brand,
    this.country,
    this.customer,
    this.cvcCheck,
    this.dynamicLast4,
    this.expMonth,
    this.expYear,
    this.fingerprint,
    this.funding,
    this.last4,
    this.metadata,
    this.name,
    this.tokenizationMethod,
  });

  String id;
  String object;
  dynamic addressCity;
  dynamic addressCountry;
  dynamic addressLine1;
  dynamic addressLine1Check;
  dynamic addressLine2;
  dynamic addressState;
  dynamic addressZip;
  dynamic addressZipCheck;
  String brand;
  String country;
  String customer;
  String cvcCheck;
  dynamic dynamicLast4;
  int expMonth;
  int expYear;
  String fingerprint;
  String funding;
  String last4;
  Metadata metadata;
  dynamic name;
  dynamic tokenizationMethod;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    object: json["object"] == null ? null : json["object"],
    addressCity: json["address_city"],
    addressCountry: json["address_country"],
    addressLine1: json["address_line1"],
    addressLine1Check: json["address_line1_check"],
    addressLine2: json["address_line2"],
    addressState: json["address_state"],
    addressZip: json["address_zip"],
    addressZipCheck: json["address_zip_check"],
    brand: json["brand"] == null ? null : json["brand"],
    country: json["country"] == null ? null : json["country"],
    customer: json["customer"] == null ? null : json["customer"],
    cvcCheck: json["cvc_check"] == null ? null : json["cvc_check"],
    dynamicLast4: json["dynamic_last4"],
    expMonth: json["exp_month"] == null ? null : json["exp_month"],
    expYear: json["exp_year"] == null ? null : json["exp_year"],
    fingerprint: json["fingerprint"] == null ? null : json["fingerprint"],
    funding: json["funding"] == null ? null : json["funding"],
    last4: json["last4"] == null ? null : json["last4"],
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
    name: json["name"],
    tokenizationMethod: json["tokenization_method"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "object": object == null ? null : object,
    "address_city": addressCity,
    "address_country": addressCountry,
    "address_line1": addressLine1,
    "address_line1_check": addressLine1Check,
    "address_line2": addressLine2,
    "address_state": addressState,
    "address_zip": addressZip,
    "address_zip_check": addressZipCheck,
    "brand": brand == null ? null : brand,
    "country": country == null ? null : country,
    "customer": customer == null ? null : customer,
    "cvc_check": cvcCheck == null ? null : cvcCheck,
    "dynamic_last4": dynamicLast4,
    "exp_month": expMonth == null ? null : expMonth,
    "exp_year": expYear == null ? null : expYear,
    "fingerprint": fingerprint == null ? null : fingerprint,
    "funding": funding == null ? null : funding,
    "last4": last4 == null ? null : last4,
    "metadata": metadata == null ? null : metadata.toJson(),
    "name": name,
    "tokenization_method": tokenizationMethod,
  };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
  );

  Map<String, dynamic> toJson() => {
  };
}
