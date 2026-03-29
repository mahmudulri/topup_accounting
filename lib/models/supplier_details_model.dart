import 'dart:convert';

SupplierDetailsModel supplierDetailsModelFromJson(String str) =>
    SupplierDetailsModel.fromJson(json.decode(str));

String supplierDetailsModelToJson(SupplierDetailsModel data) =>
    json.encode(data.toJson());

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
        supplier: Supplier.fromJson(json["supplier"]),
        summary: Summary.fromJson(json["summary"]),
        recentTransactions: RecentTransactions.fromJson(
          json["recent_transactions"],
        ),
        allTransactions: AllTransactions.fromJson(json["all_transactions"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "supplier": supplier!.toJson(),
    "summary": summary!.toJson(),
    "recent_transactions": recentTransactions!.toJson(),
    "all_transactions": allTransactions!.toJson(),
  };
}

class AllTransactions {
  final List<Datum>? data;
  final Pagination? pagination;

  AllTransactions({this.data, this.pagination});

  factory AllTransactions.fromJson(Map<String, dynamic> json) =>
      AllTransactions(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination!.toJson(),
  };
}

class Datum {
  final int? id;
  final String? transactionType;
  final double? baseAmount;
  final double? bonusPercentage;
  final double? bonusAmount;
  final double? totalAmount;
  final double? paidAmount;
  final double? dueAmount;
  final double? previousDue;
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
    id: json["id"] == null ? null : json["id"],
    transactionType: json["transaction_type"] == null
        ? null
        : json["transaction_type"],
    baseAmount: (json["base_amount"] as num?)?.toDouble(),
    bonusPercentage: (json["bonus_percentage"] as num?)?.toDouble(),
    bonusAmount: (json["bonus_amount"] as num?)?.toDouble(),
    totalAmount: (json["total_amount"] as num?)?.toDouble(),
    paidAmount: (json["paid_amount"] as num?)?.toDouble(),
    dueAmount: (json["due_amount"] as num?)?.toDouble(),
    previousDue: (json["previous_due"] as num?)?.toDouble(),
    referenceNo: json["reference_no"] == null ? null : json["reference_no"],
    notes: json["notes"] == null ? null : json["notes"],
    transactionDate: json["transaction_date"] == null
        ? null
        : DateTime.parse(json["transaction_date"]),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
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
    "transaction_date": transactionDate!.toIso8601String(),
    "createdAt": createdAt!.toIso8601String(),
  };
}

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
    totalRecords: json["total_records"] == null ? null : json["total_records"],
    currentPage: json["current_page"] == null ? null : json["current_page"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    totalPages: json["total_pages"] == null ? null : json["total_pages"],
    hasNext: json["has_next"] == null ? null : json["has_next"],
    hasPrevious: json["has_previous"] == null ? null : json["has_previous"],
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

class RecentTransactions {
  final List<Datum>? purchases;
  final List<Payment>? payments;
  final String? showing;

  RecentTransactions({this.purchases, this.payments, this.showing});

  factory RecentTransactions.fromJson(Map<String, dynamic> json) =>
      RecentTransactions(
        purchases: json["purchases"] == null
            ? null
            : List<Datum>.from(json["purchases"].map((x) => Datum.fromJson(x))),
        payments: json["payments"] == null
            ? null
            : List<Payment>.from(
                json["payments"].map((x) => Payment.fromJson(x)),
              ),
        showing: json["showing"] == null ? null : json["showing"],
      );

  Map<String, dynamic> toJson() => {
    "purchases": List<dynamic>.from(purchases!.map((x) => x.toJson())),
    "payments": List<dynamic>.from(payments!.map((x) => x.toJson())),
    "showing": showing,
  };
}

class Payment {
  final int? id;
  final double? paidAmount;
  final double? dueAmount;
  final double? previousDue;
  final dynamic referenceNo;
  final dynamic notes;
  final DateTime? transactionDate;
  final DateTime? createdAt;

  Payment({
    this.id,
    this.paidAmount,
    this.dueAmount,
    this.previousDue,
    this.referenceNo,
    this.notes,
    this.transactionDate,
    this.createdAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["id"] == null ? null : json["id"],
    paidAmount: (json["paid_amount"] as num?)?.toDouble(),
    dueAmount: (json["due_amount"] as num?)?.toDouble(),
    previousDue: (json["previous_due"] as num?)?.toDouble(),
    referenceNo: json["reference_no"] == null ? null : json["reference_no"],
    notes: json["notes"] == null ? null : json["notes"],
    transactionDate: json["transaction_date"] == null
        ? null
        : DateTime.parse(json["transaction_date"]),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "paid_amount": paidAmount,
    "due_amount": dueAmount,
    "previous_due": previousDue,
    "reference_no": referenceNo,
    "notes": notes,
    "transaction_date": transactionDate!.toIso8601String(),
    "createdAt": createdAt!.toIso8601String(),
  };
}

class Summary {
  final double? totalPurchaseAmount;
  final double? totalPurchaseWithBonus;
  final double? totalPaid;
  final double? totalDue;
  final double? currentStock;
  final double? totalBonusReceived;
  final double? averageBonusPercentage;

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
    totalPurchaseAmount: (json["total_purchase_amount"] as num?)?.toDouble(),
    totalPurchaseWithBonus: (json["total_purchase_with_bonus"] as num?)
        ?.toDouble(),
    totalPaid: (json["total_paid"] as num?)?.toDouble(),
    totalDue: (json["total_due"] as num?)?.toDouble(),
    currentStock: (json["current_stock"] as num?)?.toDouble(),
    totalBonusReceived: (json["total_bonus_received"] as num?)?.toDouble(),
    averageBonusPercentage: (json["average_bonus_percentage"] as num?)
        ?.toDouble(),
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
}

class Supplier {
  final int? id;
  final String? name;
  final String? phone;
  final String? company;
  final double? bonusPercentage;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Supplier({
    this.id,
    this.name,
    this.phone,
    this.company,
    this.bonusPercentage,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    phone: json["phone"] == null ? null : json["phone"],
    company: json["company"] == null ? null : json["company"],
    bonusPercentage: (json["bonus_percentage"] as num?)?.toDouble(),
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "company": company,
    "bonus_percentage": bonusPercentage,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
