// To parse this JSON data, do
//
//     final viewProfileModel = viewProfileModelFromJson(jsonString);

import 'dart:convert';

ViewProfileModel viewProfileModelFromJson(String str) => ViewProfileModel.fromJson(json.decode(str));

String viewProfileModelToJson(ViewProfileModel data) => json.encode(data.toJson());

class ViewProfileModel {
  int id;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  String role;
  String gender;
  bool isActive;

  ViewProfileModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.role,
    required this.gender,
    required this.isActive,
  });

  factory ViewProfileModel.fromJson(Map<String, dynamic> json) => ViewProfileModel(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phoneNumber: json["phone_number"],
    role: json["role"],
    gender: json["gender"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
    "role": role,
    "gender": gender,
    "is_active": isActive,
  };
}
