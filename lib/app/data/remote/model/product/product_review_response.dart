import 'dart:convert';

ProductReviewResponse productReviewResponseFromJson(String str) => ProductReviewResponse.fromJson(json.decode(str));

String productReviewResponseToJson(ProductReviewResponse data) => json.encode(data.toJson());

class ProductReviewResponse {
  ProductReview? data;
  int? status;
  dynamic token;
  String? message;

  ProductReviewResponse({
    this.data,
    this.status,
    this.token,
    this.message,
  });

  factory ProductReviewResponse.fromJson(Map<String, dynamic> json) => ProductReviewResponse(
    data: json["data"] == null ? null : ProductReview.fromJson(json["data"]),
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

class ProductReview {
  All? all;

  ProductReview({
    this.all,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) => ProductReview(
    all: json["all"] == null ? null : All.fromJson(json["all"]),
  );

  Map<String, dynamic> toJson() => {
    "all": all?.toJson(),
  };
}

class All {
  int? currentPage;
  List<dynamic>? data;
  String? firstPageUrl;
  dynamic from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  dynamic to;
  int? total;

  All({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory All.fromJson(Map<String, dynamic> json) => All(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
