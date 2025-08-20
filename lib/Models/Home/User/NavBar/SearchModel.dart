// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel {
  int id;
  String location;
  String description;
  dynamic title;
  int yearsExperience;
  int cost;
  bool validated;
  DateTime validatedAt;
  DateTime addedAt;
  int rating;
  int reviewCount;
  int user;
  int domain;
  int subDomain;
  int? validatedBy;

  SearchModel({
    required this.id,
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
    required this.user,
    required this.domain,
    required this.subDomain,
    required this.validatedBy,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    id: json["id"],
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
    user: json["user"],
    domain: json["domain"],
    subDomain: json["sub_domain"],
    validatedBy: json["validated_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
    "user": user,
    "domain": domain,
    "sub_domain": subDomain,
    "validated_by": validatedBy,
  };
}
