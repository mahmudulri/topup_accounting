import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final box = GetStorage();

  RxBool isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved preference
    isDark.value = box.read("isDark") ?? false;
    _applyTheme();
  }

  void toggleTheme() {
    isDark.value = !isDark.value;
    box.write("isDark", isDark.value);
    _applyTheme();
  }

  void _applyTheme() {
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }
}
