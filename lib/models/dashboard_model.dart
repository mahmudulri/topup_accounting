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
  final Today? today;

  Summary({this.suppliers, this.resellers, this.today});

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    suppliers: Suppliers.fromJson(json["suppliers"]),
    resellers: Resellers.fromJson(json["resellers"]),
    today: Today.fromJson(json["today"]),
  );

  Map<String, dynamic> toJson() => {
    "suppliers": suppliers!.toJson(),
    "resellers": resellers!.toJson(),
    "today": today!.toJson(),
  };
}

class Resellers {
  final int? totalResellers;
  final int? totalSales;
  final int? totalReceivedFromResellers;
  final int? totalResellerDue;

  Resellers({
    this.totalResellers,
    this.totalSales,
    this.totalReceivedFromResellers,
    this.totalResellerDue,
  });

  factory Resellers.fromJson(Map<String, dynamic> json) => Resellers(
    totalResellers: json["total_resellers"],
    totalSales: json["total_sales"],
    totalReceivedFromResellers: json["total_received_from_resellers"],
    totalResellerDue: json["total_reseller_due"],
  );

  Map<String, dynamic> toJson() => {
    "total_resellers": totalResellers,
    "total_sales": totalSales,
    "total_received_from_resellers": totalReceivedFromResellers,
    "total_reseller_due": totalResellerDue,
  };
}

class Suppliers {
  final int? totalSuppliers;
  final int? totalPurchases;
  final double? totalPaidToSuppliers;
  final double? totalSupplierDue;
  final int? totalStock;

  Suppliers({
    this.totalSuppliers,
    this.totalPurchases,
    this.totalPaidToSuppliers,
    this.totalSupplierDue,
    this.totalStock,
  });

  factory Suppliers.fromJson(Map<String, dynamic> json) => Suppliers(
    totalSuppliers: json["total_suppliers"],
    totalPurchases: json["total_purchases"],
    totalPaidToSuppliers: json["total_paid_to_suppliers"].toDouble(),
    totalSupplierDue: json["total_supplier_due"].toDouble(),
    totalStock: json["total_stock"],
  );

  Map<String, dynamic> toJson() => {
    "total_suppliers": totalSuppliers,
    "total_purchases": totalPurchases,
    "total_paid_to_suppliers": totalPaidToSuppliers,
    "total_supplier_due": totalSupplierDue,
    "total_stock": totalStock,
  };
}

class Today {
  final int? purchases;
  final int? sales;
  final int? paymentsToSuppliers;
  final int? paymentsFromResellers;

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
