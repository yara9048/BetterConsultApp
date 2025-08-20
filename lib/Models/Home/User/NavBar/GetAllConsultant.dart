import 'dart:convert';

List<GetAllConsultant> getAllConsultantFromJson(String str) =>
    List<GetAllConsultant>.from(
        json.decode(str).map((x) => GetAllConsultant.fromJson(x)));

String getAllConsultantToJson(List<GetAllConsultant> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllConsultant {
  int id;
  String location;
  String description;
  String? title; // nullable
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
  int? validatedBy; // nullable

  GetAllConsultant({
    required this.id,
    required this.location,
    required this.description,
    this.title,
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
    this.validatedBy,
  });

  factory GetAllConsultant.fromJson(Map<String, dynamic> json) =>
      GetAllConsultant(
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
        user: (json["user"] as num).toInt(),
        domain: (json["domain"] as num).toInt(),
        subDomain: (json["sub_domain"] as num).toInt(),
        validatedBy: json["validated_by"] != null ? (json["validated_by"] as num).toInt() : null,
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
