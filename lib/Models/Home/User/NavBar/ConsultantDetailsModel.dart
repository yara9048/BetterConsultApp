import 'dart:convert';

class ConsultandDetailsModel {
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

  ConsultandDetailsModel({
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

  factory ConsultandDetailsModel.fromJson(Map<String, dynamic> json) {
    return ConsultandDetailsModel(
      id: (json["id"] as num).toInt(),
      location: json["location"],
      description: json["description"],
      title: json["title"],
      yearsExperience: (json["years_experience"] as num).toInt(),
      cost: (json["cost"] as num).toInt(),
      validated: json["validated"],
      validatedAt: DateTime.parse(json["validated_at"]),
      addedAt: DateTime.parse(json["added_at"]),
      rating: (json["rating"] as num).toInt(),
      reviewCount: (json["review_count"] as num).toInt(),
      user: (json["user"] as num).toInt(),
      domain: (json["domain"] as num).toInt(),
      subDomain: (json["sub_domain"] as num).toInt(),
      validatedBy: json["validated_by"] != null ? (json["validated_by"] as num).toInt() : null,
    );
  }

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