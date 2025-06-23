import 'dart:convert';

LogoutResponse logoutResponseFromJson(String str) => LogoutResponse.fromJson(json.decode(str));

String logoutResponseToJson(LogoutResponse data) => json.encode(data.toJson());

class LogoutResponse {
  dynamic data;
  int? status;
  dynamic token;
  String? message;

  LogoutResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
    data: json["data"],
    status: json["status"],
    token: json["token"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "status": status,
    "token": token,
    "message": message,
  };
}
