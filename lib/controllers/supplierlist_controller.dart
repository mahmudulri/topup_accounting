import 'package:get/get.dart';

import '../models/supplierlist_model.dart';
import '../services/supplierlist_service.dart';

class SupplierlistController extends GetxController {
  var isLoading = false.obs;

  var allsupplierlist = SuppliersListModel().obs;

  void fetchsupplierlist() async {
    try {
      isLoading(true);
      await SupplierlistApi().fetchsupplier().then((value) {
        allsupplierlist.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
