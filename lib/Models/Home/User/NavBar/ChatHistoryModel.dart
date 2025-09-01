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

  Consultant({
    required this.id,
  });

  factory Consultant.fromJson(Map<String, dynamic> json) => Consultant(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
