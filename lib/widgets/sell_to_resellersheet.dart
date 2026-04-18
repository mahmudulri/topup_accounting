import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:topup_accounting/utils/colors.dart';
import 'package:topup_accounting/widgets/custom_text.dart';

import '../controllers/buytop_up_controller.dart';
import '../controllers/selltop_up_controller.dart';
import '../controllers/supplierlist_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../models/supplierlist_model.dart';

SellTopUpController sellTopUpController = Get.put(SellTopUpController());

SupplierlistController supplierlistController = Get.put(
  SupplierlistController(),
);

final Rxn<Supplier> selectedSupplier = Rxn<Supplier>();

class SellToResellersheet extends StatefulWidget {
  final String title;
  final String subtitle;
  final String supplierID;

  SellToResellersheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.supplierID,
  });

  @override
  State<SellToResellersheet> createState() => _SellToResellersheetState();
}

class _SellToResellersheetState extends State<SellToResellersheet> {
  final languagesController = Get.find<LanguagesController>();

  @override
  void initState() {
    super.initState();

    if (supplierlistController.allsupplierlist.value.suppliers == null) {
      supplierlistController.fetchsupplierlist();
    }
  }

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

                KText(
                  text: languagesController.tr("SELECT_SUPPLIER"),
                  color: AppColors.labelText,
                  fontSize: 15,
                ),

                SizedBox(height: 8),

                /// 🔥 Dropdown
                Obx(() {
                  if (supplierlistController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final suppliers =
                      supplierlistController.allsupplierlist.value.suppliers ??
                      [];
                  return Container(
                    height: 55,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.borderColor,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        value: selectedSupplier.value,
                        hint: KText(
                          text: languagesController.tr("CHOOSE_A_SUPPLIER"),
                          color: AppColors.labelText,
                        ),
                        icon: FaIcon(
                          FontAwesomeIcons.chevronDown,
                          size: 16,
                          color: AppColors.subtitleText,
                        ),

                        items: suppliers.map((supplier) {
                          return DropdownMenuItem(
                            value: supplier,
                            child: Text(
                              supplier.name.toString() +
                                  "( ${languagesController.tr("BONUS")} ${supplier.bonusPercentage.toString()} % )- ${languagesController.tr("STOCK")}- ${supplier.currentStock}",
                              style: TextStyle(
                                color: AppColors.subtitleText,
                                fontSize: 13,
                              ),
                            ),
                          );
                        }).toList(),

                        /// 🔹 Select
                        onChanged: (value) {
                          selectedSupplier.value = value;
                          print(value!.name);
                          sellTopUpController.supplierID.value = value.id
                              .toString();
                        },
                      ),
                    ),
                  );
                }),
                SizedBox(height: 8),

                KText(
                  text: languagesController.tr("BASE_AMOUNT"),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8),
                TextField(
                  controller: sellTopUpController.baseAmountController,
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
                  controller: sellTopUpController.paidAmountController,
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
                  controller: sellTopUpController.referenceController,
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
                  controller: sellTopUpController.notesController,
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
                          sellTopUpController.supplierID.value =
                              widget.supplierID;

                          /// ❌ Supplier not selected

                          /// ❌ Base amount validation (must be valid number > 0)
                          final baseText = sellTopUpController
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
                          final paidText = sellTopUpController
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
                          sellTopUpController.sellNow();
                        },
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          size: 18,
                          color: Colors.white,
                        ),
                        label: Obx(
                          () => Text(
                            sellTopUpController.isLoading.value == false
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
