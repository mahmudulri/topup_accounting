import 'dart:convert';

SuppliersListModel suppliersListModelFromJson(String str) =>
    SuppliersListModel.fromJson(json.decode(str));

String suppliersListModelToJson(SuppliersListModel data) =>
    json.encode(data.toJson());

class SuppliersListModel {
  final bool? status;
  final String? message;
  final List<Supplier>? suppliers;
  final Pagination? pagination;

  SuppliersListModel({
    this.status,
    this.message,
    this.suppliers,
    this.pagination,
  });

  factory SuppliersListModel.fromJson(Map<String, dynamic> json) =>
      SuppliersListModel(
        status: json["status"],
        message: json["message"],
        suppliers: List<Supplier>.from(
          json["suppliers"].map((x) => Supplier.fromJson(x)),
        ),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "suppliers": List<dynamic>.from(suppliers!.map((x) => x.toJson())),
    "pagination": pagination!.toJson(),
  };
}

class Pagination {
  final int? totalItems;
  final int? totalPages;
  final int? currentPage;

  Pagination({this.totalItems, this.totalPages, this.currentPage});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalItems: json["total_items"],
    totalPages: json["total_pages"],
    currentPage: json["current_page"],
  );

  Map<String, dynamic> toJson() => {
    "total_items": totalItems,
    "total_pages": totalPages,
    "current_page": currentPage,
  };
}

class Supplier {
  final int? id;
  final int? businessOwnerId;
  final String? name;
  final String? phone;
  final String? company;
  final int? bonusPercentage;
  final int? totalBuyAmount;
  final int? totalBuyTopup;
  final int? totalBuyTopupWithBonus;
  final int? totalPaidAmount;
  final int? totalDueAmount;
  final int? currentStock;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Supplier({
    this.id,
    this.businessOwnerId,
    this.name,
    this.phone,
    this.company,
    this.bonusPercentage,
    this.totalBuyAmount,
    this.totalBuyTopup,
    this.totalBuyTopupWithBonus,
    this.totalPaidAmount,
    this.totalDueAmount,
    this.currentStock,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    id: json["id"] == null ? null : json["id"],
    businessOwnerId: json["business_owner_id"] == null
        ? null
        : json["business_owner_id"],
    name: json["name"] == null ? null : json["name"],
    phone: json["phone"] == null ? null : json["phone"],
    company: json["company"] == null ? null : json["company"],
    bonusPercentage: json["bonus_percentage"] == null
        ? null
        : json["bonus_percentage"],
    totalBuyAmount: json["total_buy_amount"] == null
        ? null
        : json["total_buy_amount"],
    totalBuyTopup: json["total_buy_topup"] == null
        ? null
        : json["total_buy_topup"],
    totalBuyTopupWithBonus: json["total_buy_topup_with_bonus"] == null
        ? null
        : json["total_buy_topup_with_bonus"],
    totalPaidAmount: json["total_paid_amount"] == null
        ? null
        : json["total_paid_amount"],
    totalDueAmount: json["total_due_amount"] == null
        ? null
        : json["total_due_amount"],
    currentStock: json["current_stock"] == null ? null : json["current_stock"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_owner_id": businessOwnerId,
    "name": name,
    "phone": phone,
    "company": company,
    "bonus_percentage": bonusPercentage,
    "total_buy_amount": totalBuyAmount,
    "total_buy_topup": totalBuyTopup,
    "total_buy_topup_with_bonus": totalBuyTopupWithBonus,
    "total_paid_amount": totalPaidAmount,
    "total_due_amount": totalDueAmount,
    "current_stock": currentStock,
    "status": status,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
  };
}
