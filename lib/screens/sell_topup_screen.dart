import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:topup_accounting/models/resellerlist_model.dart';
import 'package:topup_accounting/widgets/default_button.dart';

import '../controllers/reseller_list_controller.dart';
import '../controllers/selltop_up_controller.dart';
import '../controllers/supplierlist_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../models/supplierlist_model.dart';
import '../utils/colors.dart';
import '../widgets/custom_text.dart';

class SellTopupScreen extends StatefulWidget {
  SellTopupScreen({super.key});

  @override
  State<SellTopupScreen> createState() => _SellTopupScreenState();
}

class _SellTopupScreenState extends State<SellTopupScreen> {
  final languagesController = Get.find<LanguagesController>();

  SupplierlistController supplierlistController = Get.put(
    SupplierlistController(),
  );

  ResellerListController resellerListController = Get.put(
    ResellerListController(),
  );

  SellTopUpController sellTopUpController = Get.put(SellTopUpController());

  final Rxn<Reseller> selectedReseller = Rxn<Reseller>();

  final Rxn<Supplier> selectedSupplier = Rxn<Supplier>();

  @override
  void initState() {
    super.initState();

    if (supplierlistController.allsupplierlist.value.suppliers == null) {
      supplierlistController.fetchsupplierlist();
    }
    if (resellerListController.allresellers.value.resellers == null) {
      resellerListController.fetchReseller();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.cardBg,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.cardBg,
          elevation: 0,
          title: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.white,
                  size: 17,
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: languagesController.tr("SELL_TOP_UP"),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.titleText,
                  ),
                  KText(
                    text: languagesController.tr(
                      "PURCHASE_TOPUP_FROM_SUPPLIER",
                    ),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.subtitleText,
                  ),
                ],
              ),
            ],
          ),
        ),

        /// 🔥 FULL BODY Obx
        body: Obx(() {
          /// 🔹 Loading state
          if (supplierlistController.isLoading.value &&
              resellerListController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          final suppliers =
              supplierlistController.allsupplierlist.value.suppliers ?? [];

          final resellers =
              resellerListController.allresellers.value.resellers ?? [];

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: ListView(
              children: [
                SizedBox(height: 10),
                KText(
                  text: languagesController.tr("SELECT_RESELLER"),
                  color: AppColors.labelText,
                  fontSize: 15,
                ),

                SizedBox(height: 8),

                /// 🔥 Dropdown
                Container(
                  height: 55,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true,
                      value: selectedReseller.value,
                      hint: KText(
                        text: languagesController.tr("CHOOSE_A_RESELLER"),
                        color: AppColors.labelText,
                      ),
                      icon: FaIcon(
                        FontAwesomeIcons.chevronDown,
                        size: 16,
                        color: AppColors.subtitleText,
                      ),

                      items: resellers.map((reseller) {
                        return DropdownMenuItem(
                          value: reseller,
                          child: Text(
                            reseller.name.toString() +
                                reseller.city.toString() +
                                "-( ${languagesController.tr("BONUS")} ${reseller.bonusPercentage} %)",
                            style: TextStyle(
                              color: AppColors.subtitleText,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),

                      /// 🔹 Select
                      onChanged: (value) {
                        selectedReseller.value = value;
                        print(value!.name);
                        sellTopUpController.resellerID.value = value.id
                            .toString();
                      },
                    ),
                  ),
                ),

                KText(
                  text: languagesController.tr("SELECT_SUPPLIER"),
                  color: AppColors.labelText,
                  fontSize: 15,
                ),

                SizedBox(height: 8),

                /// 🔥 Dropdown
                Container(
                  height: 55,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.borderColor),
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
                ),

                SizedBox(height: 8),

                KText(
                  text: languagesController.tr("BASE_AMOUNT"),
                  color: AppColors.labelText,
                  fontSize: 15,
                ),
                SizedBox(height: 8),
                Container(
                  height: 55,

                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: sellTopUpController.baseAmountController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "0.00",
                            hintStyle: TextStyle(color: AppColors.hintText),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                KText(
                  text: languagesController.tr(
                    "THIS_IS_THE_PAYMENT_YOU_PAY_TO_SUPPLIER",
                  ),
                  fontSize: 11,
                  color: AppColors.subtitleText,
                ),

                SizedBox(height: 8),

                KText(
                  text: languagesController.tr("PAID_AMOUNT"),
                  color: AppColors.labelText,
                  fontSize: 15,
                ),
                SizedBox(height: 8),
                Container(
                  height: 55,

                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: sellTopUpController.paidAmountController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "0.00",
                            hintStyle: TextStyle(color: AppColors.hintText),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                KText(
                  text:
                      languagesController.tr("AMOUNT_PAID_NOW") +
                      " " +
                      "(${languagesController.tr("OPTIONAL")})",
                  fontSize: 11,
                  color: AppColors.subtitleText,
                ),
                SizedBox(height: 8),

                KText(
                  text: languagesController.tr("REFERENCE_NUMBER"),

                  color: AppColors.labelText,
                  fontSize: 15,
                ),
                SizedBox(height: 8),
                Container(
                  height: 55,

                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: sellTopUpController.referenceController,
                          decoration: InputDecoration(
                            hintText:
                                languagesController.tr(
                                  "ENTER_REFERENCE_NUMBER",
                                ) +
                                " " +
                                "(${languagesController.tr("OPTIONAL")})",
                            hintStyle: TextStyle(
                              color: AppColors.hintText,
                              fontSize: 13,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8),

                KText(
                  text: languagesController.tr("NOTES"),
                  color: AppColors.labelText,
                  fontSize: 15,
                ),
                SizedBox(height: 8),
                Container(
                  height: 100,

                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: sellTopUpController.notesController,
                          maxLines: 10,
                          decoration: InputDecoration(
                            hintText:
                                languagesController.tr("ENTER_NOTES") +
                                " " +
                                "(${languagesController.tr("OPTIONAL")})",
                            hintStyle: TextStyle(
                              color: AppColors.hintText,
                              fontSize: 13,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                Obx(
                  () => DefaultButton(
                    buttonName: sellTopUpController.isLoading.value == false
                        ? languagesController.tr("CONFIRM_PURCHASE")
                        : languagesController.tr("PLEASE_WAIT"),
                    mycolor: AppColors.primaryColor.withValues(alpha: 0.70),
                    textColor: Colors.white,
                    fontsize: 15,
                    onpressed: () {
                      print(sellTopUpController.resellerID.value);
                      print(sellTopUpController.supplierID.value);
                      print(
                        sellTopUpController.baseAmountController.text
                            .toString(),
                      );
                      print(
                        sellTopUpController.paidAmountController.text
                            .toString(),
                      );
                      print(
                        sellTopUpController.referenceController.text.toString(),
                      );
                      print(
                        sellTopUpController.notesController.text.toString(),
                      );
                      sellTopUpController.sellNow();
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
