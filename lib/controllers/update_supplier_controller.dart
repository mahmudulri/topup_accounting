import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:topup_accounting/utils/colors.dart';
import '../utils/api_endpoints.dart';
import 'supplierlist_controller.dart';

SupplierlistController supplierlistController = Get.put(
  SupplierlistController(),
);

class UpdateSupplierController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController bonusController = TextEditingController();

  RxBool isLoading = false.obs;

  final box = GetStorage();

  Future<void> updatenow(String supplierID) async {
    try {
      isLoading.value = true;

      var url = Uri.parse(ApiEndPoints.baseUrl + "suppliers/$supplierID");

      print("API URL: $url");

      var body = {
        'name': nameController.text,
        'phone': phoneController.text,
        'company': companyController.text,
        'bonus_percentage': bonusController.text,
      };

      var response = await http.put(
        url,
        body: body,
        headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
      );

      print("Request Body: $body");

      final results = jsonDecode(response.body);

      print("Status Code: ${response.statusCode}");
      print("Response: ${response.body}");

      // ✅ API returns 201 (not 200)
      if (response.statusCode == 200) {
        supplierlistController.fetchsupplierlist();
        if (results["status"] == true) {
          Fluttertoast.showToast(
            msg: results["message"],
            backgroundColor: AppColors.primaryColor,
            textColor: Colors.white,
            gravity: ToastGravity.CENTER,
          );

          // Optional: clear fields
          nameController.clear();
          phoneController.clear();
          companyController.clear();
          bonusController.clear();
        } else {
          _showError(results);
        }
      } else {
        _showError(results);
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}

/// ✅ Handles both String and Map error formats
void _showError(dynamic results) {
  String errorMessage = "Login failed";

  if (results["errors"] is String) {
    errorMessage = results["errors"];
  } else if (results["errors"] is Map) {
    // Extract first validation message
    final errorsMap = results["errors"] as Map;
    if (errorsMap.isNotEmpty) {
      final firstError = errorsMap.values.first;
      if (firstError is List && firstError.isNotEmpty) {
        errorMessage = firstError.first.toString();
      }
    }
  }

  Get.snackbar(
    results["message"] ?? "Error",
    errorMessage,
    backgroundColor: Colors.red,
    colorText: Colors.white,
  );
}
