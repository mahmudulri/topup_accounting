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
    success: json["success"] == null ? null : json["success"],
    profitAnalysis: json["profit_analysis"] == null
        ? null
        : ProfitAnalysis.fromJson(json["profit_analysis"]),
    bonusAnalysis: json["bonus_analysis"] == null
        ? null
        : BonusAnalysis.fromJson(json["bonus_analysis"]),
    dueAnalysis: json["due_analysis"] == null
        ? null
        : DueAnalysis.fromJson(json["due_analysis"]),
    supplierBreakdown: json["supplier_breakdown"] == null
        ? null
        : List<SupplierBreakdown>.from(
            json["supplier_breakdown"].map(
              (x) => SupplierBreakdown.fromJson(x),
            ),
          ),
    resellerBreakdown: json["reseller_breakdown"] == null
        ? null
        : List<ResellerBreakdown>.from(
            json["reseller_breakdown"].map(
              (x) => ResellerBreakdown.fromJson(x),
            ),
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
  final String? totalBonusReceived;
  final String? totalBonusGiven;
  final String? netBonusImpact;

  BonusAnalysis({
    this.totalBonusReceived,
    this.totalBonusGiven,
    this.netBonusImpact,
  });

  factory BonusAnalysis.fromJson(Map<String, dynamic> json) => BonusAnalysis(
    totalBonusReceived: json["total_bonus_received"],
    totalBonusGiven: json["total_bonus_given"],
    netBonusImpact: json["net_bonus_impact"],
  );

  Map<String, dynamic> toJson() => {
    "total_bonus_received": totalBonusReceived,
    "total_bonus_given": totalBonusGiven,
    "net_bonus_impact": netBonusImpact,
  };
}

class DueAnalysis {
  final String? totalSupplierDue;
  final String? totalResellerDue;
  final String? netReceivable;

  DueAnalysis({
    this.totalSupplierDue,
    this.totalResellerDue,
    this.netReceivable,
  });

  factory DueAnalysis.fromJson(Map<String, dynamic> json) => DueAnalysis(
    totalSupplierDue: json["total_supplier_due"],
    totalResellerDue: json["total_reseller_due"],
    netReceivable: json["net_receivable"],
  );

  Map<String, dynamic> toJson() => {
    "total_supplier_due": totalSupplierDue,
    "total_reseller_due": totalResellerDue,
    "net_receivable": netReceivable,
  };
}

class ProfitAnalysis {
  final Total? total;
  final Today? today;

  ProfitAnalysis({this.total, this.today});

  factory ProfitAnalysis.fromJson(Map<String, dynamic> json) => ProfitAnalysis(
    total: json["total"] == null ? null : Total.fromJson(json["total"]),
    today: json["today"] == null ? null : Today.fromJson(json["today"]),
  );

  Map<String, dynamic> toJson() => {
    "total": total!.toJson(),
    "today": today!.toJson(),
  };
}

class Today {
  final String? revenue;
  final String? cost;
  final String? profit;
  final String? profitMargin;

  Today({this.revenue, this.cost, this.profit, this.profitMargin});

  factory Today.fromJson(Map<String, dynamic> json) => Today(
    revenue: json["revenue"],
    cost: json["cost"],
    profit: json["profit"],
    profitMargin: json["profit_margin"],
  );

  Map<String, dynamic> toJson() => {
    "revenue": revenue,
    "cost": cost,
    "profit": profit,
    "profit_margin": profitMargin,
  };
}

class Total {
  final String? revenue;
  final String? cost;
  final String? profit;
  final String? profitMargin;

  Total({this.revenue, this.cost, this.profit, this.profitMargin});

  factory Total.fromJson(Map<String, dynamic> json) => Total(
    revenue: json["revenue"],
    cost: json["cost"],
    profit: json["profit"],
    profitMargin: json["profit_margin"],
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
  final String? totalSales;
  final String? totalReceived;
  final String? totalDue;

  ResellerBreakdown({
    this.id,
    this.name,
    this.totalSales,
    this.totalReceived,
    this.totalDue,
  });

  factory ResellerBreakdown.fromJson(Map<String, dynamic> json) =>
      ResellerBreakdown(
        id: json["id"],
        name: json["name"],
        totalSales: json["total_sales"],
        totalReceived: json["total_received"],
        totalDue: json["total_due"],
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
  final String? totalPurchases;
  final String? totalPayments;
  final String? totalDue;

  SupplierBreakdown({
    this.id,
    this.name,
    this.totalPurchases,
    this.totalPayments,
    this.totalDue,
  });

  factory SupplierBreakdown.fromJson(Map<String, dynamic> json) =>
      SupplierBreakdown(
        id: json["id"],
        name: json["name"],
        totalPurchases: json["total_purchases"],
        totalPayments: json["total_payments"],
        totalDue: json["total_due"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "total_purchases": totalPurchases,
    "total_payments": totalPayments,
    "total_due": totalDue,
  };
}
