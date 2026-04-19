import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:topup_accounting/utils/colors.dart';
import 'package:topup_accounting/widgets/custom_text.dart';
import '../controllers/collect_controller.dart';
import '../controllers/selltop_up_controller.dart';
import '../global_controllers/languages_controller.dart';

CollectController collectController = Get.put(CollectController());

class CollectSheet extends StatefulWidget {
  final String title;
  final String subtitle;
  final String resellerID;

  CollectSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.resellerID,
  });

  @override
  State<CollectSheet> createState() => _CollectSheetState();
}

class _CollectSheetState extends State<CollectSheet> {
  final languagesController = Get.find<LanguagesController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.blue.shade400,
                        size: 22,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title, // 🔥 dynamic
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            widget.subtitle, // 🔥 dynamic
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.black54),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                Divider(height: 24),

                SizedBox(height: 8),

                KText(
                  text: languagesController.tr("BASE_AMOUNT"),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8),
                TextField(
                  controller: collectController.baseAmountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '0.00',
                    prefixIcon: Icon(Icons.attach_money, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: AppColors.borderColor,
                        width: 1,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4),
                KText(
                  text: languagesController.tr(
                    "THIS_IS_THE_AMOUNT_YOU_PAY_TO_SUPPLIER",
                  ),
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),

                SizedBox(height: 16),

                KText(
                  text: languagesController.tr("PAID_AMOUNT"),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8),
                TextField(
                  controller: collectController.paidAmountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '0.00',
                    prefixIcon: Icon(Icons.attach_money, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: AppColors.borderColor,
                        width: 1,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4),
                KText(
                  text:
                      languagesController.tr("AMOUNT_PAID_NOW") +
                      "(${languagesController.tr("OPTIONAL")})",
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),

                SizedBox(height: 16),

                KText(
                  text:
                      languagesController.tr("REFERENCE_NUMBER") +
                      "(${languagesController.tr("OPTIONAL")})",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8),
                TextField(
                  controller: collectController.referenceController,
                  decoration: InputDecoration(
                    hintText: languagesController.tr("ENTER_REFERENCE_NUMBER"),
                    prefixIcon: Icon(
                      Icons.description_outlined,
                      color: Colors.grey,
                    ),

                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: AppColors.borderColor,
                        width: 1,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                KText(
                  text: languagesController.tr("NOTES"),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8),
                TextField(
                  controller: collectController.notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText:
                        languagesController.tr("ENTER_NOTES") +
                        "(${languagesController.tr("OPTIONAL")})",
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: AppColors.borderColor,
                        width: 1,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: KText(
                          text: languagesController.tr("CANCEL"),
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          collectController.resellerID.value =
                              widget.resellerID;

                          /// ❌ Supplier not selected

                          /// ❌ Base amount validation (must be valid number > 0)
                          final baseText = collectController
                              .baseAmountController
                              .text
                              .trim();

                          final base = double.tryParse(baseText);

                          if (baseText.isEmpty || base == null || base <= 0) {
                            Fluttertoast.showToast(
                              msg: "Enter valid base amount",
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                            );
                            return;
                          }

                          /// 🔶 Paid amount (optional but must be valid if entered)
                          final paidText = collectController
                              .paidAmountController
                              .text
                              .trim();

                          if (paidText.isNotEmpty) {
                            final paid = double.tryParse(paidText);

                            if (paid == null || paid < 0) {
                              Fluttertoast.showToast(
                                msg: "Invalid paid amount",
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                              );
                              return;
                            }
                          }

                          /// ✅ All good → controller handles remaining rules
                          collectController.sellNow();
                        },
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          size: 18,
                          color: Colors.white,
                        ),
                        label: Obx(
                          () => Text(
                            collectController.isLoading.value == false
                                ? languagesController.tr("CONFIRM_PURCHASE")
                                : languagesController.tr("PLEASE_WAIT"),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6ABFB0),
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
