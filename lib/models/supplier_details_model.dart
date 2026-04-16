import 'dart:convert';

SupplierDetailsModel supplierDetailsModelFromJson(String str) =>
    SupplierDetailsModel.fromJson(json.decode(str));

String supplierDetailsModelToJson(SupplierDetailsModel data) =>
    json.encode(data.toJson());

// ================= ROOT =================

class SupplierDetailsModel {
  final bool? success;
  final Supplier? supplier;
  final Summary? summary;
  final RecentTransactions? recentTransactions;
  final AllTransactions? allTransactions;

  SupplierDetailsModel({
    this.success,
    this.supplier,
    this.summary,
    this.recentTransactions,
    this.allTransactions,
  });

  factory SupplierDetailsModel.fromJson(Map<String, dynamic> json) =>
      SupplierDetailsModel(
        success: json["success"],
        supplier: json["supplier"] == null
            ? null
            : Supplier.fromJson(json["supplier"]),
        summary: json["summary"] == null
            ? null
            : Summary.fromJson(json["summary"]),
        recentTransactions: json["recent_transactions"] == null
            ? null
            : RecentTransactions.fromJson(json["recent_transactions"]),
        allTransactions: json["all_transactions"] == null
            ? null
            : AllTransactions.fromJson(json["all_transactions"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "supplier": supplier?.toJson(),
    "summary": summary?.toJson(),
    "recent_transactions": recentTransactions?.toJson(),
    "all_transactions": allTransactions?.toJson(),
  };
}

// ================= SUPPLIER =================

class Supplier {
  final int? id;
  final String? name;
  final String? phone;
  final String? company;

  final String? bonusPercentage;
  final String? totalBuyAmount;
  final String? totalPaidAmount;
  final String? totalDueAmount;
  final String? currentStock;

  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Supplier({
    this.id,
    this.name,
    this.phone,
    this.company,
    this.bonusPercentage,
    this.totalBuyAmount,
    this.totalPaidAmount,
    this.totalDueAmount,
    this.currentStock,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    company: json["company"],
    bonusPercentage: json["bonus_percentage"],
    totalBuyAmount: json["total_buy_amount"],
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
    "name": name,
    "phone": phone,
    "company": company,
    "bonus_percentage": bonusPercentage,
    "total_buy_amount": totalBuyAmount,
    "total_paid_amount": totalPaidAmount,
    "total_due_amount": totalDueAmount,
    "current_stock": currentStock,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  double get totalDueDouble => double.tryParse(totalDueAmount ?? "0") ?? 0;
}

// ================= SUMMARY =================

class Summary {
  final String? totalPurchaseAmount;
  final String? totalPurchaseWithBonus;
  final String? totalPaid;
  final String? totalDue;
  final String? currentStock;
  final String? totalBonusReceived;
  final String? averageBonusPercentage;

  Summary({
    this.totalPurchaseAmount,
    this.totalPurchaseWithBonus,
    this.totalPaid,
    this.totalDue,
    this.currentStock,
    this.totalBonusReceived,
    this.averageBonusPercentage,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    totalPurchaseAmount: json["total_purchase_amount"],
    totalPurchaseWithBonus: json["total_purchase_with_bonus"],
    totalPaid: json["total_paid"],
    totalDue: json["total_due"],
    currentStock: json["current_stock"],
    totalBonusReceived: json["total_bonus_received"],
    averageBonusPercentage: json["average_bonus_percentage"],
  );

  Map<String, dynamic> toJson() => {
    "total_purchase_amount": totalPurchaseAmount,
    "total_purchase_with_bonus": totalPurchaseWithBonus,
    "total_paid": totalPaid,
    "total_due": totalDue,
    "current_stock": currentStock,
    "total_bonus_received": totalBonusReceived,
    "average_bonus_percentage": averageBonusPercentage,
  };

  double get totalDueDouble => double.tryParse(totalDue ?? "0") ?? 0;
}

// ================= TRANSACTIONS =================

class Datum {
  final int? id;
  final String? transactionType;

  final String? baseAmount;
  final String? bonusPercentage;
  final String? bonusAmount;
  final String? totalAmount;
  final String? paidAmount;
  final String? dueAmount;
  final String? previousDue;

  final dynamic referenceNo;
  final dynamic notes;

  final DateTime? transactionDate;
  final DateTime? createdAt;

  Datum({
    this.id,
    this.transactionType,
    this.baseAmount,
    this.bonusPercentage,
    this.bonusAmount,
    this.totalAmount,
    this.paidAmount,
    this.dueAmount,
    this.previousDue,
    this.referenceNo,
    this.notes,
    this.transactionDate,
    this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    transactionType: json["transaction_type"],
    baseAmount: json["base_amount"],
    bonusPercentage: json["bonus_percentage"],
    bonusAmount: json["bonus_amount"],
    totalAmount: json["total_amount"],
    paidAmount: json["paid_amount"],
    dueAmount: json["due_amount"],
    previousDue: json["previous_due"],
    referenceNo: json["reference_no"],
    notes: json["notes"],
    transactionDate: json["transaction_date"] != null
        ? DateTime.parse(json["transaction_date"])
        : null,
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_type": transactionType,
    "base_amount": baseAmount,
    "bonus_percentage": bonusPercentage,
    "bonus_amount": bonusAmount,
    "total_amount": totalAmount,
    "paid_amount": paidAmount,
    "due_amount": dueAmount,
    "previous_due": previousDue,
    "reference_no": referenceNo,
    "notes": notes,
    "transaction_date": transactionDate?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };

  double get dueDouble => double.tryParse(dueAmount ?? "0") ?? 0;
}

// ================= RECENT =================

class RecentTransactions {
  final List<Datum>? purchases;
  final List<Datum>? payments;
  final String? showing;

  RecentTransactions({this.purchases, this.payments, this.showing});

  factory RecentTransactions.fromJson(Map<String, dynamic> json) =>
      RecentTransactions(
        purchases: json["purchases"] == null
            ? []
            : List<Datum>.from(json["purchases"].map((x) => Datum.fromJson(x))),
        payments: json["payments"] == null
            ? []
            : List<Datum>.from(json["payments"].map((x) => Datum.fromJson(x))),
        showing: json["showing"],
      );

  Map<String, dynamic> toJson() => {
    "purchases": purchases?.map((e) => e.toJson()).toList(),
    "payments": payments?.map((e) => e.toJson()).toList(),
    "showing": showing,
  };
}

// ================= ALL =================

class AllTransactions {
  final List<Datum>? data;
  final Pagination? pagination;

  AllTransactions({this.data, this.pagination});

  factory AllTransactions.fromJson(Map<String, dynamic> json) =>
      AllTransactions(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
    "data": data?.map((e) => e.toJson()).toList(),
    "pagination": pagination?.toJson(),
  };
}

// ================= PAGINATION =================

class Pagination {
  final int? totalRecords;
  final int? currentPage;
  final int? perPage;
  final int? totalPages;
  final bool? hasNext;
  final bool? hasPrevious;

  Pagination({
    this.totalRecords,
    this.currentPage,
    this.perPage,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalRecords: json["total_records"],
    currentPage: json["current_page"],
    perPage: json["per_page"],
    totalPages: json["total_pages"],
    hasNext: json["has_next"],
    hasPrevious: json["has_previous"],
  );

  Map<String, dynamic> toJson() => {
    "total_records": totalRecords,
    "current_page": currentPage,
    "per_page": perPage,
    "total_pages": totalPages,
    "has_next": hasNext,
    "has_previous": hasPrevious,
  };
}
