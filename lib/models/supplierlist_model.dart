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
        suppliers: json["suppliers"] == null
            ? []
            : List<Supplier>.from(
                json["suppliers"].map((x) => Supplier.fromJson(x)),
              ),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "suppliers": suppliers == null
        ? []
        : List<dynamic>.from(suppliers!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
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
    totalItems: json["total_items"],
    totalPages: json["total_pages"],
    currentPage: json["current_page"],
    itemPerPage: json["item_per_page"],
  );

  Map<String, dynamic> toJson() => {
    "total_items": totalItems,
    "total_pages": totalPages,
    "current_page": currentPage,
    "item_per_page": itemPerPage,
  };
}

class Supplier {
  final int? id;
  final int? businessOwnerId;
  final String? name;
  final String? phone;
  final String? company;

  // 🔥 NOW STRING
  final String? bonusPercentage;
  final String? totalBuyAmount;
  final String? totalBuyTopup;
  final String? totalBuyTopupWithBonus;
  final String? totalPaidAmount;
  final String? totalDueAmount;
  final String? currentStock;

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
    id: json["id"],
    businessOwnerId: json["business_owner_id"],
    name: json["name"],
    phone: json["phone"],
    company: json["company"],

    // 🔥 STRING assign
    bonusPercentage: json["bonus_percentage"],
    totalBuyAmount: json["total_buy_amount"],
    totalBuyTopup: json["total_buy_topup"],
    totalBuyTopupWithBonus: json["total_buy_topup_with_bonus"],
    totalPaidAmount: json["total_paid_amount"],
    totalDueAmount: json["total_due_amount"],
    currentStock: json["current_stock"],

    status: json["status"],

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

  // 🔥 Helper getters (VERY USEFUL)
  double get totalBuyAmountDouble =>
      double.tryParse(totalBuyAmount ?? "0") ?? 0;

  double get totalPaidDouble => double.tryParse(totalPaidAmount ?? "0") ?? 0;

  double get totalDueDouble => double.tryParse(totalDueAmount ?? "0") ?? 0;

  double get stockDouble => double.tryParse(currentStock ?? "0") ?? 0;
}
