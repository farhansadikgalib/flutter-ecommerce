import 'dart:convert';

TaskSubmitResponse taskSubmitResponseFromJson(String str) => TaskSubmitResponse.fromJson(json.decode(str));

String taskSubmitResponseToJson(TaskSubmitResponse data) => json.encode(data.toJson());

class TaskSubmitResponse {
  String? message;
  int? status;

  TaskSubmitResponse({
    this.message,
    this.status,
  });

  factory TaskSubmitResponse.fromJson(Map<String, dynamic> json) => TaskSubmitResponse(
    message: json["message"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "Status": status,
  };
}
