import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/ipdetails_model.dart';

class Myipcontroller extends GetxController {
  RxBool isLoading = false.obs;

  // ✅ null-safe reactive model
  Rxn<MyIpdetailsModel> myipdetails = Rxn<MyIpdetailsModel>();

  // ✅ input field controller
  RxString ipInput = "".obs;

  Future<void> fethmyipdata({String? ip}) async {
    try {
      isLoading.value = true;

      // 🔥 priority: parameter > input field > fallback
      final targetIp = ip ?? ipInput.value;

      if (targetIp.isEmpty) {
        Get.snackbar("Error", "Please enter an IP address");
        return;
      }

      final response = await http.get(
        Uri.parse("https://proxycheck.io/v3/$targetIp"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        myipdetails.value = MyIpdetailsModel.fromJson(data);
      } else {
        Get.snackbar("Error", "Failed to load data");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
