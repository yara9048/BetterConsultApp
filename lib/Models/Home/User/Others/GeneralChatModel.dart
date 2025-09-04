// To parse this JSON data, do
//
//     final generalChatModel = generalChatModelFromJson(jsonString);

import 'dart:convert';

GeneralChatModel generalChatModelFromJson(String str) => GeneralChatModel.fromJson(json.decode(str));

String generalChatModelToJson(GeneralChatModel data) => json.encode(data.toJson());

class GeneralChatModel {
  String question;
  List<Consultant> consultants;

  GeneralChatModel({
    required this.question,
    required this.consultants,
  });

  factory GeneralChatModel.fromJson(Map<String, dynamic> json) => GeneralChatModel(
    question: json["question"],
    consultants: List<Consultant>.from(json["consultants"].map((x) => Consultant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "consultants": List<dynamic>.from(consultants.map((x) => x.toJson())),
  };
}

class Consultant {
  int id;
  User user;
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
  int? domain;
  int? subDomain;
  int validatedBy;
  dynamic photo;

  Consultant({
    required this.id,
    required this.user,
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
    required this.domain,
    required this.subDomain,
    required this.validatedBy,
    required this.photo,
  });

  factory Consultant.fromJson(Map<String, dynamic> json) => Consultant(
    id: json["id"],
    user: User.fromJson(json["user"]),
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
    domain: json["domain"],
    subDomain: json["sub_domain"],
    validatedBy: json["validated_by"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
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
    "domain": domain,
    "sub_domain": subDomain,
    "validated_by": validatedBy,
    "photo": photo,
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
