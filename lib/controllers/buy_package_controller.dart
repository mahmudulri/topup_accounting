import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:topup_accounting/utils/colors.dart';
import '../utils/api_endpoints.dart';

class BuyPackageController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

  RxString packageID = ''.obs;

  RxBool isLoading = false.obs;

  final box = GetStorage();

  Future<void> requestnow() async {
    try {
      isLoading.value = true;

      var url = Uri.parse(ApiEndPoints.baseUrl + "package-requests/submit");

      print("API URL: $url");

      var body = {
        'full_name': nameController.text,
        'email': emailController.text,
        'phone_number': phoneController.text,
        'address': addressController.text,
        'date_of_birth': dateOfBirthController.text.trim(),
        'package_id': packageID.toString(),
      };

      var response = await http.post(url, body: body);

      print("Request Body: $body");

      final results = jsonDecode(response.body);

      print("Status Code: ${response.statusCode}");
      print("Response: ${response.body}");

      // ✅ API returns 201 (not 200)
      if (response.statusCode == 201) {
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
          emailController.clear();
          addressController.clear();
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
