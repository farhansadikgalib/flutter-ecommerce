import 'dart:convert';

CategoryWiseProductsResponse categoryWiseProductsResponseFromJson(String str) => CategoryWiseProductsResponse.fromJson(json.decode(str));

String categoryWiseProductsResponseToJson(CategoryWiseProductsResponse data) => json.encode(data.toJson());

class CategoryWiseProductsResponse {
  Data? data;
  int? status;
  dynamic token;
  String? message;

  CategoryWiseProductsResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory CategoryWiseProductsResponse.fromJson(Map<String, dynamic> json) => CategoryWiseProductsResponse(
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
  Result? result;
  SubCategory? subCategory;
  dynamic category;
  List<Brand>? shipping;
  List<Brand>? brands;
  List<Brand>? collections;

  Data({
    this.result,
    this.subCategory,
    this.category,
    this.shipping,
    this.brands,
    this.collections,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    subCategory: json["sub_category"] == null ? null : SubCategory.fromJson(json["sub_category"]),
    category: json["category"],
    shipping: json["shipping"] == null ? [] : List<Brand>.from(json["shipping"]!.map((x) => Brand.fromJson(x))),
    brands: json["brands"] == null ? [] : List<Brand>.from(json["brands"]!.map((x) => Brand.fromJson(x))),
    collections: json["collections"] == null ? [] : List<Brand>.from(json["collections"]!.map((x) => Brand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result?.toJson(),
    "sub_category": subCategory?.toJson(),
    "category": category,
    "shipping": shipping == null ? [] : List<dynamic>.from(shipping!.map((x) => x.toJson())),
    "brands": brands == null ? [] : List<dynamic>.from(brands!.map((x) => x.toJson())),
    "collections": collections == null ? [] : List<dynamic>.from(collections!.map((x) => x.toJson())),
  };
}

class Brand {
  int? id;
  String? title;
  bool? isSelected;

  Brand({
    this.id,
    this.title,
    this.isSelected
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    title: json["title"],
    isSelected : false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}

class Result {
  int? currentPage;
  List<CategoryProducts>? data;
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

  Result({
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<CategoryProducts>.from(json["data"]!.map((x) => CategoryProducts.fromJson(x))),
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

class CategoryProducts {
  int? id;
  String? title;
  String? slug;
  dynamic badge;
  String? selling;
  String? offered;
  String? image;
  int? reviewCount;
  int? rating;
  String? price;
  dynamic endTime;
  int? quantity;
  bool? addToCart;

  CategoryProducts({
    this.id,
    this.title,
    this.slug,
    this.badge,
    this.selling,
    this.offered,
    this.image,
    this.reviewCount,
    this.rating,
    this.price,
    this.endTime,
    this.quantity,
    this.addToCart
  });

  factory CategoryProducts.fromJson(Map<String, dynamic> json) => CategoryProducts(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    badge: json["badge"],
    selling: json["selling"],
    offered: json["offered"],
    image: json["image"],
    reviewCount: json["review_count"],
    rating: json["rating"],
    price: json["price"],
    endTime: json["end_time"],
    quantity: json["quantity"],
    addToCart: true,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "badge": badge,
    "selling": selling,
    "offered": offered,
    "image": image,
    "review_count": reviewCount,
    "rating": rating,
    "price": price,
    "end_time": endTime,
    "quantity": quantity,
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

class SubCategory {
  int? id;
  String? title;
  String? metaTitle;
  String? metaDescription;
  String? image;
  int? status;
  int? featured;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  String? slug;
  Category? category;

  SubCategory({
    this.id,
    this.title,
    this.metaTitle,
    this.metaDescription,
    this.image,
    this.status,
    this.featured,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.category,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    title: json["title"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    image: json["image"],
    status: json["status"],
    featured: json["featured"],
    categoryId: json["category_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    slug: json["slug"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "image": image,
    "status": status,
    "featured": featured,
    "category_id": categoryId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "slug": slug,
    "category": category?.toJson(),
  };
}

class Category {
  int? id;
  String? title;
  String? slug;
  bool? isSelected;

  Category({
    this.id,
    this.title,
    this.slug,
    this.isSelected
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    isSelected: false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
  };
}
