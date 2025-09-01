// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

List<FavoriteModel> favoriteModelFromJson(String str) => List<FavoriteModel>.from(json.decode(str).map((x) => FavoriteModel.fromJson(x)));

String favoriteModelToJson(List<FavoriteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavoriteModel {
  int id;
  String firstName;
  String lastName;
  String email;
  String location;
  String description;
  dynamic title;
  int yearsExperience;
  int cost;
  int domain;
  int subDomain;
  String domainName;
  String subDomainName;
  bool validated;
  String validatedBy;
  DateTime validatedAt;
  DateTime addedAt;
  int rating;
  int reviewCount;
  bool isFavorite;
  dynamic photo;

  FavoriteModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.location,
    required this.description,
    required this.title,
    required this.yearsExperience,
    required this.cost,
    required this.domain,
    required this.subDomain,
    required this.domainName,
    required this.subDomainName,
    required this.validated,
    required this.validatedBy,
    required this.validatedAt,
    required this.addedAt,
    required this.rating,
    required this.reviewCount,
    required this.isFavorite,
    required this.photo,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    id: (json["id"] as num).toInt(),
    location: json["location"],
    description: json["description"],
    title: json["title"],
    yearsExperience: (json["years_experience"] as num).toInt(),
    cost: (json["cost"] as num).toInt(),
    validated: json["validated"],
    validatedAt: DateTime.parse(json["validated_at"]),
    addedAt: DateTime.parse(json["added_at"]),
    rating: json["rating"] != null ? (json["rating"] as num).toInt() : 0,
    reviewCount: json["review_count"] != null ? (json["review_count"] as num).toInt() : 0,
    domain: (json["domain"] as num).toInt(),
    subDomain: (json["sub_domain"] as num).toInt(),
    validatedBy: json["validated_by"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
     domainName: json["domain_name"],
    subDomainName: json["sub_domain_name"],
    isFavorite: json["isFavorite"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "location": location,
    "description": description,
    "title": title,
    "years_experience": yearsExperience,
    "cost": cost,
    "domain": domain,
    "sub_domain": subDomain,
    "domain_name": domainName,
    "sub_domain_name": subDomainName,
    "validated": validated,
    "validated_by": validatedBy,
    "validated_at": validatedAt.toIso8601String(),
    "added_at": addedAt.toIso8601String(),
    "rating": rating,
    "review_count": reviewCount,
    "isFavorite": isFavorite,
    "photo": photo,
  };
}
