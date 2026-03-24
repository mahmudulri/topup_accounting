import 'package:get/get.dart';
import '../models/resellerlist_model.dart';
import '../services/resellerlist_service.dart';

class ResellerListController extends GetxController {
  var isLoading = false.obs;

  var allresellers = ResellerListModel().obs;

  void fetchReseller() async {
    try {
      isLoading(true);
      await ResellerlistApi().fetchReseller().then((value) {
        allresellers.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
