import 'dart:convert';

CartItemsReponse cartItemsReponseFromJson(String str) => CartItemsReponse.fromJson(json.decode(str));

String cartItemsReponseToJson(CartItemsReponse data) => json.encode(data.toJson());

class CartItemsReponse {
  List<CartProducts>? data;
  int? status;
  dynamic token;
  String? message;

  CartItemsReponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory CartItemsReponse.fromJson(Map<String, dynamic> json) => CartItemsReponse(
    data: json["data"] == null ? [] : List<CartProducts>.from(json["data"]!.map((x) => CartProducts.fromJson(x))),
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

class CartProducts {
  int? id;
  int? productId;
  int? userId;
  int? inventoryId;
  int? quantity;
  int? selected;
  dynamic shippingPlaceId;
  int? shippingType;
  UpdatedInventory? updatedInventory;
  FlashProduct? flashProduct;
  dynamic shippingPlace;

  CartProducts({
    this.id,
    this.productId,
    this.userId,
    this.inventoryId,
    this.quantity,
    this.selected,
    this.shippingPlaceId,
    this.shippingType,
    this.updatedInventory,
    this.flashProduct,
    this.shippingPlace,
  });

  factory CartProducts.fromJson(Map<String, dynamic> json) => CartProducts(
    id: json["id"],
    productId: json["product_id"],
    userId: json["user_id"],
    inventoryId: json["inventory_id"],
    quantity: json["quantity"],
    selected: json["selected"],
    shippingPlaceId: json["shipping_place_id"],
    shippingType: json["shipping_type"],
    updatedInventory: json["updated_inventory"] == null ? null : UpdatedInventory.fromJson(json["updated_inventory"]),
    flashProduct: json["flash_product"] == null ? null : FlashProduct.fromJson(json["flash_product"]),
    shippingPlace: json["shipping_place"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "user_id": userId,
    "inventory_id": inventoryId,
    "quantity": quantity,
    "selected": selected,
    "shipping_place_id": shippingPlaceId,
    "shipping_type": shippingType,
    "updated_inventory": updatedInventory?.toJson(),
    "flash_product": flashProduct?.toJson(),
    "shipping_place": shippingPlace,
  };
}

class FlashProduct {
  int? id;
  String? bundleDealId;
  String? title;
  String? slug;
  String? selling;
  String? offered;
  int? taxRuleId;
  String? image;
  int? reviewCount;
  int? rating;
  int? shippingRuleId;
  dynamic price;
  dynamic endTime;
  BundleDeal? bundleDeal;
  TaxRules? taxRules;
  ShippingRule? shippingRule;

  FlashProduct({
    this.id,
    this.bundleDealId,
    this.title,
    this.slug,
    this.selling,
    this.offered,
    this.taxRuleId,
    this.image,
    this.reviewCount,
    this.rating,
    this.shippingRuleId,
    this.price,
    this.endTime,
    this.bundleDeal,
    this.taxRules,
    this.shippingRule,
  });

  factory FlashProduct.fromJson(Map<String, dynamic> json) => FlashProduct(
    id: json["id"],
    bundleDealId: json["bundle_deal_id"],
    title: json["title"],
    slug: json["slug"],
    selling: json["selling"],
    offered: json["offered"],
    taxRuleId: json["tax_rule_id"],
    image: json["image"],
    reviewCount: json["review_count"],
    rating: json["rating"],
    shippingRuleId: json["shipping_rule_id"],
    price: json["price"],
    endTime: json["end_time"],
    bundleDeal: json["bundle_deal"] == null ? null : BundleDeal.fromJson(json["bundle_deal"]),
    taxRules: json["tax_rules"] == null ? null : TaxRules.fromJson(json["tax_rules"]),
    shippingRule: json["shipping_rule"] == null ? null : ShippingRule.fromJson(json["shipping_rule"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bundle_deal_id": bundleDealId,
    "title": title,
    "slug": slug,
    "selling": selling,
    "offered": offered,
    "tax_rule_id": taxRuleId,
    "image": image,
    "review_count": reviewCount,
    "rating": rating,
    "shipping_rule_id": shippingRuleId,
    "price": price,
    "end_time": endTime,
    "bundle_deal": bundleDeal?.toJson(),
    "tax_rules": taxRules?.toJson(),
    "shipping_rule": shippingRule?.toJson(),
  };
}

class BundleDeal {
  int? id;
  int? buy;
  int? free;
  String? title;

  BundleDeal({
    this.id,
    this.buy,
    this.free,
    this.title,
  });

  factory BundleDeal.fromJson(Map<String, dynamic> json) => BundleDeal(
    id: json["id"],
    buy: json["buy"],
    free: json["free"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "buy": buy,
    "free": free,
    "title": title,
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

class TaxRules {
  int? id;
  String? title;
  int? type;
  int? price;
  String? createdAt;
  String? updatedAt;

  TaxRules({
    this.id,
    this.title,
    this.type,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory TaxRules.fromJson(Map<String, dynamic> json) => TaxRules(
    id: json["id"],
    title: json["title"],
    type: json["type"],
    price: json["price"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": type,
    "price": price,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class UpdatedInventory {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? productId;
  int? quantity;
  String? price;
  List<dynamic>? inventoryAttributes;

  UpdatedInventory({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.productId,
    this.quantity,
    this.price,
    this.inventoryAttributes,
  });

  factory UpdatedInventory.fromJson(Map<String, dynamic> json) => UpdatedInventory(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    productId: json["product_id"],
    quantity: json["quantity"],
    price: json["price"],
    inventoryAttributes: json["inventory_attributes"] == null ? [] : List<dynamic>.from(json["inventory_attributes"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "product_id": productId,
    "quantity": quantity,
    "price": price,
    "inventory_attributes": inventoryAttributes == null ? [] : List<dynamic>.from(inventoryAttributes!.map((x) => x)),
  };
}
