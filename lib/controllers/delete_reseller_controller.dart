import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:topup_accounting/utils/colors.dart';
import '../utils/api_endpoints.dart';
import 'reseller_list_controller.dart';

ResellerListController resellerListController = Get.put(
  ResellerListController(),
);

class DeleteResellerController extends GetxController {
  RxBool isLoading = false.obs;

  final box = GetStorage();

  Future<void> deletenow(String id) async {
    try {
      isLoading.value = true;

      var url = Uri.parse(ApiEndPoints.baseUrl + "resellers/$id");

      print("API URL: $url");

      var response = await http.delete(
        url,

        headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
      );

      final results = jsonDecode(response.body);

      print("Status Code: ${response.statusCode}");
      print("Response: ${response.body}");

      // ✅ API returns 201 (not 200)
      if (response.statusCode == 200) {
        resellerListController.fetchReseller();
        if (results["status"] == true) {
          Fluttertoast.showToast(
            msg: results["message"],
            backgroundColor: AppColors.primaryColor,
            textColor: Colors.white,
            gravity: ToastGravity.CENTER,
          );
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
