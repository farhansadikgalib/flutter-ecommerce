import 'dart:convert';

OrderPlaceResponse orderPlaceResponseFromJson(String str) => OrderPlaceResponse.fromJson(json.decode(str));

String orderPlaceResponseToJson(OrderPlaceResponse data) => json.encode(data.toJson());

class OrderPlaceResponse {
  String? message;
  Sale? sale;
  String? status;

  OrderPlaceResponse({
    this.message,
    this.sale,
    this.status,
  });

  factory OrderPlaceResponse.fromJson(Map<String, dynamic> json) => OrderPlaceResponse(
    message: json["message"],
    sale: json["sale"] == null ? null : Sale.fromJson(json["sale"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "sale": sale?.toJson(),
    "status": status,
  };
}

class Sale {
  String? saleCode;
  DateTime? saleDate;
  int? customerId;
  int? subTotal;
  int? total;
  int? shippingCost;
  int? paymentMethodId;
  int? createdBy;
  String? updatedAt;
  String? createdAt;
  int? id;

  Sale({
    this.saleCode,
    this.saleDate,
    this.customerId,
    this.subTotal,
    this.total,
    this.shippingCost,
    this.paymentMethodId,
    this.createdBy,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
    saleCode: json["sale_code"],
    saleDate: json["sale_date"] == null ? null : DateTime.parse(json["sale_date"]),
    customerId: json["customer_id"],
    subTotal: json["sub_total"],
    total: json["total"],
    shippingCost: json["shipping_cost"],
    paymentMethodId: json["payment_method_id"],
    createdBy: json["created_by"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "sale_code": saleCode,
    "sale_date": "${saleDate!.year.toString().padLeft(4, '0')}-${saleDate!.month.toString().padLeft(2, '0')}-${saleDate!.day.toString().padLeft(2, '0')}",
    "customer_id": customerId,
    "sub_total": subTotal,
    "total": total,
    "shipping_cost": shippingCost,
    "payment_method_id": paymentMethodId,
    "created_by": createdBy,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}
