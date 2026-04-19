import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:topup_accounting/utils/colors.dart';

import '../global_controllers/languages_controller.dart';
import '../utils/api_endpoints.dart';

final languagesController = Get.find<LanguagesController>();

class CollectController extends GetxController {
  RxString supplierID = ''.obs;
  RxString resellerID = ''.obs;

  RxDouble bonus = 0.0.obs;

  final TextEditingController baseAmountController = TextEditingController();
  final TextEditingController paidAmountController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  RxBool isLoading = false.obs;
  final box = GetStorage();

  Future<void> sellNow() async {
    try {
      isLoading.value = true;

      var url = Uri.parse(ApiEndPoints.baseUrl + "topup/reseller/payment");

      Map body = {
        'reseller_id': resellerID.value,
        'amount': baseAmountController.text,
        'reference_no': referenceController.text,
        'notes': notesController.text,
      };

      print("SELL API URL: $url");
      print("Request Body: $body");

      http.Response response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {
          'Authorization': 'Bearer ${box.read("userToken")}',
          'Content-Type': 'application/json',
        },
      );

      final results = jsonDecode(response.body);

      // print("Response Code: ${response.statusCode}");
      // print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        baseAmountController.clear();
        paidAmountController.clear();
        referenceController.clear();
        notesController.clear();

        if (results["success"] == true) {
          Fluttertoast.showToast(
            gravity: ToastGravity.CENTER,
            msg: results["message"],
            backgroundColor: AppColors.primaryColor,
            textColor: Colors.white,
          );
        } else {
          Get.snackbar(
            "Error",
            results["message"],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          results["message"],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Sell Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
