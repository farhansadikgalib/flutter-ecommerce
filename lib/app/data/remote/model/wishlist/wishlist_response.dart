import 'dart:convert';

WishlistItemResponse wishlistItemResponseFromJson(String str) => WishlistItemResponse.fromJson(json.decode(str));

String wishlistItemResponseToJson(WishlistItemResponse data) => json.encode(data.toJson());

class WishlistItemResponse {
  Data? data;
  int? status;
  dynamic token;
  String? message;

  WishlistItemResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory WishlistItemResponse.fromJson(Map<String, dynamic> json) => WishlistItemResponse(
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
  int? currentPage;
  List<WishlistItems>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<WishlistItems>.from(json["data"]!.map((x) => WishlistItems.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class WishlistItems {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? productId;
  String? created;
  Product? product;

  WishlistItems({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.productId,
    this.created,
    this.product,
  });

  factory WishlistItems.fromJson(Map<String, dynamic> json) => WishlistItems(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    userId: json["user_id"],
    productId: json["product_id"],
    created: json["created"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user_id": userId,
    "product_id": productId,
    "created": created,
    "product": product?.toJson(),
  };
}

class Product {
  int? id;
  String? title;
  String? slug;
  String? selling;
  String? offered;
  String? image;
  int? reviewCount;
  int? rating;
  int? shippingRuleId;
  dynamic price;
  dynamic endTime;

  Product({
    this.id,
    this.title,
    this.slug,
    this.selling,
    this.offered,
    this.image,
    this.reviewCount,
    this.rating,
    this.shippingRuleId,
    this.price,
    this.endTime,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    selling: json["selling"],
    offered: json["offered"],
    image: json["image"],
    reviewCount: json["review_count"],
    rating: json["rating"],
    shippingRuleId: json["shipping_rule_id"],
    price: json["price"],
    endTime: json["end_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "selling": selling,
    "offered": offered,
    "image": image,
    "review_count": reviewCount,
    "rating": rating,
    "shipping_rule_id": shippingRuleId,
    "price": price,
    "end_time": endTime,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
