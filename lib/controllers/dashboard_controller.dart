import 'package:get/get.dart';
import '../models/dashboard_model.dart';
import '../services/dashboard_service.dart';

class DashboardController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchdashboard();
  }

  var isLoading = false.obs;

  var alldashboaddata = DashboardModel().obs;

  double get stockPercentage {
    final suppliers = alldashboaddata.value.summary?.suppliers;
    final resellers = alldashboaddata.value.summary?.resellers;

    if (suppliers == null || resellers == null) return 0;

    double totalStock = suppliers.totalStockDouble;
    double totalPurchases = suppliers.totalPurchasesDouble;
    double totalSales = resellers.totalSalesDouble;

    double total = totalPurchases + totalSales;

    if (total == 0) return 0;

    return (totalStock / total) * 100;
  }

  void fetchdashboard() async {
    try {
      isLoading(true);
      await DashboardApi().fetchdashboard().then((value) {
        alldashboaddata.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
