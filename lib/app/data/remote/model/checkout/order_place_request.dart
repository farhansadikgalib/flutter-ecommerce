import 'dart:convert';

OderPlaceRequest oderPlaceRequestFromJson(String str) => OderPlaceRequest.fromJson(json.decode(str));

String oderPlaceRequestToJson(OderPlaceRequest data) => json.encode(data.toJson());

class OderPlaceRequest {
  List<SaleProduct>? saleProducts;
  int? subTotal;
  int? total;
  int? shippingCost;
  BillingAddress? billingAddress;
  int? paymentMethodId;
  int? customerId;

  OderPlaceRequest({
    this.saleProducts,
    this.subTotal,
    this.total,
    this.shippingCost,
    this.billingAddress,
    this.paymentMethodId,
    this.customerId,
  });

  factory OderPlaceRequest.fromJson(Map<String, dynamic> json) => OderPlaceRequest(
    saleProducts: json["sale_products"] == null ? [] : List<SaleProduct>.from(json["sale_products"]!.map((x) => SaleProduct.fromJson(x))),
    subTotal: json["sub_total"],
    total: json["total"],
    shippingCost: json["shipping_cost"],
    billingAddress: json["billing_address"] == null ? null : BillingAddress.fromJson(json["billing_address"]),
    paymentMethodId: json["payment_method_id"],
    customerId: json["customer_id"],
  );

  Map<String, dynamic> toJson() => {
    "sale_products": saleProducts == null ? [] : List<dynamic>.from(saleProducts!.map((x) => x.toJson())),
    "sub_total": subTotal,
    "total": total,
    "shipping_cost": shippingCost,
    "billing_address": billingAddress?.toJson(),
    "payment_method_id": paymentMethodId,
    "customer_id": customerId,
  };
}

class BillingAddress {
  String? fullName;
  String? mobile;
  String? address;
  String? countryId;
  String? cityId;
  String? notes;

  BillingAddress({
    this.fullName,
    this.mobile,
    this.address,
    this.countryId,
    this.cityId,
    this.notes,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
    fullName: json["full_name"],
    mobile: json["mobile"],
    address: json["address"],
    countryId: json["country_id"],
    cityId: json["city_id"],
    notes: json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "full_name": fullName,
    "mobile": mobile,
    "address": address,
    "country_id": countryId,
    "city_id": cityId,
    "notes": notes,
  };
}

class SaleProduct {
  String? productId;
  String? productName;
  String? price;
  String? quantity;
  String? packSizeId;
  String? packSizeQuantity;
  String? totalQuantity;
  String? total;

  SaleProduct({
    this.productId,
    this.productName,
    this.price,
    this.quantity,
    this.packSizeId,
    this.packSizeQuantity,
    this.totalQuantity,
    this.total,
  });

  factory SaleProduct.fromJson(Map<String, dynamic> json) => SaleProduct(
    productId: json["product_id"],
    productName: json["product_name"],
    price: json["price"],
    quantity: json["quantity"],
    packSizeId: json["pack_size_id"],
    packSizeQuantity: json["pack_size_quantity"],
    totalQuantity: json["total_quantity"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "price": price,
    "quantity": quantity,
    "pack_size_id": packSizeId,
    "pack_size_quantity": packSizeQuantity,
    "total_quantity": totalQuantity,
    "total": total,
  };
}
