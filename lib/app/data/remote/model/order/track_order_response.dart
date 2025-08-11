// To parse this JSON data, do
//
//     final trackOrderData = trackOrderDataFromJson(jsonString);

import 'dart:convert';

TrackOrderData trackOrderDataFromJson(String str) => TrackOrderData.fromJson(json.decode(str));

String trackOrderDataToJson(TrackOrderData data) => json.encode(data.toJson());

class TrackOrderData {
  int? id;
  String? customerId;
  String? paymentMethodId;
  String? saleDate;
  dynamic itemTiers;
  dynamic note;
  String? subTotal;
  String? total;
  dynamic paidAmount;
  dynamic amountDue;
  String? commentOnReceipt;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  dynamic branchId;
  String? saleCode;
  dynamic discountEntireSale;
  dynamic discountAllItemByPercent;
  dynamic discountReason;
  dynamic itemTire;
  String? verifyStatus;
  dynamic verifiedBy;
  dynamic verifiedAt;
  dynamic suspendedBy;
  dynamic customerName;
  String? suspendRequest;
  dynamic suspendRequestBy;
  dynamic shippingCost;
  List<SaleProduct>? saleProducts;
  PaymentMethod? paymentMethod;
  SoldUser? soldUser;
  dynamic customer;
  BillingAddress? billingAddress;

  TrackOrderData({
    this.id,
    this.customerId,
    this.paymentMethodId,
    this.saleDate,
    this.itemTiers,
    this.note,
    this.subTotal,
    this.total,
    this.paidAmount,
    this.amountDue,
    this.commentOnReceipt,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.branchId,
    this.saleCode,
    this.discountEntireSale,
    this.discountAllItemByPercent,
    this.discountReason,
    this.itemTire,
    this.verifyStatus,
    this.verifiedBy,
    this.verifiedAt,
    this.suspendedBy,
    this.customerName,
    this.suspendRequest,
    this.suspendRequestBy,
    this.shippingCost,
    this.saleProducts,
    this.paymentMethod,
    this.soldUser,
    this.customer,
    this.billingAddress,
  });

