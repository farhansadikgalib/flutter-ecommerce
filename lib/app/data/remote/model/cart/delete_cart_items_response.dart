// To parse this JSON data, do
//
//     final deleteCartResponse = deleteCartResponseFromJson(jsonString);

import 'dart:convert';

DeleteCartResponse deleteCartResponseFromJson(String str) => DeleteCartResponse.fromJson(json.decode(str));

String deleteCartResponseToJson(DeleteCartResponse data) => json.encode(data.toJson());

class DeleteCartResponse {
  Data? data;
  int? status;
  dynamic token;
  String? message;

  DeleteCartResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory DeleteCartResponse.fromJson(Map<String, dynamic> json) => DeleteCartResponse(
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
  int? id;
  String? createdAt;
  String? updatedAt;
  int? productId;
  int? inventoryId;
  int? userId;
  int? quantity;
  dynamic shippingPlaceId;
  int? shippingType;
  int? selected;
  dynamic userToken;

  Data({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.productId,
    this.inventoryId,
    this.userId,
    this.quantity,
    this.shippingPlaceId,
    this.shippingType,
    this.selected,
    this.userToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    productId: json["product_id"],
    inventoryId: json["inventory_id"],
    userId: json["user_id"],
    quantity: json["quantity"],
    shippingPlaceId: json["shipping_place_id"],
    shippingType: json["shipping_type"],
    selected: json["selected"],
    userToken: json["user_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "product_id": productId,
    "inventory_id": inventoryId,
    "user_id": userId,
    "quantity": quantity,
    "shipping_place_id": shippingPlaceId,
    "shipping_type": shippingType,
    "selected": selected,
    "user_token": userToken,
  };
}
