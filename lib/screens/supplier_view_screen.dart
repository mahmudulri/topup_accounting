import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topup_accounting/helpers/compactnumber_helpder.dart';

import '../controllers/supplier_details_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../utils/colors.dart';
import '../widgets/custom_text.dart';
import '../widgets/supplier_balance_widget.dart';

class SupplierViewScreen extends StatefulWidget {
  String? supplierID;
  String? status;
  String? name;
  String? company;
  String? totalPurchase;
  String? totalDue;
  String? totalPaid;
  String? currentStock;
  SupplierViewScreen({
    super.key,
    this.supplierID,
    this.status,
    this.name,
    this.company,
    this.totalPurchase,
    this.totalDue,
    this.totalPaid,
    this.currentStock,
  });

  @override
  State<SupplierViewScreen> createState() => _SupplierViewScreenState();
}

class _SupplierViewScreenState extends State<SupplierViewScreen> {
  final languagesController = Get.find<LanguagesController>();

  SupplierDetailsController supplierDetailsController = Get.put(
    SupplierDetailsController(),
  );

  @override
  void initState() {
    super.initState();
    supplierDetailsController.fetchsupplierDetails(
      widget.supplierID.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
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
                  Row(
                    children: [
                      KText(
                        text: widget.name.toString(),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.titleText,
                      ),
                      SizedBox(width: 4),
                      Container(
                        height: 30,

                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 13,
                                color: Colors.green,
                              ),
                              SizedBox(width: 4),
                              KText(
                                text: languagesController.tr("ACTIVE"),
                                color: Colors.green,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  KText(
                    text: widget.company.toString(),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleText,
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.4,
                  children: [
                    // Total Purchase
                    SupplierBalancCard(
                      icon: Icons.inventory_2_outlined,
                      iconColor: const Color(0xFF5B8DEF),
                      iconBgColor: const Color(0xFFEEF4FF),
                      value: formatCompactNumber(
                        double.parse(widget.totalPurchase.toString()),
                      ),
                      sub: languagesController.tr("TOTAL_PURCHASE"),
                      label: languagesController.tr("TRANSACTIONS"),
                      bottomRight: '80.0%',
                      bottomRightColor: AppColors.primaryColor,
                      subvalue: "00",
                    ),

                    // Total Due
                    SupplierBalancCard(
                      icon: Icons.trending_down_rounded,
                      iconColor: const Color(0xFFFF6B6B),
                      iconBgColor: const Color(0xFFFFEEEE),
                      value: widget.totalDue.toString(),
                      sub: languagesController.tr("TOTAL_DUE"),
                      label: languagesController.tr("PENDING"),
                      badge: languagesController.tr("HIGH_DUE"),
                      badgeColor: const Color(0xFFFF9800),
                      badgeIcon: Icons.warning_amber_rounded,
                      subvalue: "00",
                    ),

                    // Total Paid
                    SupplierBalancCard(
                      icon: Icons.trending_up_rounded,
                      iconColor: AppColors.primaryColor,
                      iconBgColor: const Color(0xFFE8FBF5),
                      value: formatCompactNumber(
                        double.parse(widget.totalPaid.toString()),
                      ),
                      sub: languagesController.tr("TOTAL_PAID"),
                      label: languagesController.tr("PAID"),
                      subvalue: "00",
                    ),

                    // Current Stock
                    SupplierBalancCard(
                      icon: Icons.trending_up_rounded,
                      iconColor: AppColors.primaryColor,
                      iconBgColor: const Color(0xFFE8FBF5),
                      value: formatCompactNumber(
                        double.parse(widget.currentStock.toString()),
                      ),
                      sub: languagesController.tr("CURRENT_STOCK"),
                      label: languagesController.tr("WORTH"),
                      subvalue: "00",
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 500,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1, color: AppColors.scaffoldBg),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        // 🔹 Tab Bar
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                          child: TabBar(
                            labelColor: AppColors.primaryColor,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: AppColors.primaryColor,
                            tabs: [
                              Tab(text: languagesController.tr("OVERVIEW")),
                              Tab(text: languagesController.tr("TRANSACTIONS")),
                              Tab(text: languagesController.tr("ANALYTICS")),
                            ],
                          ),
                        ),

                        // 🔹 Tab Views
                        Expanded(
                          child: TabBarView(
                            children: [
                              ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 200,
                                      width: screenWidth,
                                      decoration: BoxDecoration(
                                        color: AppColors.cardBg,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          width: 1,
                                          color: AppColors.scaffoldBg,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.05,
                                            ),
                                            blurRadius: 12,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Transactions Tab
                              Center(
                                child: KText(
                                  text: languagesController.tr("TRANSACTIONS"),
                                ),
                              ),

                              // Analytics Tab
                              Center(
                                child: KText(
                                  text: languagesController.tr("ANALYTICS"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
