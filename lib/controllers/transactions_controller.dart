import 'package:get/get.dart';

import '../helpers/report_helper.dart';
import '../models/transactions_model.dart';
import '../services/transactions_service.dart';

class TransactionListController extends GetxController {
  var isLoading = false.obs;

  String filterDate = "order_status=0";
  String orderstatus = "";
  int initialpage = 1;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  var alltransactions = TransactionsModel().obs;

  void fetchtransactions(int limit) async {
    try {
      isLoading(true);
      await TransactionsApi().fetchtransaction(initialpage, limit).then((
        value,
      ) {
        alltransactions.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
