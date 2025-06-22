import 'dart:convert';

OrderResponse orderResponseFromJson(String str) => OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
  Data? data;
  int? status;
  dynamic token;
  String? message;

  OrderResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
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
  List<AllOrdersData>? data;
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
    data: json["data"] == null ? [] : List<AllOrdersData>.from(json["data"]!.map((x) => AllOrdersData.fromJson(x))),
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

class AllOrdersData {
  int? id;
  int? status;
  String? totalAmount;
  String? orderMethod;
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
  String? created;
  List<OrderedProduct>? orderedProducts;

  AllOrdersData({
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
    this.created,
    this.orderedProducts,
  });

  factory AllOrdersData.fromJson(Map<String, dynamic> json) => AllOrdersData(
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
    created: json["created"],
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
    "created": created,
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
