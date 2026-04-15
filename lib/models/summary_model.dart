import 'dart:convert';

SummaryModel summaryModelFromJson(String str) =>
    SummaryModel.fromJson(json.decode(str));

String summaryModelToJson(SummaryModel data) => json.encode(data.toJson());

class SummaryModel {
  final bool? success;
  final Summary? summary;

  SummaryModel({this.success, this.summary});

  factory SummaryModel.fromJson(Map<String, dynamic> json) => SummaryModel(
    success: json["success"],
    summary: Summary.fromJson(json["summary"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "summary": summary!.toJson(),
  };
}

class Summary {
  final Suppliers? suppliers;
  final Resellers? resellers;
  final Transactions? transactions;
  final Today? today;

  Summary({this.suppliers, this.resellers, this.transactions, this.today});

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    suppliers: json["suppliers"] == null
        ? null
        : Suppliers.fromJson(json["suppliers"]),
    resellers: json["resellers"] == null
        ? null
        : Resellers.fromJson(json["resellers"]),
    transactions: json["transactions"] == null
        ? null
        : Transactions.fromJson(json["transactions"]),
    today: json["today"] == null ? null : Today.fromJson(json["today"]),
  );

  Map<String, dynamic> toJson() => {
    "suppliers": suppliers!.toJson(),
    "resellers": resellers!.toJson(),
    "transactions": transactions!.toJson(),
    "today": today!.toJson(),
  };
}

class Resellers {
  final int? totalResellers;
  final String? totalSales;
  final String? totalReceivedFromResellers;
  final String? totalResellerDue;
  final int? activeResellers;
  final int? inactiveResellers;

  Resellers({
    this.totalResellers,
    this.totalSales,
    this.totalReceivedFromResellers,
    this.totalResellerDue,
    this.activeResellers,
    this.inactiveResellers,
  });

  factory Resellers.fromJson(Map<String, dynamic> json) => Resellers(
    totalResellers: json["total_resellers"],
    totalSales: json["total_sales"],
    totalReceivedFromResellers: json["total_received_from_resellers"],
    totalResellerDue: json["total_reseller_due"],
    activeResellers: json["active_resellers"],
    inactiveResellers: json["inactive_resellers"],
  );

  Map<String, dynamic> toJson() => {
    "total_resellers": totalResellers,
    "total_sales": totalSales,
    "total_received_from_resellers": totalReceivedFromResellers,
    "total_reseller_due": totalResellerDue,
    "active_resellers": activeResellers,
    "inactive_resellers": inactiveResellers,
  };
}

class Suppliers {
  final int? totalSuppliers;
  final String? totalPurchases;
  final String? totalPaidToSuppliers;
  final String? totalSupplierDue;
  final String? totalStock;
  final int? activeSuppliers;
  final int? inactiveSuppliers;

  Suppliers({
    this.totalSuppliers,
    this.totalPurchases,
    this.totalPaidToSuppliers,
    this.totalSupplierDue,
    this.totalStock,
    this.activeSuppliers,
    this.inactiveSuppliers,
  });

  factory Suppliers.fromJson(Map<String, dynamic> json) => Suppliers(
    totalSuppliers: json["total_suppliers"],
    totalPurchases: json["total_purchases"],
    totalPaidToSuppliers: json["total_paid_to_suppliers"],
    totalSupplierDue: json["total_supplier_due"],
    totalStock: json["total_stock"],
    activeSuppliers: json["active_suppliers"],
    inactiveSuppliers: json["inactive_suppliers"],
  );

  Map<String, dynamic> toJson() => {
    "total_suppliers": totalSuppliers,
    "total_purchases": totalPurchases,
    "total_paid_to_suppliers": totalPaidToSuppliers,
    "total_supplier_due": totalSupplierDue,
    "total_stock": totalStock,
    "active_suppliers": activeSuppliers,
    "inactive_suppliers": inactiveSuppliers,
  };
}

class Today {
  final String? purchases;
  final String? sales;
  final String? paymentsToSuppliers;
  final String? paymentsFromResellers;

  Today({
    this.purchases,
    this.sales,
    this.paymentsToSuppliers,
    this.paymentsFromResellers,
  });

  factory Today.fromJson(Map<String, dynamic> json) => Today(
    purchases: json["purchases"],
    sales: json["sales"],
    paymentsToSuppliers: json["payments_to_suppliers"],
    paymentsFromResellers: json["payments_from_resellers"],
  );

  Map<String, dynamic> toJson() => {
    "purchases": purchases,
    "sales": sales,
    "payments_to_suppliers": paymentsToSuppliers,
    "payments_from_resellers": paymentsFromResellers,
  };
}

class Transactions {
  final int? total;

  Transactions({this.total});

  factory Transactions.fromJson(Map<String, dynamic> json) =>
      Transactions(total: json["total"]);

  Map<String, dynamic> toJson() => {"total": total};
}
