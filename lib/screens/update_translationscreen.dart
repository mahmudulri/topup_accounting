import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global_controllers/languages_controller.dart';
import '../utils/colors.dart';

class TranslationEditPage extends StatefulWidget {
  const TranslationEditPage({super.key});

  @override
  State<TranslationEditPage> createState() => _TranslationEditPageState();
}

class _TranslationEditPageState extends State<TranslationEditPage> {
  final controller = Get.find<LanguagesController>();
  final RxString searchText = "".obs;
  final Map<String, TextEditingController> textControllers = {};

  List<String> get filteredKeys {
    final query = searchText.value.toLowerCase();
    return controller.currentlanguage.keys.where((key) {
      final value = controller.tr(key).toLowerCase();
      return key.toLowerCase().contains(query) || value.contains(query);
    }).toList();
  }

  TextEditingController getController(String key, String value) {
    if (!textControllers.containsKey(key)) {
      textControllers[key] = TextEditingController(text: value);
    }
    return textControllers[key]!;
  }

  @override
  void dispose() {
    for (var c in textControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBg,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: AppColors.fontColor,
          title: const Text(
            "Edit Translations",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.fontColor,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: AppColors.cardBg,
                      title: const Text(
                        "Reset Translations?",
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      content: const Text(
                        "This will revert all translations to their original values. This action cannot be undone.",
                        style: TextStyle(color: AppColors.fontColor2),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: AppColors.fontColor2),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);

                            setState(() {
                              controller.resetTranslations();
                              textControllers.clear();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Translations reset"),
                                duration: Duration(seconds: 2),
                                backgroundColor: AppColors.primaryColor,
                              ),
                            );
                          },
                          child: const Text(
                            "Reset",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  "Reset",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            /// 🔍 SEARCH BAR
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                onChanged: (val) => searchText.value = val,
                style: const TextStyle(color: AppColors.fontColor),
                decoration: InputDecoration(
                  hintText: "Search key or value...",
                  hintStyle: const TextStyle(color: AppColors.hintText),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.fontColor2,
                  ),
                  filled: true,
                  fillColor: AppColors.cardBg,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

            /// 📋 LIST
            Expanded(
              child: Obx(() {
                final keys = filteredKeys;

                if (keys.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 56,
                          color: AppColors.fontColor2.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No results found",
                          style: TextStyle(
                            color: AppColors.fontColor2.withOpacity(0.6),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    final key = keys[index];
                    final value = controller.tr(key);
                    final textController = getController(key, value);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cardShadow.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// 🔑 KEY
                            Text(
                              key,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.fontColor2,
                                letterSpacing: 0.3,
                              ),
                            ),

                            const SizedBox(height: 10),

                            /// ✏️ VALUE EDIT
                            TextField(
                              controller: textController,
                              onSubmitted: (newValue) {
                                controller.updateTranslation(key, newValue);
                                FocusScope.of(context).unfocus();
                              },
                              onChanged: (newValue) {
                                controller.updateTranslation(key, newValue);
                              },
                              style: const TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                hintText: "Enter translation",
                                hintStyle: const TextStyle(
                                  color: AppColors.hintText,
                                ),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                filled: true,
                                fillColor: AppColors.fieldBg,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColors.borderColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColors.borderColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColors.primaryColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
