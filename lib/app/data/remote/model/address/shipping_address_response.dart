import 'dart:convert';

List<AddressResponse> addressResponseFromJson(String str) => List<AddressResponse>.from(json.decode(str).map((x) => AddressResponse.fromJson(x)));

String addressResponseToJson(List<AddressResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressResponse {
  int? id;
  String? userId;
  String? title;
  String? address;
  String? countryId;
  String? cityId;
  String? notes;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? areaId;
  String? addressResponseDefault;
  Area? city;
  Area? country;
  Area? area;

  AddressResponse({
    this.id,
    this.userId,
    this.title,
    this.address,
    this.countryId,
    this.cityId,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.areaId,
    this.addressResponseDefault,
    this.city,
    this.country,
    this.area,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) => AddressResponse(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    address: json["address"],
    countryId: json["country_id"],
    cityId: json["city_id"],
    notes: json["notes"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    areaId: json["area_id"],
    addressResponseDefault: json["default"],
    city: json["city"] == null ? null : Area.fromJson(json["city"]),
    country: json["country"] == null ? null : Area.fromJson(json["country"]),
    area: json["area"] == null ? null : Area.fromJson(json["area"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "address": address,
    "country_id": countryId,
    "city_id": cityId,
    "notes": notes,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "area_id": areaId,
    "default": addressResponseDefault,
    "city": city?.toJson(),
    "country": country?.toJson(),
    "area": area?.toJson(),
  };
}

class Area {
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
  String? countryId;

  Area({
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
    this.countryId,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
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
    countryId: json["country_id"],
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
    "country_id": countryId,
  };
}
