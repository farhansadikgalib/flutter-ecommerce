import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  Data? data;
  int? status;
  dynamic token;
  String? message;

  LoginResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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
  String? expiresIn;
  String? token;
  Admin? admin;

  Data({
    this.expiresIn,
    this.token,
    this.admin,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    expiresIn: json["expires_in"],
    token: json["token"],
    admin: json["admin"] == null ? null : Admin.fromJson(json["admin"]),
  );

  Map<String, dynamic> toJson() => {
    "expires_in": expiresIn,
    "token": token,
    "admin": admin?.toJson(),
  };
}

class Admin {
  int? id;
  String? name;
  String? username;
  String? email;
  dynamic code;
  dynamic commission;
  String? createdAt;
  String? updatedAt;

  Admin({
    this.id,
    this.name,
    this.username,
    this.email,
    this.code,
    this.commission,
    this.createdAt,
    this.updatedAt,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    code: json["code"],
    commission: json["commission"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "email": email,
    "code": code,
    "commission": commission,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
