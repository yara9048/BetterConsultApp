// To parse this JSON data, do
//
//     final chatHistoryContentModel = chatHistoryContentModelFromJson(jsonString);

import 'dart:convert';

List<ChatHistoryContentModel> chatHistoryContentModelFromJson(String str) => List<ChatHistoryContentModel>.from(json.decode(str).map((x) => ChatHistoryContentModel.fromJson(x)));

String chatHistoryContentModelToJson(List<ChatHistoryContentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatHistoryContentModel {
  int id;
  int chat;
  String sender;
  String text;
  DateTime sentAt;

  ChatHistoryContentModel({
    required this.id,
    required this.chat,
    required this.sender,
    required this.text,
    required this.sentAt,
  });

  factory ChatHistoryContentModel.fromJson(Map<String, dynamic> json) => ChatHistoryContentModel(
    id: json["id"],
    chat: json["chat"],
    sender: json["sender"],
    text: json["text"],
    sentAt: DateTime.parse(json["sent_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chat": chat,
    "sender": sender,
    "text": text,
    "sent_at": sentAt.toIso8601String(),
  };
}
