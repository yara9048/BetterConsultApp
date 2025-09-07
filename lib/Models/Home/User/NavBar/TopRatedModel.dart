// To parse this JSON data, do
//
//     final topRatedModel = topRatedModelFromJson(jsonString);

import 'dart:convert';

List<TopRatedModel> topRatedModelFromJson(String str) => List<TopRatedModel>.from(json.decode(str).map((x) => TopRatedModel.fromJson(x)));

String topRatedModelToJson(List<TopRatedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopRatedModel {
  int id;
  String firstName;
  String lastName;
  String email;
  String location;
  String description;
  String? title;
  int yearsExperience;
  int cost;
  int? domain;
  int? subDomain;
  String? domainName;
  String? subDomainName;
  bool validated;
  String validatedBy;
  DateTime validatedAt;
  DateTime addedAt;
  double rating;
  int reviewCount;
  bool isFavorite;
  Photo? photo;

  TopRatedModel({
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
    this.domainName,
    this.subDomainName,
    required this.validated,
    required this.validatedBy,
    required this.validatedAt,
    required this.addedAt,
    required this.rating,
    required this.reviewCount,
    required this.isFavorite,
    required this.photo,
  });

  factory TopRatedModel.fromJson(Map<String, dynamic> json) => TopRatedModel(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    location: json["location"],
    description: json["description"],
    title: json["title"],
    yearsExperience: json["years_experience"],
    cost: json["cost"],
    domain: json["domain"],
    subDomain: json["sub_domain"],
    domainName: json["domain_name"],
    subDomainName: json["sub_domain_name"],
    validated: json["validated"],
    validatedBy: json["validated_by"],
    validatedAt: DateTime.parse(json["validated_at"]),
    addedAt: DateTime.parse(json["added_at"]),
    rating: json["rating"],
    reviewCount: json["review_count"],
    isFavorite: json["isFavorite"],
    photo: json["photo"] == null ? null : Photo.fromJson(json["photo"]),
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
    "photo": photo?.toJson(),
  };
}

class Photo {
  int id;
  String fileUrl;
  String filePath;
  FileMetaData fileMetaData;
  int relationId;
  DateTime createdAt;
  int relationType;

  Photo({
    required this.id,
    required this.fileUrl,
    required this.filePath,
    required this.fileMetaData,
    required this.relationId,
    required this.createdAt,
    required this.relationType,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    id: json["id"],
    fileUrl: json["file_url"],
    filePath: json["file_path"],
    fileMetaData: FileMetaData.fromJson(json["file_meta_data"]),
    relationId: json["relation_id"],
    createdAt: DateTime.parse(json["created_at"]),
    relationType: json["relation_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file_url": fileUrl,
    "file_path": filePath,
    "file_meta_data": fileMetaData.toJson(),
    "relation_id": relationId,
    "created_at": createdAt.toIso8601String(),
    "relation_type": relationType,
  };
}

class FileMetaData {
  String fileName;
  int fileSizeBytes;
  String fileType;

  FileMetaData({
    required this.fileName,
    required this.fileSizeBytes,
    required this.fileType,
  });

  factory FileMetaData.fromJson(Map<String, dynamic> json) => FileMetaData(
    fileName: json["file_name"],
    fileSizeBytes: json["file_size_bytes"],
    fileType: json["file_type"],
  );

  Map<String, dynamic> toJson() => {
    "file_name": fileName,
    "file_size_bytes": fileSizeBytes,
    "file_type": fileType,
  };
}
