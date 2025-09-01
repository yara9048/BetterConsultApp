// To parse this JSON data, do
//
//     final getSubDomainsModel = getSubDomainsModelFromJson(jsonString);

import 'dart:convert';

List<GetSubDomainsModel> getSubDomainsModelFromJson(String str) => List<GetSubDomainsModel>.from(json.decode(str).map((x) => GetSubDomainsModel.fromJson(x)));

String getSubDomainsModelToJson(List<GetSubDomainsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSubDomainsModel {
  int id;
  String name;
  int domain;

  GetSubDomainsModel({
    required this.id,
    required this.name,
    required this.domain,
  });

  factory GetSubDomainsModel.fromJson(Map<String, dynamic> json) => GetSubDomainsModel(
    id: json["id"],
    name: json["name"],
    domain: json["domain"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "domain": domain,
  };
}
