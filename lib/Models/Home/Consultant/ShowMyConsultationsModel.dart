// To parse this JSON data, do
//
//     final myConsultations = myConsultationsFromJson(jsonString);

import 'dart:convert';

List<MyConsultations> myConsultationsFromJson(String str) => List<MyConsultations>.from(json.decode(str).map((x) => MyConsultations.fromJson(x)));

String myConsultationsToJson(List<MyConsultations> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyConsultations {
  int id;
  int consultant;
  String question;
  String answer;
  double confidenceQuestion;
  double confidenceAnswer;
  int viewsCount;

  MyConsultations({
    required this.id,
    required this.consultant,
    required this.question,
    required this.answer,
    required this.confidenceQuestion,
    required this.confidenceAnswer,
    required this.viewsCount,
  });

  factory MyConsultations.fromJson(Map<String, dynamic> json) => MyConsultations(
    id: json["id"],
    consultant: json["consultant"],
    question: json["question"],
    answer: json["answer"],
    confidenceQuestion: json["confidence_question"]?.toDouble(),
    confidenceAnswer: json["confidence_answer"]?.toDouble(),
    viewsCount: json["views_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "consultant": consultant,
    "question": question,
    "answer": answer,
    "confidence_question": confidenceQuestion,
    "confidence_answer": confidenceAnswer,
    "views_count": viewsCount,
  };
}
