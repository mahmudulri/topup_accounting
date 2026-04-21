class MonthlyReport {
  final int month;
  double purchases;
  double sales;

  MonthlyReport({required this.month, this.purchases = 0, this.sales = 0});

  double get profit => sales - purchases;
}
