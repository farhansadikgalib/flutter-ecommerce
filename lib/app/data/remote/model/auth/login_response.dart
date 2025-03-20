
import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  int? id;
  String? staffid;
  String? name;
  String? email;
  String? role;
  String? designation;
  String? token;
  String? message;
  int? status;

  LoginResponse({
    this.id,
    this.staffid,
    this.name,
    this.email,
    this.role,
    this.designation,
    this.token,
    this.message,
    this.status,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    id: json["id"],
    staffid: json["staffid"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    designation: json["designation"],
    token: json["token"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "staffid": staffid,
    "name": name,
    "email": email,
    "role": role,
    "designation": designation,
    "token": token,
    "message": message,
    "status": status,
  };
}
