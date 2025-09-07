// To parse this JSON data, do
//
//     final roleModel = roleModelFromJson(jsonString);

import 'dart:convert';

RoleModel roleModelFromJson(String str) => RoleModel.fromJson(json.decode(str));

String roleModelToJson(RoleModel data) => json.encode(data.toJson());

class RoleModel {
  int userId;
  String email;
  String role;

  RoleModel({
    required this.userId,
    required this.email,
    required this.role,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
    userId: json["user_id"],
    email: json["email"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "email": email,
    "role": role,
  };
}
