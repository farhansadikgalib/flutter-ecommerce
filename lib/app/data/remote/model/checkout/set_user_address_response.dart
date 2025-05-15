// To parse this JSON data, do
//
//     final setUserAddressResponse = setUserAddressResponseFromJson(jsonString);

import 'dart:convert';

SetUserAddressResponse setUserAddressResponseFromJson(String str) => SetUserAddressResponse.fromJson(json.decode(str));

String setUserAddressResponseToJson(SetUserAddressResponse data) => json.encode(data.toJson());

class SetUserAddressResponse {
  Data? data;
  int? status;
  dynamic token;
  String? message;

  SetUserAddressResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory SetUserAddressResponse.fromJson(Map<String, dynamic> json) => SetUserAddressResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    status: json["status"],
    token: json["token"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "status": status,
    "token": token,
    "message": message,
  };
}

class Data {
  int? userId;
  String? email;
  String? name;
  String? address1;
  String? phone;
  String? city;
  int? id;

  Data({
    this.userId,
    this.email,
    this.name,
    this.address1,
    this.phone,
    this.city,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    email: json["email"],
    name: json["name"],
    address1: json["address_1"],
    phone: json["phone"],
    city: json["city"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "email": email,
    "name": name,
    "address_1": address1,
    "phone": phone,
    "city": city,
    "id": id,
  };
}
