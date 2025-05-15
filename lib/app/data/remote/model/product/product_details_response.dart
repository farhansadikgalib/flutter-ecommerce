import 'dart:convert';

ProductDetailsResponse productDetailsResponseFromJson(String str) => ProductDetailsResponse.fromJson(json.decode(str));

String productDetailsResponseToJson(ProductDetailsResponse data) => json.encode(data.toJson());

class ProductDetailsResponse {
  ProductDetails? data;
  int? status;
  dynamic token;
  String? message;

  ProductDetailsResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) => ProductDetailsResponse(
    data: json["data"] == null ? null : ProductDetails.fromJson(json["data"]),
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

class ProductDetails {
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
  int? warranty;
  int? refundable;
  int? taxRuleId;
  int? shippingRuleId;
  int? reviewCount;
  int? rating;
  dynamic bundleDealId;
  int? brandId;
  String? createdAt;
  String? updatedAt;
  int? adminId;
  List<SubCategory>? slug;
  dynamic price;
  dynamic endTime;
  dynamic wishlisted;
  List<Inventory>? inventory;
  List<dynamic>? vouchers;
  List<ProductImage>? images;
  String? timeZone;
  bool? inStock;
  List<Attribute>? attribute;
  Brand? brand;
  Store? store;
  dynamic bundleDeal;
  List<CurrentCategory>? currentCategories;
  Category? category;
  SubCategory? subCategory;
  List<ProductImage>? productImageNames;
  ShippingRule? shippingRule;

  ProductDetails({
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
    this.price,
    this.endTime,
    this.wishlisted,
    this.inventory,
    this.vouchers,
    this.images,
    this.timeZone,
    this.inStock,
    this.attribute,
    this.brand,
    this.store,
    this.bundleDeal,
    this.currentCategories,
    this.category,
    this.subCategory,
    this.productImageNames,
    this.shippingRule,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
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
    slug: json["slug"] == null ? [] : List<SubCategory>.from(json["slug"]!.map((x) => SubCategory.fromJson(x))),
    price: json["price"],
    endTime: json["end_time"],
    wishlisted: json["wishlisted"],
    inventory: json["inventory"] == null ? [] : List<Inventory>.from(json["inventory"]!.map((x) => Inventory.fromJson(x))),
    vouchers: json["vouchers"] == null ? [] : List<dynamic>.from(json["vouchers"]!.map((x) => x)),
    images: json["images"] == null ? [] : List<ProductImage>.from(json["images"]!.map((x) => ProductImage.fromJson(x))),
    timeZone: json["time_zone"],
    inStock: json["in_stock"],
    attribute: json["attribute"] == null ? [] : List<Attribute>.from(json["attribute"]!.map((x) => Attribute.fromJson(x))),
    brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
    store: json["store"] == null ? null : Store.fromJson(json["store"]),
    bundleDeal: json["bundle_deal"],
    currentCategories: json["current_categories"] == null ? [] : List<CurrentCategory>.from(json["current_categories"]!.map((x) => CurrentCategory.fromJson(x))),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    subCategory: json["sub_category"] == null ? null : SubCategory.fromJson(json["sub_category"]),
    productImageNames: json["product_image_names"] == null ? [] : List<ProductImage>.from(json["product_image_names"]!.map((x) => ProductImage.fromJson(x))),
    shippingRule: json["shipping_rule"] == null ? null : ShippingRule.fromJson(json["shipping_rule"]),
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
    "slug": slug == null ? [] : List<dynamic>.from(slug!.map((x) => x.toJson())),
    "price": price,
    "end_time": endTime,
    "wishlisted": wishlisted,
    "inventory": inventory == null ? [] : List<dynamic>.from(inventory!.map((x) => x.toJson())),
    "vouchers": vouchers == null ? [] : List<dynamic>.from(vouchers!.map((x) => x)),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "time_zone": timeZone,
    "in_stock": inStock,
    "attribute": attribute == null ? [] : List<dynamic>.from(attribute!.map((x) => x.toJson())),
    "brand": brand?.toJson(),
    "store": store?.toJson(),
    "bundle_deal": bundleDeal,
    "current_categories": currentCategories == null ? [] : List<dynamic>.from(currentCategories!.map((x) => x.toJson())),
    "category": category?.toJson(),
    "sub_category": subCategory?.toJson(),
    "product_image_names": productImageNames == null ? [] : List<dynamic>.from(productImageNames!.map((x) => x.toJson())),
    "shipping_rule": shippingRule?.toJson(),
  };
}

class Attribute {
  int? id;
  String? title;
  String? createdAt;
  String? updatedAt;
  List<Value>? values;

  Attribute({
    this.id,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.values,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["id"],
    title: json["title"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    values: json["values"] == null ? [] : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x.toJson())),
  };
}

class Value {
  int? id;
  String? title;
  int? attributeId;
  String? createdAt;
  String? updatedAt;
  int? inventoryId;
  int? attributeValueId;
  int? productId;
  int? quantity;
  String? price;

  Value({
    this.id,
    this.title,
    this.attributeId,
    this.createdAt,
    this.updatedAt,
    this.inventoryId,
    this.attributeValueId,
    this.productId,
    this.quantity,
    this.price,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    id: json["id"],
    title: json["title"],
    attributeId: json["attribute_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    inventoryId: json["inventory_id"],
    attributeValueId: json["attribute_value_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "attribute_id": attributeId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "inventory_id": inventoryId,
    "attribute_value_id": attributeValueId,
    "product_id": productId,
    "quantity": quantity,
    "price": price,
  };
}

class Brand {
  int? id;
  String? title;

  Brand({
    this.id,
    this.title,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
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

class CurrentCategory {
  int? id;
  int? categoryId;
  String? title;
  String? slug;

  CurrentCategory({
    this.id,
    this.categoryId,
    this.title,
    this.slug,
  });

  factory CurrentCategory.fromJson(Map<String, dynamic> json) => CurrentCategory(
    id: json["id"],
    categoryId: json["category_id"],
    title: json["title"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "title": title,
    "slug": slug,
  };
}

class ProductImage {
  int? id;
  String? image;
  int? productId;
  dynamic createdAt;
  dynamic updatedAt;

  ProductImage({
    this.id,
    this.image,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    id: json["id"],
    image: json["image"],
    productId: json["product_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "product_id": productId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Inventory {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? productId;
  int? quantity;
  String? price;
  List<InventoryAttribute>? inventoryAttributes;

  Inventory({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.productId,
    this.quantity,
    this.price,
    this.inventoryAttributes,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    productId: json["product_id"],
    quantity: json["quantity"],
    price: json["price"],
    inventoryAttributes: json["inventory_attributes"] == null ? [] : List<InventoryAttribute>.from(json["inventory_attributes"]!.map((x) => InventoryAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "product_id": productId,
    "quantity": quantity,
    "price": price,
    "inventory_attributes": inventoryAttributes == null ? [] : List<dynamic>.from(inventoryAttributes!.map((x) => x.toJson())),
  };
}

class InventoryAttribute {
  int? inventoryId;
  int? attributeValueId;

  InventoryAttribute({
    this.inventoryId,
    this.attributeValueId,
  });

  factory InventoryAttribute.fromJson(Map<String, dynamic> json) => InventoryAttribute(
    inventoryId: json["inventory_id"],
    attributeValueId: json["attribute_value_id"],
  );

  Map<String, dynamic> toJson() => {
    "inventory_id": inventoryId,
    "attribute_value_id": attributeValueId,
  };
}

class ShippingRule {
  int? id;
  String? title;
  List<ShippingPlace>? shippingPlaces;

  ShippingRule({
    this.id,
    this.title,
    this.shippingPlaces,
  });

  factory ShippingRule.fromJson(Map<String, dynamic> json) => ShippingRule(
    id: json["id"],
    title: json["title"],
    shippingPlaces: json["shipping_places"] == null ? [] : List<ShippingPlace>.from(json["shipping_places"]!.map((x) => ShippingPlace.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "shipping_places": shippingPlaces == null ? [] : List<dynamic>.from(shippingPlaces!.map((x) => x.toJson())),
  };
}

class ShippingPlace {
  int? id;
  String? country;
  String? state;
  String? price;
  int? dayNeeded;
  String? pickupPrice;
  int? pickupPoint;
  int? shippingRuleId;

  ShippingPlace({
    this.id,
    this.country,
    this.state,
    this.price,
    this.dayNeeded,
    this.pickupPrice,
    this.pickupPoint,
    this.shippingRuleId,
  });

  factory ShippingPlace.fromJson(Map<String, dynamic> json) => ShippingPlace(
    id: json["id"],
    country: json["country"],
    state: json["state"],
    price: json["price"],
    dayNeeded: json["day_needed"],
    pickupPrice: json["pickup_price"],
    pickupPoint: json["pickup_point"],
    shippingRuleId: json["shipping_rule_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country": country,
    "state": state,
    "price": price,
    "day_needed": dayNeeded,
    "pickup_price": pickupPrice,
    "pickup_point": pickupPoint,
    "shipping_rule_id": shippingRuleId,
  };
}

class SubCategory {
  int? id;
  String? title;
  String? slug;
  int? categoryId;
  Category? category;

  SubCategory({
    this.id,
    this.title,
    this.slug,
    this.categoryId,
    this.category,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    categoryId: json["category_id"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "category_id": categoryId,
    "category": category?.toJson(),
  };
}

class Store {
  int? id;
  String? image;
  String? name;
  String? slug;
  String? metaTitle;
  String? metaDescription;
  String? createdAt;
  String? updatedAt;

  Store({
    this.id,
    this.image,
    this.name,
    this.slug,
    this.metaTitle,
    this.metaDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    slug: json["slug"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "slug": slug,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
