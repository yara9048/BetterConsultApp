// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  String message;

  VerifyOtpModel({
    required this.message,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
