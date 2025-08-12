// To parse this JSON data, do
//
//     final resetPasswordModel = resetPasswordModelFromJson(jsonString);

import 'dart:convert';

ResetPasswordModel resetPasswordModelFromJson(String str) => ResetPasswordModel.fromJson(json.decode(str));

String resetPasswordModelToJson(ResetPasswordModel data) => json.encode(data.toJson());

class ResetPasswordModel {
  String message;
  String token;
  User user;

  ResetPasswordModel({
    required this.message,
    required this.token,
    required this.user,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) => ResetPasswordModel(
    message: json["message"],
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "user": user.toJson(),
  };
}

class User {
  int id;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  String role;
  String gender;
  bool isActive;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.role,
    required this.gender,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
