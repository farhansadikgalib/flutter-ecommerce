import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  User? user;
  String? token;
  String? message;
  String? status;

  LoginResponse({
    this.user,
    this.token,
    this.message,
    this.status,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
    "message": message,
    "status": status,
  };
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? branchId;
  dynamic userType;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.branchId,
    this.userType,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    branchId: json["branch_id"],
    userType: json["user_type"],
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
  };
}
