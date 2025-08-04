import 'dart:convert';

List<CategoryData> categoryResponseFromJson(String str) => List<CategoryData>.from(json.decode(str).map((x) => CategoryData.fromJson(x)));

String categoryResponseToJson(List<CategoryData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryData {
  int? id;
  String? name;
  String? shortOrder;
  String? createdAt;
  dynamic updatedAt;
  String? status;

  CategoryData({
    this.id,
    this.name,
    this.shortOrder,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    id: json["id"],
    name: json["name"],
    shortOrder: json["short_order"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "short_order": shortOrder,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "status": status,
  };
}
