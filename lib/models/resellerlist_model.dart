import 'dart:convert';

ResellerListModel resellerListModelFromJson(String str) =>
    ResellerListModel.fromJson(json.decode(str));

String resellerListModelToJson(ResellerListModel data) =>
    json.encode(data.toJson());

class ResellerListModel {
  final bool? status;
  final String? message;
  final List<Reseller>? resellers;
  final Pagination? pagination;

  ResellerListModel({
    this.status,
    this.message,
    this.resellers,
    this.pagination,
  });

  factory ResellerListModel.fromJson(Map<String, dynamic> json) =>
      ResellerListModel(
        status: json["status"],
        message: json["message"],
        resellers: json["resellers"] == null
            ? []
            : List<Reseller>.from(
                json["resellers"].map((x) => Reseller.fromJson(x)),
              ),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "resellers": resellers == null
        ? []
        : List<dynamic>.from(resellers!.map((x) => x.toJson())),
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

class Reseller {
  final int? id;
  final int? businessOwnerId;
  final String? name;
  final String? phone;
  final String? city;

  // 🔥 STRING NOW
  final String? bonusPercentage;
  final String? totalSellAmount;
  final String? totalSellTopup;
  final String? totalSellTopupWithBonus;
  final String? totalReceivedAmount;
  final String? totalDueAmount;

  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Reseller({
    this.id,
    this.businessOwnerId,
    this.name,
    this.phone,
    this.city,
    this.bonusPercentage,
    this.totalSellAmount,
    this.totalSellTopup,
    this.totalSellTopupWithBonus,
    this.totalReceivedAmount,
    this.totalDueAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Reseller.fromJson(Map<String, dynamic> json) => Reseller(
    id: json["id"],
    businessOwnerId: json["business_owner_id"],
    name: json["name"],
    phone: json["phone"],
    city: json["city"],

    // 🔥 STRING assign
    bonusPercentage: json["bonus_percentage"],
    totalSellAmount: json["total_sell_amount"],
    totalSellTopup: json["total_sell_topup"],
    totalSellTopupWithBonus: json["total_sell_topup_with_bonus"],
    totalReceivedAmount: json["total_received_amount"],
    totalDueAmount: json["total_due_amount"],

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
    "city": city,
    "bonus_percentage": bonusPercentage,
    "total_sell_amount": totalSellAmount,
    "total_sell_topup": totalSellTopup,
    "total_sell_topup_with_bonus": totalSellTopupWithBonus,
    "total_received_amount": totalReceivedAmount,
    "total_due_amount": totalDueAmount,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  // 🔥 Helper getters (VERY IMPORTANT)
  // double get totalSellDouble => double.tryParse(totalSellAmount ?? "0") ?? 0;

  // double get totalReceivedDouble =>
  //     double.tryParse(totalReceivedAmount ?? "0") ?? 0;

  // double get totalDueDouble => double.tryParse(totalDueAmount ?? "0") ?? 0;

  // double get totalWithBonusDouble =>
  //     double.tryParse(totalSellTopupWithBonus ?? "0") ?? 0;
}
