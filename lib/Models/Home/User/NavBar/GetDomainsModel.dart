// To parse this JSON data, do
//
//     final getDomainsModel = getDomainsModelFromJson(jsonString);

import 'dart:convert';

List<GetDomainsModel> getDomainsModelFromJson(String str) => List<GetDomainsModel>.from(json.decode(str).map((x) => GetDomainsModel.fromJson(x)));

String getDomainsModelToJson(List<GetDomainsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetDomainsModel {
  int id;
  String name;
  dynamic photo;

  GetDomainsModel({
    required this.id,
    required this.name,
    required this.photo,
  });

  factory GetDomainsModel.fromJson(Map<String, dynamic> json) => GetDomainsModel(
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
  };
}
