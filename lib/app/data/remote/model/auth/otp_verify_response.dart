import 'dart:convert';

OtpVerifyResponse otpVerifyResponseFromJson(String str) => OtpVerifyResponse.fromJson(json.decode(str));

String otpVerifyResponseToJson(OtpVerifyResponse data) => json.encode(data.toJson());

class OtpVerifyResponse {
  Data? data;
  int? status;
  dynamic token;
  String? message;

  OtpVerifyResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) => OtpVerifyResponse(
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
  int? id;
  String? name;
  String? email;
  int? code;
  dynamic googleId;
  dynamic facebookId;
  int? verified;
  dynamic defaultAddress;
  dynamic phone;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.name,
    this.email,
    this.code,
    this.googleId,
    this.facebookId,
    this.verified,
    this.defaultAddress,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    code: json["code"],
    googleId: json["google_id"],
    facebookId: json["facebook_id"],
    verified: json["verified"],
    defaultAddress: json["default_address"],
    phone: json["phone"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "code": code,
    "google_id": googleId,
    "facebook_id": facebookId,
    "verified": verified,
    "default_address": defaultAddress,
    "phone": phone,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
