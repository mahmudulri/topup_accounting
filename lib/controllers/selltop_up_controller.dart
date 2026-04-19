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

class SellTopUpController extends GetxController {
  RxString supplierID = ''.obs;
  RxString resellerID = ''.obs;

  RxDouble bonus = 0.0.obs;

  final TextEditingController baseAmountController = TextEditingController();
  final TextEditingController paidAmountController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  RxBool isLoading = false.obs;
  final box = GetStorage();

  final formatter = NumberFormat("#,##0.00", "en_US");

  String formatMoney(double value) {
    return formatter.format(value);
  }

  /// 🔥 Reactive values
  RxDouble baseAmount = 0.0.obs;
  RxDouble bonusAmount = 0.0.obs;
  RxDouble totalTopup = 0.0.obs;
  RxDouble paidAmount = 0.0.obs;
  RxDouble dueAmount = 0.0.obs;

  void calculate() {
    double base = double.tryParse(baseAmountController.text) ?? 0;
    double paid = double.tryParse(paidAmountController.text) ?? 0;

    baseAmount.value = base;

    /// Bonus
    bonusAmount.value = (base * bonus.value) / 100;

    /// Total
    totalTopup.value = base + bonusAmount.value;

    /// ❗ Prevent over payment
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

  /// 🚀 SELL TOPUP API
  Future<void> sellNow() async {
    try {
      isLoading.value = true;

      var url = Uri.parse(ApiEndPoints.baseUrl + "topup/reseller/sell");

      Map body = {
        'supplier_id': supplierID.value,
        'reseller_id': resellerID.value,
        'base_amount': baseAmountController.text,

        'paid_amount': paidAmountController.text.isEmpty
            ? "0"
            : paidAmountController.text,
        'reference_no': referenceController.text,
        'notes': notesController.text,
      };

      // print("SELL API URL: $url");
      // print("Request Body: $body");

      http.Response response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {
          'Authorization': 'Bearer ${box.read("userToken")}',
          'Content-Type': 'application/json',
        },
      );

      final results = jsonDecode(response.body);

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        /// ✅ Reset fields (FIXED BUG HERE)
        resetCalculation();
        baseAmount.value = 0.0;
        paidAmount.value = 0.0;
        bonusAmount.value = 0.0;
        totalTopup.value = 0.0;
        dueAmount.value = 0.0;

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

  void resetCalculation() {
    /// Clear text fields
    baseAmountController.clear();
    paidAmountController.clear();
    referenceController.clear();
    notesController.clear();

    /// Reset reactive values
    baseAmount.value = 0.0;
    bonusAmount.value = 0.0;
    totalTopup.value = 0.0;
    paidAmount.value = 0.0;
    dueAmount.value = 0.0;

    /// Optional: reset bonus যদি দরকার হয়
    // bonus.value = 0.0;
  }
}
