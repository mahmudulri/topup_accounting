import 'package:get/get.dart';

import '../models/supplier_details_model.dart';
import '../models/supplierlist_model.dart';
import '../services/supplier_details_service.dart';
import '../services/supplierlist_service.dart';

class SupplierDetailsController extends GetxController {
  var isLoading = false.obs;

  var supplierDetails = SupplierDetailsModel().obs;

  void fetchsupplierDetails(String ID) async {
    try {
      isLoading(true);
      await SupplierDetailsApi().fetchDetails(ID).then((value) {
        supplierDetails.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
