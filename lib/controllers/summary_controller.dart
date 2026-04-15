import 'package:get/get.dart';
import '../models/dashboard_model.dart';
import '../models/summary_model.dart';
import '../services/dashboard_service.dart';
import '../services/summary_service.dart';

class SummaryController extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchdashboard();
  // }

  var isLoading = false.obs;

  var allsummarydata = SummaryModel().obs;

  void fetchsummary() async {
    try {
      isLoading(true);
      await SummaryApi().fetchsummary().then((value) {
        allsummarydata.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
