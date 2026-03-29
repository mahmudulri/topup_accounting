import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:topup_accounting/utils/colors.dart';

import '../global_controllers/languages_controller.dart';
import '../utils/api_endpoints.dart';

final languagesController = Get.find<LanguagesController>();

class BuytopUpController extends GetxController {
  RxString supplierID = ''.obs;

  RxDouble bonus = 0.0.obs;

  final TextEditingController baseAmountController = TextEditingController();
  final TextEditingController paidAmountController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  RxBool isLoading = false.obs;
  final box = GetStorage();

  String formatMoney(double value) {
    return formatter.format(value);
  }

  /// 🔥 NEW reactive values
  RxDouble baseAmount = 0.0.obs;
  RxDouble bonusAmount = 0.0.obs;
  RxDouble totalTopup = 0.0.obs;
  RxDouble paidAmount = 0.0.obs;
  RxDouble dueAmount = 0.0.obs;

  final formatter = NumberFormat("#,##0.00", "en_US");

  void calculate() {
    double base = double.tryParse(baseAmountController.text) ?? 0;
    double paid = double.tryParse(paidAmountController.text) ?? 0;

    baseAmount.value = base;

    /// Bonus
    bonusAmount.value = (base * bonus.value) / 100;

    /// Total
    totalTopup.value = base + bonusAmount.value;

    /// ❗ If exceeds → show message + fix
    if (paid > totalTopup.value && totalTopup.value > 0) {
      Fluttertoast.showToast(
        msg: languagesController.tr("PAID_AMOUNT_CAN'T_EXCEED_TOTAL_TOPUP"),
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      paid = totalTopup.value;

      paidAmountController.text = paid.toStringAsFixed(2);

      paidAmountController.selection = TextSelection.fromPosition(
        TextPosition(offset: paidAmountController.text.length),
      );
    }

    paidAmount.value = paid;

    /// Due
    dueAmount.value = totalTopup.value - paid;
  }

  Future<void> buynow() async {
    try {
      isLoading.value = true;

      var url = Uri.parse(ApiEndPoints.baseUrl + "topup/supplier/buy");
      print("API URL: $url");

      Map body = {
        'supplier_id': supplierID.value,
        'base_amount': baseAmountController.text,
        'paid_amount': paidAmountController.text,
        'reference_no': referenceController.text,
        'notes': notesController.text,
      };

      print("Request Body: $body");

      http.Response response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {
          'Authorization': 'Bearer ${box.read("userToken")}',
          'Content-Type': 'application/json', // ✅ IMPORTANT
        },
      );

      final results = jsonDecode(response.body);
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        baseAmount.value == 0.0;
        baseAmountController.clear();
        paidAmount.value == 0.0;
        paidAmountController.clear();
        referenceController.clear();
        notesController.clear();
        if (results["success"] == true) {
          Fluttertoast.showToast(
            msg: results["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,

            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          // Fetch country data only if login is successful
        } else {
          Get.snackbar(
            results["success"] ?? "Error",
            results["message"],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          results["success"] ?? "Error",
          results["message"],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Error during sign in: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
