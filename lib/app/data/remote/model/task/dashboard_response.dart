import 'dart:convert';

DashboardResponse dashboardResponseFromJson(String str) => DashboardResponse.fromJson(json.decode(str));

String dashboardResponseToJson(DashboardResponse data) => json.encode(data.toJson());

class DashboardResponse {
  List<DashboardData>? data;
  String? message;
  int? status;

  DashboardResponse({
    this.data,
    this.message,
    this.status,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) => DashboardResponse(
    data: json["Data"] == null ? [] : List<DashboardData>.from(json["Data"]!.map((x) => DashboardData.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class DashboardData {
  String? statusName;
  String? statusCount;

  DashboardData({
    this.statusName,
    this.statusCount,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
    statusName: json["StatusName"],
    statusCount: json["StatusCount"],
  );

  Map<String, dynamic> toJson() => {
    "StatusName": statusName,
    "StatusCount": statusCount,
  };
}
