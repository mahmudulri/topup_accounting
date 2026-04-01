import 'package:get/get.dart';
import '../models/profit_model.dart';
import '../services/profit_service.dart';

class ProfitController extends GetxController {
  var isLoading = false.obs;

  var allprofitData = ProfitModel().obs;

  void fetchprofitData() async {
    try {
      isLoading(true);
      await ProfitApi().fetchprofit().then((value) {
        allprofitData.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
