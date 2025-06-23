import 'dart:convert';

WishlistActionResponse wishlistActionResponseFromJson(String str) => WishlistActionResponse.fromJson(json.decode(str));

String wishlistActionResponseToJson(WishlistActionResponse data) => json.encode(data.toJson());

class WishlistActionResponse {
  Data? data;
  int? status;
  dynamic token;
  String? message;

  WishlistActionResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory WishlistActionResponse.fromJson(Map<String, dynamic> json) => WishlistActionResponse(
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
  String? productId;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({
    this.productId,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    productId: json["product_id"],
    userId: json["user_id"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "user_id": userId,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}
