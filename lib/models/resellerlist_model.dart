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
        resellers: List<Reseller>.from(
          json["resellers"].map((x) => Reseller.fromJson(x)),
        ),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "resellers": List<dynamic>.from(resellers!.map((x) => x.toJson())),
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

class Reseller {
  final int? id;
  final int? businessOwnerId;
  final String? name;
  final String? phone;
  final String? city;
  final double? bonusPercentage;
  final int? totalSellAmount;
  final int? totalSellTopup;
  final int? totalSellTopupWithBonus;
  final int? totalReceivedAmount;
  final int? totalDueAmount;
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
    id: (json["id"] as num?)?.toInt(),
    businessOwnerId: (json["business_owner_id"] as num?)?.toInt(),
    name: json["name"],
    phone: json["phone"],
    city: json["city"],

    // double safe
    bonusPercentage: (json["bonus_percentage"] as num?)?.toDouble(),

    // int safe (even if API gives double)
    totalSellAmount: (json["total_sell_amount"] as num?)?.toInt(),
    totalSellTopup: (json["total_sell_topup"] as num?)?.toInt(),
    totalSellTopupWithBonus: (json["total_sell_topup_with_bonus"] as num?)
        ?.toInt(),
    totalReceivedAmount: (json["total_received_amount"] as num?)?.toInt(),
    totalDueAmount: (json["total_due_amount"] as num?)?.toInt(),

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
}
