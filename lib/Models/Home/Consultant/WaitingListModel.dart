import 'dart:convert';

// To parse JSON
WaitingListModel waitingListModelFromJson(String str) =>
    WaitingListModel.fromJson(json.decode(str));

String waitingListModelToJson(WaitingListModel data) =>
    json.encode(data.toJson());

class WaitingListModel {
  List<WaitingQuestion> waitingQuestions;

  WaitingListModel({required this.waitingQuestions});

  factory WaitingListModel.fromJson(Map<String, dynamic> json) => WaitingListModel(
    waitingQuestions: json["waiting_questions"] != null
        ? List<WaitingQuestion>.from(
        json["waiting_questions"].map((x) => WaitingQuestion.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "waiting_questions": List<dynamic>.from(waitingQuestions.map((x) => x.toJson())),
  };
}

class WaitingQuestion {
  int? id;
  Consultant? consultant;
  User? user;
  String? question;

  WaitingQuestion({this.id, this.consultant, this.user, this.question});

  factory WaitingQuestion.fromJson(Map<String, dynamic> json) => WaitingQuestion(
    id: json["id"],
    consultant: json["consultant"] != null ? Consultant.fromJson(json["consultant"]) : null,
    user: json["user"] != null ? User.fromJson(json["user"]) : null,
    question: json["question"] ?? "No question",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "consultant": consultant?.toJson(),
    "user": user?.toJson(),
    "question": question,
  };
}

class Consultant {
  int? id;
  User? user;
  Domain? domain;
  Domain? subDomain;
  String? location;
  String? description;
  String? title;
  int? yearsExperience;
  int? cost;
  bool? validated;
  DateTime? validatedAt;
  DateTime? addedAt;
  double? rating;
  int? reviewCount;
  int? validatedBy;
  dynamic photo;

  Consultant({
    this.id,
    this.user,
    this.domain,
    this.subDomain,
    this.location,
    this.description,
    this.title,
    this.yearsExperience,
    this.cost,
    this.validated,
    this.validatedAt,
    this.addedAt,
    this.rating,
    this.reviewCount,
    this.validatedBy,
    this.photo,
  });

  factory Consultant.fromJson(Map<String, dynamic> json) => Consultant(
    id: json["id"],
    user: json["user"] != null ? User.fromJson(json["user"]) : null,
    domain: json["domain"] != null ? Domain.fromJson(json["domain"]) : null,
    subDomain: json["sub_domain"] != null ? Domain.fromJson(json["sub_domain"]) : null,
    location: json["location"] ?? "",
    description: json["description"] ?? "",
    title: json["title"] ?? "",
    yearsExperience: json["years_experience"] ?? 0,
    cost: json["cost"] ?? 0,
    validated: json["validated"] ?? false,
    validatedAt: json["validated_at"] != null ? DateTime.parse(json["validated_at"]) : null,
    addedAt: json["added_at"] != null ? DateTime.parse(json["added_at"]) : null,
    rating: (json["rating"] ?? 0).toDouble(),
    reviewCount: json["review_count"] ?? 0,
    validatedBy: json["validated_by"] ?? 0,
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user?.toJson(),
    "domain": domain?.toJson(),
    "sub_domain": subDomain?.toJson(),
    "location": location,
    "description": description,
    "title": title,
    "years_experience": yearsExperience,
    "cost": cost,
    "validated": validated,
    "validated_at": validatedAt?.toIso8601String(),
    "added_at": addedAt?.toIso8601String(),
    "rating": rating,
    "review_count": reviewCount,
    "validated_by": validatedBy,
    "photo": photo,
  };
}

class Domain {
  int? id;
  Name? name;
  Status? status;
  int? domain;

  Domain({this.id, this.name, this.status, this.domain});

  factory Domain.fromJson(Map<String, dynamic> json) => Domain(
    id: json["id"],
    name: nameValues.map[json["name"]],
    status: statusValues.map[json["status"]],
    domain: json["domain"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name != null ? nameValues.reverse[name] : null,
    "status": status != null ? statusValues.reverse[status] : null,
    "domain": domain,
  };
}

enum Name { ANALYSIS, MATH }

final nameValues = EnumValues({
  "Analysis": Name.ANALYSIS,
  "Math": Name.MATH,
});

enum Status { APPROVED }

final statusValues = EnumValues({"approved": Status.APPROVED});

class User {
  int? id;
  Email? email;
  FirstName? firstName;
  LastName? lastName;
  String? phoneNumber;
  Role? role;
  Gender? gender;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.role,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: emailValues.map[json["email"]],
    firstName: firstNameValues.map[json["first_name"]],
    lastName: lastNameValues.map[json["last_name"]],
    phoneNumber: json["phone_number"] ?? "",
    role: roleValues.map[json["role"]],
    gender: genderValues.map[json["gender"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email != null ? emailValues.reverse[email] : null,
    "first_name": firstName != null ? firstNameValues.reverse[firstName] : null,
    "last_name": lastName != null ? lastNameValues.reverse[lastName] : null,
    "phone_number": phoneNumber,
    "role": role != null ? roleValues.reverse[role] : null,
    "gender": gender != null ? genderValues.reverse[gender] : null,
  };
}

enum Email { YARASALEH121_GMAIL_COM, YARA_GMAIL_COM }

final emailValues = EnumValues({
  "yarasaleh121@gmail.com": Email.YARASALEH121_GMAIL_COM,
  "yara@gmail.com": Email.YARA_GMAIL_COM,
});

enum FirstName { YARA }

final firstNameValues = EnumValues({"yara": FirstName.YARA});

enum LastName { SALEH }

final lastNameValues = EnumValues({"saleh": LastName.SALEH});

enum Gender { FEMALE, MALE }

final genderValues = EnumValues({"female": Gender.FEMALE, "male": Gender.MALE});

enum Role { CONSULTANT, USER }

final roleValues = EnumValues({"consultant": Role.CONSULTANT, "user": Role.USER});

class EnumValues<T> {
  final Map<String, T> map;
  late final Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
