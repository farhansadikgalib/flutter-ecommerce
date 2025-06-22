import 'dart:convert';

OderPlaceRequest oderPlaceRequestFromJson(String str) => OderPlaceRequest.fromJson(json.decode(str));

String oderPlaceRequestToJson(OderPlaceRequest data) => json.encode(data.toJson());

class OderPlaceRequest {
  int? orderMethod;
  int? userAddressId;
  List<int>? productId;
  List<int>? quantity;
  List<int>? shippingPlaceId;
  List<int>? shippingType;
  String? guestEmail;
  String? userId;

  OderPlaceRequest({
    this.orderMethod,
    this.userAddressId,
    this.productId,
    this.quantity,
    this.shippingPlaceId,
    this.shippingType,
    this.guestEmail,
    this.userId
  });

  factory OderPlaceRequest.fromJson(Map<String, dynamic> json) => OderPlaceRequest(
    orderMethod: json["order_method"],
    userAddressId: json["user_address_id"],
    productId: json["product_id"] == null ? [] : List<int>.from(json["product_id"]!.map((x) => x)),
    quantity: json["quantity"] == null ? [] : List<int>.from(json["quantity"]!.map((x) => x)),
    shippingPlaceId: json["shipping_place_id"] == null ? [] : List<int>.from(json["shipping_place_id"]!.map((x) => x)),
    shippingType: json["shipping_type"] == null ? [] : List<int>.from(json["shipping_type"]!.map((x) => x)),
    guestEmail: json["guest_email"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "order_method": orderMethod,
    "user_address_id": userAddressId,
    "product_id": productId == null ? [] : List<dynamic>.from(productId!.map((x) => x)),
    "quantity": quantity == null ? [] : List<dynamic>.from(quantity!.map((x) => x)),
    "shipping_place_id": shippingPlaceId == null ? [] : List<dynamic>.from(shippingPlaceId!.map((x) => x)),
    "shipping_type": shippingType == null ? [] : List<dynamic>.from(shippingType!.map((x) => x)),
    "guest_email": guestEmail,
    "user_id": userId,
  };
}
