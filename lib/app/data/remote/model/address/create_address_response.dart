import 'dart:convert';

CreateAddressResponse createAddressResponseFromJson(String str) => CreateAddressResponse.fromJson(json.decode(str));

String createAddressResponseToJson(CreateAddressResponse data) => json.encode(data.toJson());

class CreateAddressResponse {
  String? status;
  String? message;
  CustomerAddress? customerAddress;

  CreateAddressResponse({
    this.status,
    this.message,
    this.customerAddress,
  });

  factory CreateAddressResponse.fromJson(Map<String, dynamic> json) => CreateAddressResponse(
    status: json["status"],
    message: json["message"],
    customerAddress: json["customer_address"] == null ? null : CustomerAddress.fromJson(json["customer_address"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "customer_address": customerAddress?.toJson(),
  };
}

class CustomerAddress {
  int? userId;
  String? title;
  String? address;
  String? countryId;
  String? cityId;
  String? notes;
  String? areaId;
  String? updatedAt;
  String? createdAt;
  int? id;

  CustomerAddress({
    this.userId,
    this.title,
    this.address,
    this.countryId,
    this.cityId,
    this.notes,
    this.areaId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory CustomerAddress.fromJson(Map<String, dynamic> json) => CustomerAddress(
    userId: json["user_id"],
    title: json["title"],
    address: json["address"],
    countryId: json["country_id"],
    cityId: json["city_id"],
    notes: json["notes"],
    areaId: json["area_id"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "title": title,
    "address": address,
    "country_id": countryId,
    "city_id": cityId,
    "notes": notes,
    "area_id": areaId,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}
