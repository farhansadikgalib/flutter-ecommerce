import 'dart:convert';

TrackOrderResponse trackOrderResponseFromJson(String str) => TrackOrderResponse.fromJson(json.decode(str));

String trackOrderResponseToJson(TrackOrderResponse data) => json.encode(data.toJson());

class TrackOrderResponse {
  TrackOrderData? data;
  int? status;
  String? token;
  String? message;

  TrackOrderResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory TrackOrderResponse.fromJson(Map<String, dynamic> json) => TrackOrderResponse(
    data: json["data"] == null ? null : TrackOrderData.fromJson(json["data"]),
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

class TrackOrderData {
  int? id;
  int? status;
  String? totalAmount;
  int? orderMethod;
  String? currency;
  int? paymentDone;
  int? cancelled;
  dynamic paymentToken;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? userAddressId;
  dynamic voucherId;
  String? order;
  dynamic userToken;
  List<OrderedProduct>? orderedProducts;

  TrackOrderData({
    this.id,
    this.status,
    this.totalAmount,
    this.orderMethod,
    this.currency,
    this.paymentDone,
    this.cancelled,
    this.paymentToken,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.userAddressId,
    this.voucherId,
    this.order,
    this.userToken,
    this.orderedProducts,
  });

  factory TrackOrderData.fromJson(Map<String, dynamic> json) => TrackOrderData(
    id: json["id"],
    status: json["status"],
    totalAmount: json["total_amount"],
    orderMethod: json["order_method"],
    currency: json["currency"],
    paymentDone: json["payment_done"],
    cancelled: json["cancelled"],
    paymentToken: json["payment_token"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    userId: json["user_id"],
    userAddressId: json["user_address_id"],
    voucherId: json["voucher_id"],
    order: json["order"],
    userToken: json["user_token"],
    orderedProducts: json["ordered_products"] == null ? [] : List<OrderedProduct>.from(json["ordered_products"]!.map((x) => OrderedProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "total_amount": totalAmount,
    "order_method": orderMethod,
    "currency": currency,
    "payment_done": paymentDone,
    "cancelled": cancelled,
    "payment_token": paymentToken,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user_id": userId,
    "user_address_id": userAddressId,
    "voucher_id": voucherId,
    "order": order,
    "user_token": userToken,
    "ordered_products": orderedProducts == null ? [] : List<dynamic>.from(orderedProducts!.map((x) => x.toJson())),
  };
}

class OrderedProduct {
  int? productId;
  int? inventoryId;
  int? quantity;
  int? shippingPlaceId;
  int? shippingType;
  String? selling;
  String? shippingPrice;
  String? taxPrice;
  int? bundleOffer;
  int? orderId;
  ShippingPlace? shippingPlace;
  Product? product;

  OrderedProduct({
    this.productId,
    this.inventoryId,
    this.quantity,
    this.shippingPlaceId,
    this.shippingType,
    this.selling,
    this.shippingPrice,
    this.taxPrice,
    this.bundleOffer,
    this.orderId,
    this.shippingPlace,
    this.product,
  });

  factory OrderedProduct.fromJson(Map<String, dynamic> json) => OrderedProduct(
    productId: json["product_id"],
    inventoryId: json["inventory_id"],
    quantity: json["quantity"],
    shippingPlaceId: json["shipping_place_id"],
    shippingType: json["shipping_type"],
    selling: json["selling"],
    shippingPrice: json["shipping_price"],
    taxPrice: json["tax_price"],
    bundleOffer: json["bundle_offer"],
    orderId: json["order_id"],
    shippingPlace: json["shipping_place"] == null ? null : ShippingPlace.fromJson(json["shipping_place"]),
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "inventory_id": inventoryId,
    "quantity": quantity,
    "shipping_place_id": shippingPlaceId,
    "shipping_type": shippingType,
    "selling": selling,
    "shipping_price": shippingPrice,
    "tax_price": taxPrice,
    "bundle_offer": bundleOffer,
    "order_id": orderId,
    "shipping_place": shippingPlace?.toJson(),
    "product": product?.toJson(),
  };
}

class Product {
  int? id;
  int? categoryId;
  String? title;
  String? slug;
  String? image;
  String? selling;
  String? offered;
  int? shippingRuleId;
  dynamic bundleDealId;
  String? unit;

  Product({
    this.id,
    this.categoryId,
    this.title,
    this.slug,
    this.image,
    this.selling,
    this.offered,
    this.shippingRuleId,
    this.bundleDealId,
    this.unit,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    categoryId: json["category_id"],
    title: json["title"],
    slug: json["slug"],
    image: json["image"],
    selling: json["selling"],
    offered: json["offered"],
    shippingRuleId: json["shipping_rule_id"],
    bundleDealId: json["bundle_deal_id"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "title": title,
    "slug": slug,
    "image": image,
    "selling": selling,
    "offered": offered,
    "shipping_rule_id": shippingRuleId,
    "bundle_deal_id": bundleDealId,
    "unit": unit,
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
