// To parse this JSON data, do
//
//     final countryResponse = countryResponseFromJson(jsonString);

import 'dart:convert';

List<CountryResponse> countryResponseFromJson(String str) => List<CountryResponse>.from(json.decode(str).map((x) => CountryResponse.fromJson(x)));

String countryResponseToJson(List<CountryResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryResponse {
  int? id;
  String? name;
  String? status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;

  CountryResponse({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) => CountryResponse(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
  };
}
