import 'dart:convert';
import 'dart:ffi';

TransactionsModel transactionsModelFromJson(String str) =>
    TransactionsModel.fromJson(json.decode(str));

String transactionsModelToJson(TransactionsModel data) =>
    json.encode(data.toJson());

class TransactionsModel {
  final bool? success;
  final Summary? summary;
  final List<Transaction>? transactions;
  final Pagination? pagination;

  TransactionsModel({
    this.success,
    this.summary,
    this.transactions,
    this.pagination,
  });

  factory TransactionsModel.fromJson(Map<String, dynamic> json) =>
      TransactionsModel(
        success: json["success"],
        summary: Summary.fromJson(json["summary"]),
        transactions: List<Transaction>.from(
          json["transactions"].map((x) => Transaction.fromJson(x)),
        ),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "summary": summary!.toJson(),
    "transactions": List<dynamic>.from(transactions!.map((x) => x.toJson())),
    "pagination": pagination!.toJson(),
  };
}

class Pagination {
  final int? totalRecords;
  final int? currentPage;
  final int? perPage;
  final int? totalPages;

  Pagination({
    this.totalRecords,
    this.currentPage,
    this.perPage,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalRecords: json["total_records"],
    currentPage: json["current_page"],
    perPage: json["per_page"],
    totalPages: json["total_pages"],
  );

  Map<String, dynamic> toJson() => {
    "total_records": totalRecords,
    "current_page": currentPage,
    "per_page": perPage,
    "total_pages": totalPages,
  };
}

class Summary {
  final double? totalBaseAmount;
  final double? totalPaidAmount;
  final double? totalBonusAmount;

  Summary({this.totalBaseAmount, this.totalPaidAmount, this.totalBonusAmount});

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    totalBaseAmount: (json["total_base_amount"] as num?)?.toDouble(),
    totalPaidAmount: (json["total_paid_amount"] as num?)?.toDouble(),
    totalBonusAmount: (json["total_bonus_amount"] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "total_base_amount": totalBaseAmount,
    "total_paid_amount": totalPaidAmount,
    "total_bonus_amount": totalBonusAmount,
  };
}

class Transaction {
  final int? id;
  final int? businessOwnerId;
  final int? supplierId;
  final int? resellerId;
  final String? transactionType;
  final double? baseAmount;
  final double? bonusPercentage;
  final double? bonusAmount;
  final double? totalAmount;
  final double? paidAmount;
  final double? dueAmount;
  final double? previousDue;
  final String? referenceNo;
  final String? notes;
  final DateTime? transactionDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Supplier? supplier;
  final Reseller? reseller;

  Transaction({
    this.id,
    this.businessOwnerId,
    this.supplierId,
    this.resellerId,
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
    this.updatedAt,
    this.supplier,
    this.reseller,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"] == null ? null : json["id"],
    businessOwnerId: json["business_owner_id"] == null
        ? null
        : json["business_owner_id"],
    supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
    resellerId: json["reseller_id"] == null ? null : json["reseller_id"],
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
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    supplier: json["supplier"] == null
        ? null
        : Supplier.fromJson(json["supplier"]),
    reseller: json["reseller"] == null
        ? null
        : Reseller.fromJson(json["reseller"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_owner_id": businessOwnerId,
    "supplier_id": supplierId,
    "reseller_id": resellerId,
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
    "updatedAt": updatedAt!.toIso8601String(),
    "supplier": supplier!.toJson(),
    "reseller": reseller!.toJson(),
  };
}

class Reseller {
  final int? id;
  final String? name;
  final String? city;

  Reseller({this.id, this.name, this.city});

  factory Reseller.fromJson(Map<String, dynamic> json) => Reseller(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    city: json["city"] == null ? null : json["city"],
  );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "city": city};
}

class Supplier {
  final int? id;
  final String? name;
  final String? company;

  Supplier({this.id, this.name, this.company});

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    company: json["company"] == null ? null : json["company"],
  );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "company": company};
}
