import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) =>
    DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  final bool? success;
  final Summary? summary;

  DashboardModel({this.success, this.summary});

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    success: json["success"],
    summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "summary": summary?.toJson(),
  };
}

// ================= SUMMARY =================

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
    "suppliers": suppliers?.toJson(),
    "resellers": resellers?.toJson(),
    "transactions": transactions?.toJson(),
    "today": today?.toJson(),
  };
}

// ================= SUPPLIERS =================

class Suppliers {
  final int? totalSuppliers;
  final int? activeSuppliers;
  final int? inactiveSuppliers;

  final String? totalPurchases;
  final String? totalPaidToSuppliers;
  final String? totalSupplierDue;
  final String? totalStock;

  Suppliers({
    this.totalSuppliers,
    this.activeSuppliers,
    this.inactiveSuppliers,
    this.totalPurchases,
    this.totalPaidToSuppliers,
    this.totalSupplierDue,
    this.totalStock,
  });

  factory Suppliers.fromJson(Map<String, dynamic> json) => Suppliers(
    totalSuppliers: json["total_suppliers"],
    activeSuppliers: json["active_suppliers"],
    inactiveSuppliers: json["inactive_suppliers"],
    totalPurchases: json["total_purchases"],
    totalPaidToSuppliers: json["total_paid_to_suppliers"],
    totalSupplierDue: json["total_supplier_due"],
    totalStock: json["total_stock"],
  );

  Map<String, dynamic> toJson() => {
    "total_suppliers": totalSuppliers,
    "active_suppliers": activeSuppliers,
    "inactive_suppliers": inactiveSuppliers,
    "total_purchases": totalPurchases,
    "total_paid_to_suppliers": totalPaidToSuppliers,
    "total_supplier_due": totalSupplierDue,
    "total_stock": totalStock,
  };

  // 🔥 Helper getters (for calculation)
  double get totalPurchasesDouble =>
      double.tryParse(totalPurchases ?? "0") ?? 0;

  double get totalPaidDouble =>
      double.tryParse(totalPaidToSuppliers ?? "0") ?? 0;

  double get totalDueDouble => double.tryParse(totalSupplierDue ?? "0") ?? 0;

  double get totalStockDouble => double.tryParse(totalStock ?? "0") ?? 0;
}

// ================= RESELLERS =================

class Resellers {
  final int? totalResellers;
  final int? activeResellers;
  final int? inactiveResellers;

  final String? totalSales;
  final String? totalReceivedFromResellers;
  final String? totalResellerDue;

  Resellers({
    this.totalResellers,
    this.activeResellers,
    this.inactiveResellers,
    this.totalSales,
    this.totalReceivedFromResellers,
    this.totalResellerDue,
  });

  factory Resellers.fromJson(Map<String, dynamic> json) => Resellers(
    totalResellers: json["total_resellers"],
    activeResellers: json["active_resellers"],
    inactiveResellers: json["inactive_resellers"],
    totalSales: json["total_sales"],
    totalReceivedFromResellers: json["total_received_from_resellers"],
    totalResellerDue: json["total_reseller_due"],
  );

  Map<String, dynamic> toJson() => {
    "total_resellers": totalResellers,
    "active_resellers": activeResellers,
    "inactive_resellers": inactiveResellers,
    "total_sales": totalSales,
    "total_received_from_resellers": totalReceivedFromResellers,
    "total_reseller_due": totalResellerDue,
  };

  // 🔥 Helper getters
  double get totalSalesDouble => double.tryParse(totalSales ?? "0") ?? 0;

  double get totalReceivedDouble =>
      double.tryParse(totalReceivedFromResellers ?? "0") ?? 0;

  double get totalDueDouble => double.tryParse(totalResellerDue ?? "0") ?? 0;
}

// ================= TODAY =================

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

  // 🔥 Helper getters
  double get purchasesDouble => double.tryParse(purchases ?? "0") ?? 0;

  double get salesDouble => double.tryParse(sales ?? "0") ?? 0;
}

// ================= TRANSACTIONS =================

class Transactions {
  final int? total;

  Transactions({this.total});

  factory Transactions.fromJson(Map<String, dynamic> json) =>
      Transactions(total: json["total"]);

  Map<String, dynamic> toJson() => {"total": total};
}
