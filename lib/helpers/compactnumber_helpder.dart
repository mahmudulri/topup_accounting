String formatCompactNumber(double num) {
  String format(double value, String suffix) {
    double truncated = (value * 10).floor() / 10; // truncate (no rounding)
    return "${truncated.toStringAsFixed(1)}$suffix";
  }

  if (num >= 10000000) return format(num / 10000000, 'Cr');
  if (num >= 100000) return format(num / 100000, 'L');
  if (num >= 1000) return format(num / 1000, 'K');

  return num.toStringAsFixed(0);
}

String formatedprice(double num) {
  return ((num * 100).truncate() / 100).toStringAsFixed(2);
}
