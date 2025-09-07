// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

List<NotificationsModel> notificationsModelFromJson(String str) => List<NotificationsModel>.from(json.decode(str).map((x) => NotificationsModel.fromJson(x)));

String notificationsModelToJson(List<NotificationsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationsModel {
  int id;
  String title;
  String body;
  Data data;
  bool read;
  DateTime createdAt;

  NotificationsModel({
    required this.id,
    required this.title,
    required this.body,
    required this.data,
    required this.read,
    required this.createdAt,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    data: Data.fromJson(json["data"]),
    read: json["read"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "data": data.toJson(),
    "read": read,
    "created_at": createdAt.toIso8601String(),
  };
}

class Data {
  String type;
  String applicationId;
  String status;

  Data({
    required this.type,
    required this.applicationId,
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    applicationId: json["application_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "application_id": applicationId,
    "status": status,
  };
}
