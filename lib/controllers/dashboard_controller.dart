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
