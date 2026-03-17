import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../global_controllers/languages_controller.dart';

class LanguagePickerDropdown extends StatelessWidget {
  const LanguagePickerDropdown({
    required this.languagesController,
    required this.box,
    required this.onLanguageSelected,
  });

  final LanguagesController languagesController;
  final GetStorage box;
  final void Function(
    String name,
    String isoCode,
    String regionCode,
    String direction,
  )
  onLanguageSelected;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentLang = languagesController.selectedlan.value;

      return Container(
        width: 210,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: languagesController.alllanguagedata.map((data) {
            final name = data["name"]!;
            final fullname = data["fullname"]!;
            final isoCode = data["isoCode"]!;
            final region = data["region"]!;
            final direction = data["direction"]!;
            final isSelected = currentLang == name;

            return GestureDetector(
              onTap: () => onLanguageSelected(name, isoCode, region, direction),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF2DC9A3)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    // Region badge  e.g. "US", "IR", "AF"
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withOpacity(0.25)
                            : const Color(0xFFEEF2F5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        region,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF3A4358),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Full language name
                    Expanded(
                      child: Text(
                        fullname,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF3A4358),
                        ),
                      ),
                    ),

                    // Check icon for selected
                    if (isSelected)
                      const Icon(Icons.check, color: Colors.white, size: 16),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
