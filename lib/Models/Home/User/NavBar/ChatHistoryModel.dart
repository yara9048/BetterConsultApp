// To parse this JSON data, do
//
//     final chatHistoryModel = chatHistoryModelFromJson(jsonString);

import 'dart:convert';

List<ChatHistoryModel> chatHistoryModelFromJson(String str) => List<ChatHistoryModel>.from(json.decode(str).map((x) => ChatHistoryModel.fromJson(x)));

String chatHistoryModelToJson(List<ChatHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatHistoryModel {
  int id;
  String title;
  Consultant consultant;
  DateTime createdAt;
  DateTime modifiedAt;

  ChatHistoryModel({
    required this.id,
    required this.title,
    required this.consultant,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory ChatHistoryModel.fromJson(Map<String, dynamic> json) => ChatHistoryModel(
    id: json["id"],
    title: json["title"],
    consultant: Consultant.fromJson(json["consultant"]),
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "consultant": consultant.toJson(),
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
  };
}

class Consultant {
  int id;
  User user;
  Domain domain;
  Domain subDomain;
  String location;
  String description;
  dynamic title;
  int yearsExperience;
  int cost;
  bool validated;
  DateTime validatedAt;
  DateTime addedAt;
  double rating;
  int reviewCount;
  int validatedBy;
  dynamic photo;

  Consultant({
    required this.id,
    required this.user,
    required this.domain,
    required this.subDomain,
    required this.location,
    required this.description,
    required this.title,
    required this.yearsExperience,
    required this.cost,
    required this.validated,
    required this.validatedAt,
    required this.addedAt,
    required this.rating,
    required this.reviewCount,
    required this.validatedBy,
    required this.photo,
  });

  factory Consultant.fromJson(Map<String, dynamic> json) => Consultant(
    id: json["id"],
    user: User.fromJson(json["user"]),
    domain: Domain.fromJson(json["domain"]),
    subDomain: Domain.fromJson(json["sub_domain"]),
    location: json["location"],
    description: json["description"],
    title: json["title"],
    yearsExperience: json["years_experience"],
    cost: json["cost"],
    validated: json["validated"],
    validatedAt: DateTime.parse(json["validated_at"]),
    addedAt: DateTime.parse(json["added_at"]),
    rating: json["rating"],
    reviewCount: json["review_count"],
    validatedBy: json["validated_by"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
    "domain": domain.toJson(),
    "sub_domain": subDomain.toJson(),
    "location": location,
    "description": description,
    "title": title,
    "years_experience": yearsExperience,
    "cost": cost,
    "validated": validated,
    "validated_at": validatedAt.toIso8601String(),
    "added_at": addedAt.toIso8601String(),
    "rating": rating,
    "review_count": reviewCount,
    "validated_by": validatedBy,
    "photo": photo,
  };
}

class Domain {
  int id;
  String name;
  String status;
  int? domain;

  Domain({
    required this.id,
    required this.name,
    required this.status,
    this.domain,
  });

  factory Domain.fromJson(Map<String, dynamic> json) => Domain(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    domain: json["domain"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "domain": domain,
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

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.role,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phoneNumber: json["phone_number"],
    role: json["role"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
    "role": role,
    "gender": gender,
  };
}
