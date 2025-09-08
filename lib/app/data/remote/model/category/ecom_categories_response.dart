import 'dart:convert';

List<EcomCategoriesResponse> ecomCategoriesResponseFromJson(String str) => List<EcomCategoriesResponse>.from(json.decode(str).map((x) => EcomCategoriesResponse.fromJson(x)));

String ecomCategoriesResponseToJson(List<EcomCategoriesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EcomCategoriesResponse {
  int? id;
  String? name;
  dynamic path;
  String? parentId;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<EcomCategoriesResponse>? childrenRecursive;

  EcomCategoriesResponse({
    this.id,
    this.name,
    this.path,
    this.parentId,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.childrenRecursive,
  });

  factory EcomCategoriesResponse.fromJson(Map<String, dynamic> json) => EcomCategoriesResponse(
    id: json["id"],
    name: json["name"],
    path: json["path"],
    parentId: json["parent_id"],
    status: json["status"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    childrenRecursive: json["children_recursive"] == null ? [] : List<EcomCategoriesResponse>.from(json["children_recursive"]!.map((x) => EcomCategoriesResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "path": path,
    "parent_id": parentId,
    "status": status,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "children_recursive": childrenRecursive == null ? [] : List<dynamic>.from(childrenRecursive!.map((x) => x.toJson())),
  };
}
