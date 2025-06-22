import 'dart:convert';

ForgetPasswordResponse forgetPasswordResponseFromJson(String str) => ForgetPasswordResponse.fromJson(json.decode(str));

String forgetPasswordResponseToJson(ForgetPasswordResponse data) => json.encode(data.toJson());

class ForgetPasswordResponse {
  String? data;
  int? status;
  dynamic token;
  String? message;

  ForgetPasswordResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) => ForgetPasswordResponse(
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
