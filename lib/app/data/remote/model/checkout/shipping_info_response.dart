import 'dart:convert';

ShippingInfoResponse shippingResponseFromJson(String str) => ShippingInfoResponse.fromJson(json.decode(str));

String shippingResponseToJson(ShippingInfoResponse data) => json.encode(data.toJson());

class ShippingInfoResponse {
  List<ShippingInfo>? data;
  int? status;
  dynamic token;
  String? message;

  ShippingInfoResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory ShippingInfoResponse.fromJson(Map<String, dynamic> json) => ShippingInfoResponse(
    data: json["data"] == null ? [] : List<ShippingInfo>.from(json["data"]!.map((x) => ShippingInfo.fromJson(x))),
    status: json["status"],
    token: json["token"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
    "token": token,
    "message": message,
  };
}

class ShippingInfo {
  int? id;
  String? title;
  String? price;

  ShippingInfo({
    this.id,
    this.title,
    this.price,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) => ShippingInfo(
    id: json["id"],
    title: json["title"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
  };
}
