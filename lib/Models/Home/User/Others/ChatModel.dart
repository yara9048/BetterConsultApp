// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  int chatId;
  Message userMessage;
  Message consultantMessage;

  ChatModel({
    required this.chatId,
    required this.userMessage,
    required this.consultantMessage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    chatId: json["chat_id"],
    userMessage: Message.fromJson(json["user_message"]),
    consultantMessage: Message.fromJson(json["consultant_message"]),
  );

  Map<String, dynamic> toJson() => {
    "chat_id": chatId,
    "user_message": userMessage.toJson(),
    "consultant_message": consultantMessage.toJson(),
  };
}

class Message {
  int id;
  int chat;
  String sender;
  String text;
  DateTime sentAt;

  Message({
    required this.id,
    required this.chat,
    required this.sender,
    required this.text,
    required this.sentAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
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
