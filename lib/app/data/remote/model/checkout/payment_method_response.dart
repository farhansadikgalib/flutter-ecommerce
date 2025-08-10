import 'dart:convert';

List<PaymentMethodResponse> paymentMethodResponseFromJson(String str) => List<PaymentMethodResponse>.from(json.decode(str).map((x) => PaymentMethodResponse.fromJson(x)));

String paymentMethodResponseToJson(List<PaymentMethodResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentMethodResponse {
  int? id;
  String? name;
  String? slug;
  String? code;
  String? note;
  String? status;
  dynamic createdAt;
  dynamic updatedAt;

  PaymentMethodResponse({
    this.id,
    this.name,
    this.slug,
    this.code,
    this.note,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) => PaymentMethodResponse(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    code: json["code"],
    note: json["note"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "code": code,
    "note": note,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
