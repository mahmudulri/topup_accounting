import 'dart:convert';

PackagesModel packagesModelFromJson(String str) =>
    PackagesModel.fromJson(json.decode(str));

String packagesModelToJson(PackagesModel data) => json.encode(data.toJson());

class PackagesModel {
  final bool? status;
  final String? message;
  final List<Package>? packages;
  final Pagination? pagination;

  PackagesModel({this.status, this.message, this.packages, this.pagination});

  factory PackagesModel.fromJson(Map<String, dynamic> json) => PackagesModel(
    status: json["status"],
    message: json["message"],
    packages: List<Package>.from(
      json["packages"].map((x) => Package.fromJson(x)),
    ),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "packages": List<dynamic>.from(packages!.map((x) => x.toJson())),
    "pagination": pagination!.toJson(),
  };
}

class Package {
  final int? id;
  final String? name;
  final String? description;
  final String? durationType;
  final int? durationValue;
  final String? price;
  final String? currency;
  final bool? webAccess;
  final bool? mobileAccess;
  final bool? isActive;
  final bool? isFeatured;
  final int? sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  Package({
    this.id,
    this.name,
    this.description,
    this.durationType,
    this.durationValue,
    this.price,
    this.currency,
    this.webAccess,
    this.mobileAccess,
    this.isActive,
    this.isFeatured,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    durationType: json["duration_type"] == null ? null : json["duration_type"],
    durationValue: json["duration_value"] == null
        ? null
        : json["duration_value"],
    price: json["price"] == null ? null : json["price"],
    currency: json["currency"] == null ? null : json["currency"],
    webAccess: json["web_access"] == null ? null : json["web_access"],
    mobileAccess: json["mobile_access"] == null ? null : json["mobile_access"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    isFeatured: json["is_featured"] == null ? null : json["is_featured"],
    sortOrder: json["sort_order"] == null ? null : json["sort_order"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"] == null ? null : json["deletedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "duration_type": durationType,
    "duration_value": durationValue,
    "price": price,
    "currency": currency,
    "web_access": webAccess,
    "mobile_access": mobileAccess,
    "is_active": isActive,
    "is_featured": isFeatured,
    "sort_order": sortOrder,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "deletedAt": deletedAt,
  };
}

class Pagination {
  final int? totalItems;
  final int? totalPages;
  final int? currentPage;
  final int? itemPerPage;

  Pagination({
    this.totalItems,
    this.totalPages,
    this.currentPage,
    this.itemPerPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalItems: json["total_items"] == null ? null : json["total_items"],
    totalPages: json["total_pages"] == null ? null : json["total_pages"],
    currentPage: json["current_page"] == null ? null : json["current_page"],
    itemPerPage: json["item_per_page"] == null ? null : json["item_per_page"],
  );

  Map<String, dynamic> toJson() => {
    "total_items": totalItems,
    "total_pages": totalPages,
    "current_page": currentPage,
    "item_per_page": itemPerPage,
  };
}
