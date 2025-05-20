import 'dart:convert';

SearchResponse searchResponseFromJson(String str) => SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
  Data? data;
  int? status;
  dynamic token;
  String? message;

  SearchResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
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
  List<SearchProducts>? product;
  List<dynamic>? suggested;
  List<SubCategory>? subCategory;

  Data({
    this.product,
    this.suggested,
    this.subCategory,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    product: json["product"] == null ? [] : List<SearchProducts>.from(json["product"]!.map((x) => SearchProducts.fromJson(x))),
    suggested: json["suggested"] == null ? [] : List<dynamic>.from(json["suggested"]!.map((x) => x)),
    subCategory: json["sub_category"] == null ? [] : List<SubCategory>.from(json["sub_category"]!.map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product": product == null ? [] : List<dynamic>.from(product!.map((x) => x.toJson())),
    "suggested": suggested == null ? [] : List<dynamic>.from(suggested!.map((x) => x)),
    "sub_category": subCategory == null ? [] : List<dynamic>.from(subCategory!.map((x) => x.toJson())),
  };
}


class SearchProducts {
  int? id;
  String? title;
  String? slug;
  String? selling;
  String? offered;
  String? image;
  int? reviewCount;
  int? rating;
  dynamic price;
  dynamic endTime;

  SearchProducts({
    this.id,
    this.title,
    this.slug,
    this.selling,
    this.offered,
    this.image,
    this.reviewCount,
    this.rating,
    this.price,
    this.endTime,
  });

  factory SearchProducts.fromJson(Map<String, dynamic> json) => SearchProducts(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    selling: json["selling"],
    offered: json["offered"],
    image: json["image"],
    reviewCount: json["review_count"],
    rating: json["rating"],
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
    "price": price,
    "end_time": endTime,
  };
}

class SubCategory {
  int? id;
  String? title;
  String? image;
  int? categoryId;
  String? slug;

  SubCategory({
    this.id,
    this.title,
    this.image,
    this.categoryId,
    this.slug,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    categoryId: json["category_id"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "category_id": categoryId,
    "slug": slug,
  };
}
