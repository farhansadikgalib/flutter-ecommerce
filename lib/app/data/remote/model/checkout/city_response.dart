import 'dart:convert';

List<CityResponse> cityResponseFromJson(String str) => List<CityResponse>.from(json.decode(str).map((x) => CityResponse.fromJson(x)));

String cityResponseToJson(List<CityResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityResponse {
  int? id;
  String? name;
  String? status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? countryId;

  CityResponse({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.countryId,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    countryId: json["country_id"],
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
    "country_id": countryId,
  };
}
