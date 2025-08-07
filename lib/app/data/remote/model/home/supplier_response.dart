import 'dart:convert';

List<SupplierResponse> supplierResponseFromJson(String str) => List<SupplierResponse>.from(json.decode(str).map((x) => SupplierResponse.fromJson(x)));

String supplierResponseToJson(List<SupplierResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupplierResponse {
  int? id;
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? city;
  String? stateOrProvince;
  String? zip;
  String? country;
  String? comments;
  String? contact;
  String? email;
  String? companyName;
  String? accountNo;
  String? imagePath;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? storeAccountBalance;
  String? payAmount;
  dynamic deletedAt;
  String? deletedBy;

  SupplierResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.stateOrProvince,
    this.zip,
    this.country,
    this.comments,
    this.contact,
    this.email,
    this.companyName,
    this.accountNo,
    this.imagePath,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.storeAccountBalance,
    this.payAmount,
    this.deletedAt,
    this.deletedBy,
  });

  factory SupplierResponse.fromJson(Map<String, dynamic> json) => SupplierResponse(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    address1: json["address_1"],
    address2: json["address_2"],
    city: json["city"],
    stateOrProvince: json["state_or_province"],
    zip: json["zip"],
    country: json["country"],
    comments: json["comments"],
    contact: json["contact"],
    email: json["email"],
    companyName: json["company_name"],
    accountNo: json["account_no"],
    imagePath: json["image_path"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    type: json["type"],
    storeAccountBalance: json["store_account_balance"],
    payAmount: json["pay_amount"],
    deletedAt: json["deleted_at"],
    deletedBy: json["deleted_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "state_or_province": stateOrProvince,
    "zip": zip,
    "country": country,
    "comments": comments,
    "contact": contact,
    "email": email,
    "company_name": companyName,
    "account_no": accountNo,
    "image_path": imagePath,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "type": type,
    "store_account_balance": storeAccountBalance,
    "pay_amount": payAmount,
    "deleted_at": deletedAt,
    "deleted_by": deletedBy,
  };
}
