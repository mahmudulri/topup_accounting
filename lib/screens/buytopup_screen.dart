import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:topup_accounting/widgets/default_button.dart';
import 'package:intl/intl.dart';
import '../controllers/buytop_up_controller.dart';
import '../controllers/supplierlist_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../models/supplierlist_model.dart';
import '../utils/colors.dart';
import '../widgets/custom_text.dart';

class BuytopupScreen extends StatefulWidget {
  BuytopupScreen({super.key});

  @override
  State<BuytopupScreen> createState() => _BuytopupScreenState();
}

class _BuytopupScreenState extends State<BuytopupScreen> {
  final languagesController = Get.find<LanguagesController>();

  SupplierlistController supplierlistController = Get.put(
    SupplierlistController(),
  );

  BuytopUpController buytopUpController = Get.put(BuytopUpController());

  final Rxn<Supplier> selectedSupplier = Rxn<Supplier>();

  @override
  void initState() {
    super.initState();

    if (supplierlistController.allsupplierlist.value.suppliers == null) {
      supplierlistController.fetchsupplierlist();
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
                    text: languagesController.tr("BUY_TOP_UP"),
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
          if (supplierlistController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          final suppliers =
              supplierlistController.allsupplierlist.value.suppliers ?? [];

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: ListView(
              children: [
                SizedBox(height: 10),

                /// 🔹 Title
                GestureDetector(
                  onTap: () {
                    print(buytopUpController.bonus.toString());
                  },
                  child: KText(
                    text: languagesController.tr("SELECT_SUPPLIER"),
                    color: AppColors.labelText,
                    fontSize: 15,
                  ),
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
                                " Bonus (${supplier.bonusPercentage.toString()} % )",
                            style: TextStyle(color: AppColors.subtitleText),
                          ),
                        );
                      }).toList(),

                      /// 🔹 Select
                      onChanged: (value) {
                        selectedSupplier.value = value;
                        print(value!.name);

                        buytopUpController.bonus.value = value.bonusPercentage!
                            .toDouble();

                        buytopUpController.calculate();
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
                          onChanged: (value) {
                            buytopUpController.calculate();
                          },
                          controller: buytopUpController.baseAmountController,
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
                          controller: buytopUpController.paidAmountController,
                          onChanged: (value) {
                            buytopUpController.calculate();
                          },
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

                SizedBox(height: 8),
                Obx(() {
                  if (buytopUpController.baseAmount.value == 0) {
                    return SizedBox();
                  }

                  return Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: KText(
                            text: "Live Calculation",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 8),

                        _row(
                          "Base Amount",
                          buytopUpController.baseAmount.value,
                        ),
                        _row(
                          "Bonus (${buytopUpController.bonus.value}%)",
                          buytopUpController.bonusAmount.value,
                          isPlus: true,
                        ),
                        _row(
                          "Total Topup",
                          buytopUpController.totalTopup.value,
                        ),
                        _row(
                          "Paid Now",
                          buytopUpController.paidAmount.value,
                          isMinus: true,
                        ),
                        _row(
                          "Due to Supplier",
                          buytopUpController.dueAmount.value,
                        ),
                      ],
                    ),
                  );
                }),

                SizedBox(height: 30),

                DefaultButton(
                  buttonName: languagesController.tr("CONFIRM_PURCHASE"),
                  mycolor: AppColors.primaryColor.withValues(alpha: 0.70),
                  textColor: Colors.white,
                  fontsize: 15,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _row(
    String title,
    double amount, {
    bool isPlus = false,
    bool isMinus = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KText(text: title, color: Colors.white),

          KText(
            text:
                "${isPlus
                    ? "+"
                    : isMinus
                    ? "-"
                    : ""}${buytopUpController.formatMoney(amount)}",
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
