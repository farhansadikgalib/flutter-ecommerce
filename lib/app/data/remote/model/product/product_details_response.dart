import 'dart:convert';

ProductDetailsResponse productDetailsResponseFromJson(String str) => ProductDetailsResponse.fromJson(json.decode(str));

String productDetailsResponseToJson(ProductDetailsResponse data) => json.encode(data.toJson());

class ProductDetailsResponse {
  Product? product;
  List<Supplier>? suppliers;
  List<Category>? categories;
  List<dynamic>? generics;
  List<dynamic>? manufacturers;

  ProductDetailsResponse({
    this.product,
    this.suppliers,
    this.categories,
    this.generics,
    this.manufacturers,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) => ProductDetailsResponse(
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    suppliers: json["suppliers"] == null ? [] : List<Supplier>.from(json["suppliers"]!.map((x) => Supplier.fromJson(x))),
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    generics: json["generics"] == null ? [] : List<dynamic>.from(json["generics"]!.map((x) => x)),
    manufacturers: json["manufacturers"] == null ? [] : List<dynamic>.from(json["manufacturers"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "suppliers": suppliers == null ? [] : List<dynamic>.from(suppliers!.map((x) => x.toJson())),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "generics": generics == null ? [] : List<dynamic>.from(generics!.map((x) => x)),
    "manufacturers": manufacturers == null ? [] : List<dynamic>.from(manufacturers!.map((x) => x)),
  };
}

class Category {
  int? id;
  String? name;
  String? shortOrder;
  String? createdAt;
  dynamic updatedAt;
  String? status;

  Category({
    this.id,
    this.name,
    this.shortOrder,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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

class Product {
  int? id;
  String? categoryId;
  String? supplierId;
  String? name;
  String? additionalItemNumbers;
  String? productId;
  List<dynamic>? tags;
  String? manufacturerId;
  String? status;
  String? createdAt;
  dynamic updatedAt;
  dynamic upcEanIsbn;
  dynamic description;
  String? batchNo;
  dynamic createdBy;
  dynamic updatedBy;
  String? genericId;
  String? isEcommerceItem;
  String? isBarcoded;
  dynamic deletedAt;
  Category? category;
  Supplier? supplier;
  PackSize? packSize;
  List<dynamic>? productVariationAttributes;
  List<dynamic>? productVariations;
  ProductPrices? productPrices;
  dynamic productInventories;
  dynamic productLocations;
  List<dynamic>? productImages;
  dynamic generic;
  dynamic manufacturer;

  Product({
    this.id,
    this.categoryId,
    this.supplierId,
    this.name,
    this.additionalItemNumbers,
    this.productId,
    this.tags,
    this.manufacturerId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.upcEanIsbn,
    this.description,
    this.batchNo,
    this.createdBy,
    this.updatedBy,
    this.genericId,
    this.isEcommerceItem,
    this.isBarcoded,
    this.deletedAt,
    this.category,
    this.supplier,
    this.packSize,
    this.productVariationAttributes,
    this.productVariations,
    this.productPrices,
    this.productInventories,
    this.productLocations,
    this.productImages,
    this.generic,
    this.manufacturer,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    categoryId: json["category_id"],
    supplierId: json["supplier_id"],
    name: json["name"],
    additionalItemNumbers: json["additional_item_numbers"],
    productId: json["product_id"],
    tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
    manufacturerId: json["manufacturer_id"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    upcEanIsbn: json["upc_ean_isbn"],
    description: json["description"],
    batchNo: json["batch_no"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    genericId: json["generic_id"],
    isEcommerceItem: json["is_ecommerce_item"],
    isBarcoded: json["is_barcoded"],
    deletedAt: json["deleted_at"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    supplier: json["supplier"] == null ? null : Supplier.fromJson(json["supplier"]),
    packSize: json["pack_size"] == null ? null : PackSize.fromJson(json["pack_size"]),
    productVariationAttributes: json["product_variation_attributes"] == null ? [] : List<dynamic>.from(json["product_variation_attributes"]!.map((x) => x)),
    productVariations: json["product_variations"] == null ? [] : List<dynamic>.from(json["product_variations"]!.map((x) => x)),
    productPrices: json["product_prices"] == null ? null : ProductPrices.fromJson(json["product_prices"]),
    productInventories: json["product_inventories"],
    productLocations: json["product_locations"],
    productImages: json["product_images"] == null ? [] : List<dynamic>.from(json["product_images"]!.map((x) => x)),
    generic: json["generic"],
    manufacturer: json["manufacturer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "supplier_id": supplierId,
    "name": name,
    "additional_item_numbers": additionalItemNumbers,
    "product_id": productId,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "manufacturer_id": manufacturerId,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "upc_ean_isbn": upcEanIsbn,
    "description": description,
    "batch_no": batchNo,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "generic_id": genericId,
    "is_ecommerce_item": isEcommerceItem,
    "is_barcoded": isBarcoded,
    "deleted_at": deletedAt,
    "category": category?.toJson(),
    "supplier": supplier?.toJson(),
    "pack_size": packSize?.toJson(),
    "product_variation_attributes": productVariationAttributes == null ? [] : List<dynamic>.from(productVariationAttributes!.map((x) => x)),
    "product_variations": productVariations == null ? [] : List<dynamic>.from(productVariations!.map((x) => x)),
    "product_prices": productPrices?.toJson(),
    "product_inventories": productInventories,
    "product_locations": productLocations,
    "product_images": productImages == null ? [] : List<dynamic>.from(productImages!.map((x) => x)),
    "generic": generic,
    "manufacturer": manufacturer,
  };
}

class PackSize {
  int? id;
  String? productId;
  String? name;
  String? quantity;
  String? tp;
  String? vatPercent;
  String? vat;
  String? sellingPrice;
  String? defaultUnit;
  String? createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  PackSize({
    this.id,
    this.productId,
    this.name,
    this.quantity,
    this.tp,
    this.vatPercent,
    this.vat,
    this.sellingPrice,
    this.defaultUnit,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory PackSize.fromJson(Map<String, dynamic> json) => PackSize(
    id: json["id"],
    productId: json["product_id"],
    name: json["name"],
    quantity: json["quantity"],
    tp: json["tp"],
    vatPercent: json["vat_percent"],
    vat: json["vat"],
    sellingPrice: json["selling_price"],
    defaultUnit: json["default_unit"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "name": name,
    "quantity": quantity,
    "tp": tp,
    "vat_percent": vatPercent,
    "vat": vat,
    "selling_price": sellingPrice,
    "default_unit": defaultUnit,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}

class ProductPrices {
  int? id;
  String? productId;
  String? costPriceWithoutTax;
  String? sellingPrice;
  String? tradePrice;
  String? vat;
  String? wholesale;
  String? wholesaleType;
  dynamic promoPrice;
  dynamic promoStartDate;
  dynamic promoEndDate;
  String? disableFromPriceRules;
  String? allowPriceOverrideRegardlessOfPermissions;
  String? pricesIncludeTax;
  String? onlyAllowItemsToBeSoldInWholeNumbers;
  String? changeCostPriceDuringSale;
  String? overrideDefaultCommission;
  String? overrideDefaultTax;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic isEditableInSale;

  ProductPrices({
    this.id,
    this.productId,
    this.costPriceWithoutTax,
    this.sellingPrice,
    this.tradePrice,
    this.vat,
    this.wholesale,
    this.wholesaleType,
    this.promoPrice,
    this.promoStartDate,
    this.promoEndDate,
    this.disableFromPriceRules,
    this.allowPriceOverrideRegardlessOfPermissions,
    this.pricesIncludeTax,
    this.onlyAllowItemsToBeSoldInWholeNumbers,
    this.changeCostPriceDuringSale,
    this.overrideDefaultCommission,
    this.overrideDefaultTax,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isEditableInSale,
  });

  factory ProductPrices.fromJson(Map<String, dynamic> json) => ProductPrices(
    id: json["id"],
    productId: json["product_id"],
    costPriceWithoutTax: json["cost_price_without_tax"],
    sellingPrice: json["selling_price"],
    tradePrice: json["trade_price"],
    vat: json["vat"],
    wholesale: json["wholesale"],
    wholesaleType: json["wholesale_type"],
    promoPrice: json["promo_price"],
    promoStartDate: json["promo_start_date"],
    promoEndDate: json["promo_end_date"],
    disableFromPriceRules: json["disable_from_price_rules"],
    allowPriceOverrideRegardlessOfPermissions: json["allow_price_override_regardless_of_permissions"],
    pricesIncludeTax: json["prices_include_tax"],
    onlyAllowItemsToBeSoldInWholeNumbers: json["only_allow_items_to_be_sold_in_whole_numbers"],
    changeCostPriceDuringSale: json["change_cost_price_during_sale"],
    overrideDefaultCommission: json["override_default_commission"],
    overrideDefaultTax: json["override_default_tax"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    isEditableInSale: json["is_editable_in_sale"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "cost_price_without_tax": costPriceWithoutTax,
    "selling_price": sellingPrice,
    "trade_price": tradePrice,
    "vat": vat,
    "wholesale": wholesale,
    "wholesale_type": wholesaleType,
    "promo_price": promoPrice,
    "promo_start_date": promoStartDate,
    "promo_end_date": promoEndDate,
    "disable_from_price_rules": disableFromPriceRules,
    "allow_price_override_regardless_of_permissions": allowPriceOverrideRegardlessOfPermissions,
    "prices_include_tax": pricesIncludeTax,
    "only_allow_items_to_be_sold_in_whole_numbers": onlyAllowItemsToBeSoldInWholeNumbers,
    "change_cost_price_during_sale": changeCostPriceDuringSale,
    "override_default_commission": overrideDefaultCommission,
    "override_default_tax": overrideDefaultTax,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "is_editable_in_sale": isEditableInSale,
  };
}

class Supplier {
  int? id;
  String? firstName;
  String? lastName;
  String? address1;
  dynamic address2;
  dynamic city;
  dynamic stateOrProvince;
  dynamic zip;
  dynamic country;
  dynamic comments;
  String? contact;
  String? email;
  String? companyName;
  dynamic accountNo;
  dynamic imagePath;
  String? status;
  dynamic createdAt;
  dynamic updatedAt;
  String? type;
  String? storeAccountBalance;
  String? payAmount;
  dynamic deletedAt;
  dynamic deletedBy;

  Supplier({
    this.id,
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.stateOrProvince,
    this.zip,
    this.country,
    this.comments,
    this.contact,
    this.email,
    this.companyName,
    this.accountNo,
    this.imagePath,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.storeAccountBalance,
    this.payAmount,
    this.deletedAt,
    this.deletedBy,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    address1: json["address_1"],
    address2: json["address_2"],
    city: json["city"],
    stateOrProvince: json["state_or_province"],
    zip: json["zip"],
    country: json["country"],
    comments: json["comments"],
    contact: json["contact"],
    email: json["email"],
    companyName: json["company_name"],
    accountNo: json["account_no"],
    imagePath: json["image_path"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    type: json["type"],
    storeAccountBalance: json["store_account_balance"],
    payAmount: json["pay_amount"],
    deletedAt: json["deleted_at"],
    deletedBy: json["deleted_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "state_or_province": stateOrProvince,
    "zip": zip,
    "country": country,
    "comments": comments,
    "contact": contact,
    "email": email,
    "company_name": companyName,
    "account_no": accountNo,
    "image_path": imagePath,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "type": type,
    "store_account_balance": storeAccountBalance,
    "pay_amount": payAmount,
    "deleted_at": deletedAt,
    "deleted_by": deletedBy,
  };
}
