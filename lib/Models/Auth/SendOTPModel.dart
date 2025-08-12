// To parse this JSON data, do
//
//     final sendOtpModel = sendOtpModelFromJson(jsonString);

import 'dart:convert';

SendOtpModel sendOtpModelFromJson(String str) => SendOtpModel.fromJson(json.decode(str));

String sendOtpModelToJson(SendOtpModel data) => json.encode(data.toJson());

class SendOtpModel {
  String message;

  SendOtpModel({
    required this.message,
  });

  factory SendOtpModel.fromJson(Map<String, dynamic> json) => SendOtpModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
