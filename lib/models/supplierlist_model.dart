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
  final double? bonusPercentage;
  final double? totalBuyAmount;
  final double? totalBuyTopup;
  final double? totalBuyTopupWithBonus;
  final double? totalPaidAmount;
  final double? totalDueAmount;
  final double? currentStock;
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
    id: (json["id"] as num?)?.toInt(),
    businessOwnerId: (json["business_owner_id"] as num?)?.toInt(),
    name: json["name"],
    phone: json["phone"],
    company: json["company"],

    // double safe
    bonusPercentage: (json["bonus_percentage"] as num?)?.toDouble(),
    totalBuyAmount: (json["total_buy_amount"] as num?)?.toDouble(),
    totalPaidAmount: (json["total_paid_amount"] as num?)?.toDouble(),

    // int safe
    totalBuyTopup: (json["total_buy_topup"] as num?)?.toDouble(),
    totalBuyTopupWithBonus: (json["total_buy_topup_with_bonus"] as num?)
        ?.toDouble(),
    totalDueAmount: (json["total_due_amount"] as num?)?.toDouble(),
    currentStock: (json["current_stock"] as num?)?.toDouble(),
    status: (json["status"] as num?)?.toInt(),

    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : null,
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : null,
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
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