  factory TrackOrderData.fromJson(Map<String, dynamic> json) => TrackOrderData(
    id: json["id"],
    customerId: json["customer_id"],
    paymentMethodId: json["payment_method_id"],
    saleDate: json["sale_date"],
    itemTiers: json["item_tiers"],
    note: json["note"],
    subTotal: json["sub_total"],
    total: json["total"],
    paidAmount: json["paid_amount"],
    amountDue: json["amount_due"],
    commentOnReceipt: json["comment_on_receipt"],
    createdBy: json["created_by"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    branchId: json["branch_id"],
    saleCode: json["sale_code"],
    discountEntireSale: json["discount_entire_sale"],
    discountAllItemByPercent: json["discount_all_item_by_percent"],
    discountReason: json["discount_reason"],
    itemTire: json["item_tire"],
    verifyStatus: json["verify_status"],
    verifiedBy: json["verified_by"],
    verifiedAt: json["verified_at"],
    suspendedBy: json["suspended_by"],
    customerName: json["customer_name"],
    suspendRequest: json["suspend_request"],
    suspendRequestBy: json["suspend_request_by"],
    shippingCost: json["shipping_cost"],
    saleProducts: json["sale_products"] == null ? [] : List<SaleProduct>.from(json["sale_products"]!.map((x) => SaleProduct.fromJson(x))),
    paymentMethod: json["payment_method"] == null ? null : PaymentMethod.fromJson(json["payment_method"]),
    soldUser: json["sold_user"] == null ? null : SoldUser.fromJson(json["sold_user"]),
    customer: json["customer"],
    billingAddress: json["billing_address"] == null ? null : BillingAddress.fromJson(json["billing_address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "payment_method_id": paymentMethodId,
    "sale_date": saleDate,
    "item_tiers": itemTiers,
    "note": note,
    "sub_total": subTotal,
    "total": total,
    "paid_amount": paidAmount,
    "amount_due": amountDue,
    "comment_on_receipt": commentOnReceipt,
    "created_by": createdBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "branch_id": branchId,
    "sale_code": saleCode,
    "discount_entire_sale": discountEntireSale,
    "discount_all_item_by_percent": discountAllItemByPercent,
    "discount_reason": discountReason,
    "item_tire": itemTire,
    "verify_status": verifyStatus,
    "verified_by": verifiedBy,
    "verified_at": verifiedAt,
    "suspended_by": suspendedBy,
    "customer_name": customerName,
    "suspend_request": suspendRequest,
    "suspend_request_by": suspendRequestBy,
    "shipping_cost": shippingCost,
    "sale_products": saleProducts == null ? [] : List<dynamic>.from(saleProducts!.map((x) => x.toJson())),
    "payment_method": paymentMethod?.toJson(),
    "sold_user": soldUser?.toJson(),
    "customer": customer,
    "billing_address": billingAddress?.toJson(),
  };
}

class BillingAddress {
  int? id;
  String? saleId;
  String? fullName;
  String? mobile;
  String? address;
  dynamic countryId;
  String? cityId;
  dynamic notes;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  BillingAddress({
    this.id,
    this.saleId,
    this.fullName,
    this.mobile,
    this.address,
    this.countryId,
    this.cityId,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
    id: json["id"],
    saleId: json["sale_id"],
    fullName: json["full_name"],
    mobile: json["mobile"],
    address: json["address"],
    countryId: json["country_id"],
    cityId: json["city_id"],
    notes: json["notes"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sale_id": saleId,
    "full_name": fullName,
    "mobile": mobile,
    "address": address,
    "country_id": countryId,
    "city_id": cityId,
    "notes": notes,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}

class PaymentMethod {
  int? id;
  String? name;
  String? slug;
  String? code;
  String? note;
  String? status;
  dynamic createdAt;
  dynamic updatedAt;

  PaymentMethod({
    this.id,
    this.name,
    this.slug,
    this.code,
    this.note,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
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

class SaleProduct {
  int? id;
  String? saleId;
  String? productId;
  String? productName;
  String? quantity;
  String? price;
  dynamic discountPercent;
  String? total;
  dynamic batchNo;
  dynamic purchaseId;
  dynamic purchaseProductId;
  String? createdAt;
  String? updatedAt;
  dynamic discountAmount;
  String? packSizeId;
  String? packSizeQuantity;
  String? totalQuantity;

  SaleProduct({
    this.id,
    this.saleId,
    this.productId,
    this.productName,
    this.quantity,
    this.price,
    this.discountPercent,
    this.total,
    this.batchNo,
    this.purchaseId,
    this.purchaseProductId,
    this.createdAt,
    this.updatedAt,
    this.discountAmount,
    this.packSizeId,
    this.packSizeQuantity,
    this.totalQuantity,
  });

  factory SaleProduct.fromJson(Map<String, dynamic> json) => SaleProduct(
    id: json["id"],
    saleId: json["sale_id"],
    productId: json["product_id"],
    productName: json["product_name"],
    quantity: json["quantity"],
    price: json["price"],
    discountPercent: json["discount_percent"],
    total: json["total"],
    batchNo: json["batch_no"],
    purchaseId: json["purchase_id"],
    purchaseProductId: json["purchase_product_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    discountAmount: json["discount_amount"],
    packSizeId: json["pack_size_id"],
    packSizeQuantity: json["pack_size_quantity"],
    totalQuantity: json["total_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sale_id": saleId,
    "product_id": productId,
    "product_name": productName,
    "quantity": quantity,
    "price": price,
    "discount_percent": discountPercent,
    "total": total,
    "batch_no": batchNo,
    "purchase_id": purchaseId,
    "purchase_product_id": purchaseProductId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "discount_amount": discountAmount,
    "pack_size_id": packSizeId,
    "pack_size_quantity": packSizeQuantity,
    "total_quantity": totalQuantity,
  };
}

class SoldUser {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? branchId;
  String? userType;
  dynamic username;
  dynamic phone;
  dynamic dob;
  dynamic gender;
  dynamic address;

  SoldUser({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.branchId,
    this.userType,
    this.username,
    this.phone,
    this.dob,
    this.gender,
    this.address,
  });

  factory SoldUser.fromJson(Map<String, dynamic> json) => SoldUser(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    branchId: json["branch_id"],
    userType: json["user_type"],
    username: json["username"],
    phone: json["phone"],
    dob: json["dob"],
    gender: json["gender"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "branch_id": branchId,
    "user_type": userType,
    "username": username,
    "phone": phone,
    "dob": dob,
    "gender": gender,
    "address": address,
  };
}
