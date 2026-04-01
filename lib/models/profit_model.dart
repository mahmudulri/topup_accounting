import 'dart:convert';

ProfitModel profitModelFromJson(String str) =>
    ProfitModel.fromJson(json.decode(str));

String profitModelToJson(ProfitModel data) => json.encode(data.toJson());

class ProfitModel {
  final bool? success;
  final ProfitAnalysis? profitAnalysis;
  final BonusAnalysis? bonusAnalysis;
  final DueAnalysis? dueAnalysis;
  final List<SupplierBreakdown>? supplierBreakdown;
  final List<ResellerBreakdown>? resellerBreakdown;

  ProfitModel({
    this.success,
    this.profitAnalysis,
    this.bonusAnalysis,
    this.dueAnalysis,
    this.supplierBreakdown,
    this.resellerBreakdown,
  });

  factory ProfitModel.fromJson(Map<String, dynamic> json) => ProfitModel(
    success: json["success"],
    profitAnalysis: ProfitAnalysis.fromJson(json["profit_analysis"]),
    bonusAnalysis: BonusAnalysis.fromJson(json["bonus_analysis"]),
    dueAnalysis: DueAnalysis.fromJson(json["due_analysis"]),
    supplierBreakdown: List<SupplierBreakdown>.from(
      json["supplier_breakdown"].map((x) => SupplierBreakdown.fromJson(x)),
    ),
    resellerBreakdown: List<ResellerBreakdown>.from(
      json["reseller_breakdown"].map((x) => ResellerBreakdown.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "profit_analysis": profitAnalysis!.toJson(),
    "bonus_analysis": bonusAnalysis!.toJson(),
    "due_analysis": dueAnalysis!.toJson(),
    "supplier_breakdown": List<dynamic>.from(
      supplierBreakdown!.map((x) => x.toJson()),
    ),
    "reseller_breakdown": List<dynamic>.from(
      resellerBreakdown!.map((x) => x.toJson()),
    ),
  };
}

class BonusAnalysis {
  final double? totalBonusReceived;
  final double? totalBonusGiven;
  final double? netBonusImpact;

  BonusAnalysis({
    this.totalBonusReceived,
    this.totalBonusGiven,
    this.netBonusImpact,
  });

  factory BonusAnalysis.fromJson(Map<String, dynamic> json) => BonusAnalysis(
    totalBonusReceived: (json["total_bonus_received"] as num?)?.toDouble(),
    totalBonusGiven: (json["total_bonus_given"] as num?)?.toDouble(),
    netBonusImpact: (json["net_bonus_impact"] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "total_bonus_received": totalBonusReceived,
    "total_bonus_given": totalBonusGiven,
    "net_bonus_impact": netBonusImpact,
  };
}

class DueAnalysis {
  final double? totalSupplierDue;
  final double? totalResellerDue;
  final double? netReceivable;

  DueAnalysis({
    this.totalSupplierDue,
    this.totalResellerDue,
    this.netReceivable,
  });

  factory DueAnalysis.fromJson(Map<String, dynamic> json) => DueAnalysis(
    totalSupplierDue: (json["total_supplier_due"] as num?)?.toDouble(),
    totalResellerDue: (json["total_reseller_due"] as num?)?.toDouble(),
    netReceivable: (json["net_receivable"] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "total_supplier_due": totalSupplierDue,
    "total_reseller_due": totalResellerDue,
    "net_receivable": netReceivable,
  };
}

class ProfitAnalysis {
  final Today? total;
  final Today? today;

  ProfitAnalysis({this.total, this.today});

  factory ProfitAnalysis.fromJson(Map<String, dynamic> json) => ProfitAnalysis(
    total: json["total"] == null ? null : Today.fromJson(json["total"]),
    today: json["today"] == null ? null : Today.fromJson(json["today"]),
  );

  Map<String, dynamic> toJson() => {
    "total": total!.toJson(),
    "today": today!.toJson(),
  };
}

class Today {
  final double? revenue;
  final double? cost;
  final double? profit;
  final String? profitMargin;

  Today({this.revenue, this.cost, this.profit, this.profitMargin});

  factory Today.fromJson(Map<String, dynamic> json) => Today(
    revenue: (json["revenue"] as num?)?.toDouble(),
    cost: (json["cost"] as num?)?.toDouble(),
    profit: (json["profit"] as num?)?.toDouble(),
    profitMargin: json["profit_margin"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "revenue": revenue,
    "cost": cost,
    "profit": profit,
    "profit_margin": profitMargin,
  };
}

class ResellerBreakdown {
  final int? id;
  final String? name;
  final int? totalSales;
  final double? totalReceived;
  final double? totalDue;

  ResellerBreakdown({
    this.id,
    this.name,
    this.totalSales,
    this.totalReceived,
    this.totalDue,
  });

  factory ResellerBreakdown.fromJson(Map<String, dynamic> json) =>
      ResellerBreakdown(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        totalSales: json["total_sales"] == null ? null : json["total_sales"],
        totalReceived: (json["total_received"] as num?)?.toDouble(),
        totalDue: (json["total_due"] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "total_sales": totalSales,
    "total_received": totalReceived,
    "total_due": totalDue,
  };
}

class SupplierBreakdown {
  final int? id;
  final String? name;
  final double? totalPurchases;
  final double? totalPayments;
  final double? totalDue;

  SupplierBreakdown({
    this.id,
    this.name,
    this.totalPurchases,
    this.totalPayments,
    this.totalDue,
  });

  factory SupplierBreakdown.fromJson(Map<String, dynamic> json) =>
      SupplierBreakdown(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        totalPurchases: (json["total_purchases"] as num?)?.toDouble(),
        totalPayments: (json["total_payments"] as num?)?.toDouble(),
        totalDue: (json["total_due"] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "total_purchases": totalPurchases,
    "total_payments": totalPayments,
    "total_due": totalDue,
  };
}
