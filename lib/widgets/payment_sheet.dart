import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:topup_accounting/utils/colors.dart';
import 'package:topup_accounting/widgets/custom_text.dart';
import '../controllers/collect_controller.dart';
import '../controllers/paydue_controller.dart';
import '../controllers/selltop_up_controller.dart';
import '../global_controllers/languages_controller.dart';

PaydueController paydueController = Get.put(PaydueController());

class PaymentSheet extends StatefulWidget {
  final String title;
  final String subtitle;
  final String resellerID;
  final String totalDue;

  PaymentSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.resellerID,
    required this.totalDue,
  });

  @override
  State<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
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
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(20),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: languagesController.tr("TOTAL_DUE"),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                        Text(
                          widget.totalDue.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16),

                KText(
                  text: languagesController.tr("PAYMENT_AMOUNT"),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8),
                TextField(
                  controller: paydueController.amountController,
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
                      languagesController.tr("MAX_AMOUNT") +
                      " : " +
                      "${widget.totalDue}",
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
                  controller: paydueController.referenceController,
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
                  controller: paydueController.notesController,
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
                          paydueController.supplierID.value = widget.resellerID;

                          /// ❌ Supplier not selected

                          /// ❌ Base amount validation (must be valid number > 0)
                          final baseText = paydueController
                              .amountController
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

                          /// ✅ All good → controller handles remaining rules
                          paydueController.paynow();
                        },
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          size: 18,
                          color: Colors.white,
                        ),
                        label: Obx(
                          () => Text(
                            paydueController.isLoading.value == false
                                ? languagesController.tr("CONFIRM_PAYMENT")
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
