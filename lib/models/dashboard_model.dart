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
  final double? totalSales;
  final double? totalReceivedFromResellers;
  final double? totalResellerDue;

  Resellers({
    this.totalResellers,
    this.totalSales,
    this.totalReceivedFromResellers,
    this.totalResellerDue,
  });

  factory Resellers.fromJson(Map<String, dynamic> json) => Resellers(
    totalResellers: json["total_resellers"],
    totalSales: (json["total_sales"] as num?)?.toDouble(),
    totalReceivedFromResellers: (json["total_received_from_resellers"] as num?)
        ?.toDouble(),
    totalResellerDue: (json["total_reseller_due"] as num?)?.toDouble(),
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
  final double? totalPurchases;
  final double? totalPaidToSuppliers;
  final double? totalSupplierDue;
  final double? totalStock;

  Suppliers({
    this.totalSuppliers,
    this.totalPurchases,
    this.totalPaidToSuppliers,
    this.totalSupplierDue,
    this.totalStock,
  });

  factory Suppliers.fromJson(Map<String, dynamic> json) => Suppliers(
    totalSuppliers: json["total_suppliers"],
    totalPurchases: (json["total_purchases"] as num?)?.toDouble(),
    totalPaidToSuppliers: (json["total_paid_to_suppliers"] as num?)?.toDouble(),
    totalSupplierDue: (json["total_supplier_due"] as num?)?.toDouble(),
    totalStock: (json["total_stock"] as num?)?.toDouble(),
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
  final double? purchases;
  final double? sales;
  final double? paymentsToSuppliers;
  final double? paymentsFromResellers;

  Today({
    this.purchases,
    this.sales,
    this.paymentsToSuppliers,
    this.paymentsFromResellers,
  });

  factory Today.fromJson(Map<String, dynamic> json) => Today(
    purchases: (json["purchases"] as num?)?.toDouble(),
    sales: (json["sales"] as num?)?.toDouble(),
    paymentsToSuppliers: (json["payments_to_suppliers"] as num?)?.toDouble(),
    paymentsFromResellers: (json["payments_from_resellers"] as num?)
        ?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "purchases": purchases,
    "sales": sales,
    "payments_to_suppliers": paymentsToSuppliers,
    "payments_from_resellers": paymentsFromResellers,
  };
}
