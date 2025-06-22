import 'dart:convert';

UpdatePasswordResponse updatePasswordResponseFromJson(String str) => UpdatePasswordResponse.fromJson(json.decode(str));

String updatePasswordResponseToJson(UpdatePasswordResponse data) => json.encode(data.toJson());

class UpdatePasswordResponse {
  int? status;
  dynamic token;
  String? message;

  UpdatePasswordResponse({
    this.status,
    this.token,
    this.message,
  });

  factory UpdatePasswordResponse.fromJson(Map<String, dynamic> json) => UpdatePasswordResponse(
    status: json["status"],
    token: json["token"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "token": token,
    "message": message,
  };
}

class Data {
  List<String>? form;

  Data({
    this.form,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    form: json["form"] == null ? [] : List<String>.from(json["form"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "form": form == null ? [] : List<dynamic>.from(form!.map((x) => x)),
  };
}
