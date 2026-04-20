import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:topup_accounting/controllers/reseller_list_controller.dart';
import 'package:topup_accounting/controllers/supplierlist_controller.dart';

import '../utils/api_endpoints.dart';

ResellerListController resellerListController = Get.put(
  ResellerListController(),
);

SupplierlistController supplierlistController = Get.put(
  SupplierlistController(),
);

class StatusController extends GetxController {
  RxBool isLoading = false.obs;
  final box = GetStorage();

  Future<void> changeStatus({
    required String type, // suppliers বা resellers
    required String id,
  }) async {
    try {
      isLoading.value = true;

      final url = Uri.parse("${ApiEndPoints.baseUrl}$type/$id/status");
      print(url);

      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer ${box.read("userToken")}',
          "Content-Type": "application/json",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (type == "suppliers") {
          supplierlistController.fetchsupplierlist();
        }
        resellerListController.fetchReseller();

        Get.snackbar("Success", data["message"] ?? "Status updated");
      } else {
        Get.snackbar("Error", data["message"] ?? "Failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
