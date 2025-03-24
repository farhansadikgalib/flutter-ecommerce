import 'dart:convert';

import 'package:get/get.dart';

HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
  HomeData? data;
  int? status;
  dynamic token;
  String? message;

  HomeResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
    data: json["data"] == null ? null : HomeData.fromJson(json["data"]),
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

class HomeData {
  List<Banner>? banners;
  List<Collection>? collections;
  bool? inStock;
  Slider? slider;
  List<FeaturedCategory>? featuredCategories;
  List<dynamic>? flashSales;
  String? timeZone;
  List<FeaturedBrand>? featuredBrands;

  HomeData({
    this.banners,
    this.collections,
    this.inStock,
    this.slider,
    this.featuredCategories,
    this.flashSales,
    this.timeZone,
    this.featuredBrands,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
    banners: json["banners"] == null ? [] : List<Banner>.from(json["banners"]!.map((x) => Banner.fromJson(x))),
    collections: json["collections"] == null ? [] : List<Collection>.from(json["collections"]!.map((x) => Collection.fromJson(x))),
    inStock: json["in_stock"],
    slider: json["slider"] == null ? null : Slider.fromJson(json["slider"]),
    featuredCategories: json["featured_categories"] == null ? [] : List<FeaturedCategory>.from(json["featured_categories"]!.map((x) => FeaturedCategory.fromJson(x))),
    flashSales: json["flash_sales"] == null ? [] : List<dynamic>.from(json["flash_sales"]!.map((x) => x)),
    timeZone: json["time_zone"],
    featuredBrands: json["featured_brands"] == null ? [] : List<FeaturedBrand>.from(json["featured_brands"]!.map((x) => FeaturedBrand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "banners": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x.toJson())),
    "collections": collections == null ? [] : List<dynamic>.from(collections!.map((x) => x.toJson())),
    "in_stock": inStock,
    "slider": slider?.toJson(),
    "featured_categories": featuredCategories == null ? [] : List<dynamic>.from(featuredCategories!.map((x) => x.toJson())),
    "flash_sales": flashSales == null ? [] : List<dynamic>.from(flashSales!.map((x) => x)),
    "time_zone": timeZone,
    "featured_brands": featuredBrands == null ? [] : List<dynamic>.from(featuredBrands!.map((x) => x.toJson())),
  };
}

class Banner {
  int? id;
  String? image;
  int? type;
  int? sourceType;
  dynamic tags;
  dynamic url;
  String? title;
  int? status;
  int? closable;
  String? createdAt;
  String? updatedAt;
  String? slug;

