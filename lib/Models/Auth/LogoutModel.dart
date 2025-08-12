// To parse this JSON data, do
//
//     final logoutModel = logoutModelFromJson(jsonString);

import 'dart:convert';

LogoutModel logoutModelFromJson(String str) => LogoutModel.fromJson(json.decode(str));

String logoutModelToJson(LogoutModel data) => json.encode(data.toJson());

class LogoutModel {
  String message;

  LogoutModel({
    required this.message,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
