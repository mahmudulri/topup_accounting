import 'package:get/get.dart';

import '../models/transactions_model.dart';
import '../services/transactions_service.dart';

class TransactionListController extends GetxController {
  var isLoading = false.obs;

  var alltransactions = TransactionsModel().obs;

  void fetchtransactions() async {
    try {
      isLoading(true);
      await TransactionsApi().fetchtransaction().then((value) {
        alltransactions.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
