// To parse this JSON data, do
//
//     final getAllConsultant = getAllConsultantFromJson(jsonString);

import 'dart:convert';

List<GetAllConsultant> getAllConsultantFromJson(String str) => List<GetAllConsultant>.from(json.decode(str).map((x) => GetAllConsultant.fromJson(x)));

String getAllConsultantToJson(List<GetAllConsultant> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllConsultant {
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
  Photo photo;

  GetAllConsultant({
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

  factory GetAllConsultant.fromJson(Map<String, dynamic> json) => GetAllConsultant(
    id: (json["id"] as num).toInt(),
    firstName: json["first_name"] ?? "",
    lastName: json["last_name"] ?? "",
    email: json["email"] ?? "",
    location: json["location"] ?? "",
    description: json["description"] ?? "",
    title: json["title"],
    yearsExperience: (json["years_experience"] as num?)?.toInt() ?? 0,
    cost: (json["cost"] as num?)?.toInt() ?? 0,
    domain: (json["domain"] as num?)?.toInt() ?? 0,
    subDomain: (json["sub_domain"] as num?)?.toInt() ?? 0,
    domainName: json["domain_name"] ?? "",
    subDomainName: json["sub_domain_name"] ?? "",
    validated: json["validated"] ?? false,
    validatedBy: json["validated_by"] ?? "",
    validatedAt: json["validated_at"] != null ? DateTime.parse(json["validated_at"]) : DateTime.now(),
    addedAt: json["added_at"] != null ? DateTime.parse(json["added_at"]) : DateTime.now(),
    rating: (json["rating"] as num?)?.toInt() ?? 0,
    reviewCount: (json["review_count"] as num?)?.toInt() ?? 0,
    isFavorite: json["isFavorite"] ?? false,
    photo: json["photo"] != null ? Photo.fromJson(json["photo"]) : Photo.empty(), // Handle null photo
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
    "photo": photo.toJson(),
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

  // Add an empty constructor for null cases
  factory Photo.empty() => Photo(
    id: 0,
    fileUrl: "",
    filePath: "",
    fileMetaData: FileMetaData.empty(),
    relationId: 0,
    createdAt: DateTime.now(),
    relationType: 0,
  );

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    id: (json["id"] as num?)?.toInt() ?? 0,
    fileUrl: json["file_url"] ?? "",
    filePath: json["file_path"] ?? "",
    fileMetaData: json["file_meta_data"] != null
        ? FileMetaData.fromJson(json["file_meta_data"])
        : FileMetaData.empty(),
    relationId: (json["relation_id"] as num?)?.toInt() ?? 0,
    createdAt: json["created_at"] != null
        ? DateTime.parse(json["created_at"])
        : DateTime.now(),
    relationType: (json["relation_type"] as num?)?.toInt() ?? 0,
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

  // Add an empty constructor for null cases
  factory FileMetaData.empty() => FileMetaData(
    fileName: "",
    fileSizeBytes: 0,
    fileType: "",
  );

  factory FileMetaData.fromJson(Map<String, dynamic> json) => FileMetaData(
    fileName: json["file_name"] ?? "",
    fileSizeBytes: (json["file_size_bytes"] as num?)?.toInt() ?? 0,
    fileType: json["file_type"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "file_name": fileName,
    "file_size_bytes": fileSizeBytes,
    "file_type": fileType,
  };
}