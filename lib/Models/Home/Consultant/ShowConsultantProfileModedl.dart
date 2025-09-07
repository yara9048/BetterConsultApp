import 'dart:convert';

ShowConsultantProfileModedl showConsultantProfileModedlFromJson(String str) =>
    ShowConsultantProfileModedl.fromJson(json.decode(str));

String showConsultantProfileModedlToJson(ShowConsultantProfileModedl data) =>
    json.encode(data.toJson());

class ShowConsultantProfileModedl {
  int id;
  String? firstName;
  String? lastName;
  String? email;
  String? location;
  String? description;
  String? title;
  int yearsExperience;
  int cost;
  int domain;
  int subDomain;
  String? domainName;
  String? subDomainName;
  bool validated;
  String? validatedBy;
  DateTime? validatedAt;
  DateTime? addedAt;
  double rating;
  int reviewCount;
  bool isFavorite;
  dynamic photo;

  ShowConsultantProfileModedl({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.location,
    this.description,
    this.title,
    required this.yearsExperience,
    required this.cost,
    required this.domain,
    required this.subDomain,
    this.domainName,
    this.subDomainName,
    required this.validated,
    this.validatedBy,
    this.validatedAt,
    this.addedAt,
    required this.rating,
    required this.reviewCount,
    required this.isFavorite,
    this.photo,
  });

  factory ShowConsultantProfileModedl.fromJson(Map<String, dynamic> json) =>
      ShowConsultantProfileModedl(
        id: json["id"] ?? 0,
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        location: json["location"],
        description: json["description"],
        title: json["title"],
        yearsExperience: json["years_experience"] ?? 0,
        cost: json["cost"] ?? 0,
        domain: json["domain"] ?? 0,
        subDomain: json["sub_domain"] ?? 0,
        domainName: json["domain_name"],
        subDomainName: json["sub_domain_name"],
        validated: json["validated"] ?? false,
        validatedBy: json["validated_by"],
        validatedAt: json["validated_at"] != null
            ? DateTime.tryParse(json["validated_at"])
            : null,
        addedAt: json["added_at"] != null
            ? DateTime.tryParse(json["added_at"])
            : null,
        rating: (json["rating"] ?? 0).toDouble(),
        reviewCount: json["review_count"] ?? 0,
        isFavorite: json["isFavorite"] ?? false,
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
    "validated_at": validatedAt?.toIso8601String(),
    "added_at": addedAt?.toIso8601String(),
    "rating": rating,
    "review_count": reviewCount,
    "isFavorite": isFavorite,
    "photo": photo,
  };
}
