// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  Chat chat;
  Message userMessage;
  Message consultantMessage;
  List<MessageResource> messageResources;

  ChatModel({
    required this.chat,
    required this.userMessage,
    required this.consultantMessage,
    required this.messageResources,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    chat: Chat.fromJson(json["chat"]),
    userMessage: Message.fromJson(json["user_message"]),
    consultantMessage: Message.fromJson(json["consultant_message"]),
    messageResources: List<MessageResource>.from(json["message_resources"].map((x) => MessageResource.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chat": chat.toJson(),
    "user_message": userMessage.toJson(),
    "consultant_message": consultantMessage.toJson(),
    "message_resources": List<dynamic>.from(messageResources.map((x) => x.toJson())),
  };
}

class Chat {
  int id;
  String title;
  DateTime createdAt;
  DateTime modifiedAt;

  Chat({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["id"],
    title: json["title"],
    createdAt: DateTime.parse(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "created_at": createdAt.toIso8601String(),
    "modified_at": modifiedAt.toIso8601String(),
  };
}

class Message {
  int id;
  String sender;
  String text;
  String? summary;
  DateTime sentAt;
  int chat;

  Message({
    required this.id,
    required this.sender,
    required this.text,
    this.summary,
    required this.sentAt,
    required this.chat,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    sender: json["sender"],
    text: json["text"],
    summary: json["summary"],
    sentAt: DateTime.parse(json["sent_at"]),
    chat: json["chat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender": sender,
    "text": text,
    "summary": summary,
    "sent_at": sentAt.toIso8601String(),
    "chat": chat,
  };
}

class MessageResource {
  int id;
  Resource resource;
  int message;

  MessageResource({
    required this.id,
    required this.resource,
    required this.message,
  });

  factory MessageResource.fromJson(Map<String, dynamic> json) => MessageResource(
    id: json["id"],
    resource: Resource.fromJson(json["resource"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "resource": resource.toJson(),
    "message": message,
  };
}

class Resource {
  int id;
  String filePath;
  FileMetaData fileMetaData;
  int relationId;
  DateTime createdAt;
  int relationType;

  Resource({
    required this.id,
    required this.filePath,
    required this.fileMetaData,
    required this.relationId,
    required this.createdAt,
    required this.relationType,
  });

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
    id: json["id"],
    filePath: json["file_path"],
    fileMetaData: FileMetaData.fromJson(json["file_meta_data"]),
    relationId: json["relation_id"],
    createdAt: DateTime.parse(json["created_at"]),
    relationType: json["relation_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
