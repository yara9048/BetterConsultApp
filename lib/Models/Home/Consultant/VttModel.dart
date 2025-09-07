// To parse this JSON data, do
//
//     final voiceModel = voiceModelFromJson(jsonString);

import 'dart:convert';

VoiceModel voiceModelFromJson(String str) => VoiceModel.fromJson(json.decode(str));

String voiceModelToJson(VoiceModel data) => json.encode(data.toJson());

class VoiceModel {
  String transcript;

  VoiceModel({
    required this.transcript,
  });

  factory VoiceModel.fromJson(Map<String, dynamic> json) => VoiceModel(
    transcript: json["transcript"],
  );

  Map<String, dynamic> toJson() => {
    "transcript": transcript,
  };
}
