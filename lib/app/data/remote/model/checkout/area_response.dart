import 'dart:convert';

List<AreaResponse> areaResponseFromJson(String str) => List<AreaResponse>.from(json.decode(str).map((x) => AreaResponse.fromJson(x)));

String areaResponseToJson(List<AreaResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AreaResponse {
  int? id;
  String? cityId;
  String? name;
  String? status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;

  AreaResponse({
    this.id,
    this.cityId,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
  });

  factory AreaResponse.fromJson(Map<String, dynamic> json) => AreaResponse(
    id: json["id"],
    cityId: json["city_id"],
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
    "city_id": cityId,
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