  Banner({
    this.id,
    this.image,
    this.type,
    this.sourceType,
    this.tags,
    this.url,
    this.title,
    this.status,
    this.closable,
    this.createdAt,
    this.updatedAt,
    this.slug,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json["id"],
    image: json["image"],
    type: json["type"],
    sourceType: json["source_type"],
    tags: json["tags"],
    url: json["url"],
    title: json["title"],
    status: json["status"],
    closable: json["closable"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "type": type,
    "source_type": sourceType,
    "tags": tags,
    "url": url,
    "title": title,
    "status": status,
    "closable": closable,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "slug": slug,
  };
}

class Collection {
  int? id;
  String? title;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? slug;
  List<ProductCollection>? productCollections;

  Collection({
    this.id,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.productCollections,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    id: json["id"],
    title: json["title"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    slug: json["slug"],
    productCollections: json["product_collections"] == null ? [] : List<ProductCollection>.from(json["product_collections"]!.map((x) => ProductCollection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "slug": slug,
    "product_collections": productCollections == null ? [] : List<dynamic>.from(productCollections!.map((x) => x.toJson())),
  };
}

class ProductCollection {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? productCollectionId;
  int? productId;
  String? title;
  dynamic badge;
  String? selling;
  String? offered;
  String? slug;
  String? image;
  int? reviewCount;
  int? rating;
  int? shippingRuleId;
  dynamic price;
  dynamic endTime;
  Product? product;
  bool? addToCart;
  int? quantity;

  ProductCollection({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.productCollectionId,
    this.productId,
    this.title,
    this.badge,
    this.selling,
    this.offered,
    this.slug,
    this.image,
    this.reviewCount,
    this.rating,
    this.shippingRuleId,
    this.price,
    this.endTime,
    this.product,
    this.addToCart,
    this.quantity
  });

  factory ProductCollection.fromJson(Map<String, dynamic> json) => ProductCollection(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    productCollectionId: json["product_collection_id"],
    productId: json["product_id"],
    title: json["title"],
    badge: json["badge"],
    selling: json["selling"],
    offered: json["offered"],
    slug: json["slug"],
    image: json["image"],
    reviewCount: json["review_count"],
    rating: json["rating"],
    shippingRuleId: json["shipping_rule_id"],
    price: json["price"],
    endTime: json["end_time"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    addToCart: true,
    quantity:0
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "product_collection_id": productCollectionId,
    "product_id": productId,
    "title": title,
    "badge": badge,
    "selling": selling,
    "offered": offered,
    "slug": slug,
    "image": image,
    "review_count": reviewCount,
    "rating": rating,
    "shipping_rule_id": shippingRuleId,
    "price": price,
    "end_time": endTime,
    "product": product?.toJson(),
  };
}

class Product {
  int? id;
  String? title;
  String? description;
  String? overview;
  String? unit;
  dynamic badge;
  String? metaTitle;
  String? metaDescription;
  dynamic tags;
  String? selling;
  String? purchased;
  String? offered;
  String? image;
  dynamic video;
  dynamic videoThumb;
  int? status;
  int? categoryId;
  int? subcategoryId;
  dynamic warranty;
  int? refundable;
  int? taxRuleId;
  int? shippingRuleId;
  int? reviewCount;
  int? rating;
  String? bundleDealId;
  int? brandId;
  String? createdAt;
  String? updatedAt;
  int? adminId;
  String? slug;
  int? quantity;

  Product({
    this.id,
    this.title,
    this.description,
    this.overview,
    this.unit,
    this.badge,
    this.metaTitle,
    this.metaDescription,
    this.tags,
    this.selling,
    this.purchased,
    this.offered,
    this.image,
    this.video,
    this.videoThumb,
    this.status,
    this.categoryId,
    this.subcategoryId,
    this.warranty,
    this.refundable,
    this.taxRuleId,
    this.shippingRuleId,
    this.reviewCount,
    this.rating,
    this.bundleDealId,
    this.brandId,
    this.createdAt,
    this.updatedAt,
    this.adminId,
    this.slug,
    this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    overview: json["overview"],
    unit: json["unit"],
    badge: json["badge"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    tags: json["tags"],
    selling: json["selling"],
    purchased: json["purchased"],
    offered: json["offered"],
    image: json["image"],
    video: json["video"],
    videoThumb: json["video_thumb"],
    status: json["status"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    warranty: json["warranty"],
    refundable: json["refundable"],
    taxRuleId: json["tax_rule_id"],
    shippingRuleId: json["shipping_rule_id"],
    reviewCount: json["review_count"],
    rating: json["rating"],
    bundleDealId: json["bundle_deal_id"],
    brandId: json["brand_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    adminId: json["admin_id"],
    slug: json["slug"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "overview": overview,
    "unit": unit,
    "badge": badge,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "tags": tags,
    "selling": selling,
    "purchased": purchased,
    "offered": offered,
    "image": image,
    "video": video,
    "video_thumb": videoThumb,
    "status": status,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "warranty": warranty,
    "refundable": refundable,
    "tax_rule_id": taxRuleId,
    "shipping_rule_id": shippingRuleId,
    "review_count": reviewCount,
    "rating": rating,
    "bundle_deal_id": bundleDealId,
    "brand_id": brandId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "admin_id": adminId,
    "slug": slug,
    "quantity": quantity,
  };
}

class FeaturedBrand {
  int? id;
  String? title;
  String? image;
  int? featured;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? slug;

  FeaturedBrand({
    this.id,
    this.title,
    this.image,
    this.featured,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.slug,
  });

  factory FeaturedBrand.fromJson(Map<String, dynamic> json) => FeaturedBrand(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    featured: json["featured"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "featured": featured,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "slug": slug,
  };
}

class FeaturedCategory {
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

  FeaturedCategory({
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

  factory FeaturedCategory.fromJson(Map<String, dynamic> json) => FeaturedCategory(
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

  Category({
    this.id,
    this.title,
    this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
  };
}

class Slider {
  List<RightTop>? main;
  RightTop? rightTop;
  RightBottom? rightBottom;

  Slider({
    this.main,
    this.rightTop,
    this.rightBottom,
  });

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
    main: json["main"] == null ? [] : List<RightTop>.from(json["main"]!.map((x) => RightTop.fromJson(x))),
    rightTop: json["right_top"] == null ? null : RightTop.fromJson(json["right_top"]),
    rightBottom: json["right_bottom"] == null ? null : RightBottom.fromJson(json["right_bottom"]),
  );

  Map<String, dynamic> toJson() => {
    "main": main == null ? [] : List<dynamic>.from(main!.map((x) => x.toJson())),
    "right_top": rightTop?.toJson(),
    "right_bottom": rightBottom?.toJson(),
  };
}

class RightTop {
  int? id;
  String? image;
  int? type;
  int? sourceType;
  dynamic tags;
  dynamic url;
  String? title;
  String? createdAt;
  String? updatedAt;
  int? status;
  String? slug;

  RightTop({
    this.id,
    this.image,
    this.type,
    this.sourceType,
    this.tags,
    this.url,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.slug,
  });

  factory RightTop.fromJson(Map<String, dynamic> json) => RightTop(
    id: json["id"],
    image: json["image"],
    type: json["type"],
    sourceType: json["source_type"],
    tags: json["tags"],
    url: json["url"],
    title: json["title"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    status: json["status"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "type": type,
    "source_type": sourceType,
    "tags": tags,
    "url": url,
    "title": title,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "status": status,
    "slug": slug,
  };
}

class RightBottom {
  int? id;
  String? image;
  int? type;
  int? sourceType;
  dynamic tags;
  dynamic url;
  dynamic title;
  String? createdAt;
  String? updatedAt;
  int? status;
  String? slug;

  RightBottom({
    this.id,
    this.image,
    this.type,
    this.sourceType,
    this.tags,
    this.url,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.slug,
  });

  factory RightBottom.fromJson(Map<String, dynamic> json) => RightBottom(
    id: json["id"],
    image: json["image"],
    type: json["type"],
    sourceType: json["source_type"],
    tags: json["tags"],
    url: json["url"],
    title: json["title"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    status: json["status"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "type": type,
    "source_type": sourceType,
    "tags": tags,
    "url": url,
    "title": title,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "status": status,
    "slug": slug,
  };
}
