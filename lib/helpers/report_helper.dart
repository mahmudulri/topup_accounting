class DailyReport {
  final String date;
  final double purchases;
  final double sales;

  DailyReport({
    required this.date,
    required this.purchases,
    required this.sales,
  });

  double get profit => sales - purchases;
}
