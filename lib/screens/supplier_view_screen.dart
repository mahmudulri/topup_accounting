import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topup_accounting/helpers/compactnumber_helpder.dart';
import 'package:topup_accounting/helpers/localtime_helper.dart';
import '../controllers/supplier_details_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../utils/colors.dart';
import '../widgets/custom_text.dart';
import '../widgets/supplier_balance_widget.dart';
import '../widgets/timeago_helper.dart';

class SupplierViewScreen extends StatefulWidget {
  String? supplierID;
  String? status;
  String? name;
  String? company;
  String? totalPurchase;
  String? totalDue;
  String? totalPaid;
  String? currentStock;
  String? phone;
  String? created;
  String? bonus;
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
    this.phone,
    this.created,
    this.bonus,
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
                      value: formatCompactNumber(
                        double.parse(widget.totalDue.toString()),
                      ),
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
                  child: Obx(
                    () => supplierDetailsController.isLoading.value == false
                        ? DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                // 🔹 Tab Bar
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                  ),
                                  child: TabBar(
                                    labelColor: AppColors.primaryColor,
                                    unselectedLabelColor: Colors.grey,
                                    indicatorColor: AppColors.primaryColor,
                                    labelStyle: TextStyle(fontSize: 12),
                                    tabs: [
                                      Tab(
                                        text: languagesController.tr(
                                          "OVERVIEW",
                                        ),
                                      ),
                                      Tab(
                                        text: languagesController.tr(
                                          "TRANSACTIONS",
                                        ),
                                      ),
                                      // Tab(
                                      //   text: languagesController.tr(
                                      //     "ANALYTICS",
                                      //   ),
                                      // ),
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
                                              width: screenWidth,
                                              decoration: BoxDecoration(
                                                color: AppColors.cardBg,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                  width: 1,
                                                  color: AppColors.scaffoldBg,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.05),
                                                    blurRadius: 12,
                                                    offset: Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  16,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Title
                                                    KText(
                                                      text: languagesController
                                                          .tr(
                                                            "CONTACT_INFORMATION",
                                                          ),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.bodyText,
                                                    ),
                                                    SizedBox(height: 12),

                                                    // Phone Row
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor:
                                                              AppColors
                                                                  .primaryColor
                                                                  .withValues(
                                                                    alpha: 0.12,
                                                                  ),
                                                          child: Icon(
                                                            Icons.call,
                                                            size: 16,
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            KText(
                                                              text:
                                                                  languagesController
                                                                      .tr(
                                                                        "PHONE",
                                                                      ),
                                                              fontSize: 12,
                                                              color: AppColors
                                                                  .bodyText,
                                                            ),
                                                            Text(
                                                              widget.phone
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12),

                                                    Divider(
                                                      height: 1,
                                                      color:
                                                          AppColors.scaffoldBg,
                                                    ),
                                                    SizedBox(height: 12),

                                                    // Company Row
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor:
                                                              AppColors
                                                                  .primaryColor
                                                                  .withValues(
                                                                    alpha: 0.12,
                                                                  ),
                                                          child: Icon(
                                                            Icons.business,
                                                            size: 16,
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            KText(
                                                              text: languagesController
                                                                  .tr(
                                                                    "COMPANY",
                                                                  ),
                                                              fontSize: 12,
                                                              color: AppColors
                                                                  .bodyText,
                                                            ),
                                                            Text(
                                                              widget.company
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12),

                                                    Divider(
                                                      height: 1,
                                                      color:
                                                          AppColors.scaffoldBg,
                                                    ),
                                                    SizedBox(height: 12),

                                                    // Member Since & Bonus Row
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 16,
                                                                backgroundColor: AppColors
                                                                    .primaryColor
                                                                    .withValues(
                                                                      alpha:
                                                                          0.12,
                                                                    ),
                                                                child: Icon(
                                                                  Icons
                                                                      .calendar_today,
                                                                  size: 14,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  KText(
                                                                    text: languagesController.tr(
                                                                      "MEMBER_SINCE",
                                                                    ),
                                                                    fontSize:
                                                                        12,
                                                                    color: AppColors
                                                                        .bodyText,
                                                                  ),
                                                                  Text(
                                                                    convertToDate(
                                                                      widget
                                                                          .created
                                                                          .toString(),
                                                                    ),
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 16,
                                                                backgroundColor: AppColors
                                                                    .primaryColor
                                                                    .withValues(
                                                                      alpha:
                                                                          0.12,
                                                                    ),
                                                                child: Icon(
                                                                  Icons
                                                                      .star_rounded,
                                                                  size: 14,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  KText(
                                                                    text:
                                                                        languagesController.tr(
                                                                          "BONUS",
                                                                        ) +
                                                                        " % ",
                                                                    fontSize:
                                                                        12,
                                                                    color: AppColors
                                                                        .bodyText,
                                                                  ),
                                                                  Text(
                                                                    widget.bonus
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Transactions Tab
                                      ListView.builder(
                                        itemCount: supplierDetailsController
                                            .supplierDetails
                                            .value
                                            .allTransactions!
                                            .data!
                                            .length,
                                        itemBuilder: (context, index) {
                                          final data = supplierDetailsController
                                              .supplierDetails
                                              .value
                                              .allTransactions!
                                              .data![index];

                                          // Static sample data — replace with real fields from `data`
                                          final bool isPurchase =
                                              index % 2 ==
                                              0; // replace with: data.type == 'purchase'
                                          final String title =
                                              data.transactionType.toString() ==
                                                  "purchase"
                                              ? 'Purchase'
                                              : 'Payment';
                                          final String amount = isPurchase
                                              ? '-\$20,000'
                                              : '+\$500';
                                          final String? paidAmount = isPurchase
                                              ? 'Paid: \$13,000'
                                              : null;
                                          final Color amountColor = isPurchase
                                              ? Colors.red
                                              : Colors.green;
                                          final Color iconBgColor = isPurchase
                                              ? const Color(0xFFDCE8FF)
                                              : const Color(0xFFFFEDD8);
                                          final IconData icon = isPurchase
                                              ? Icons.south_west
                                              : Icons.north_east;
                                          final Color iconColor = isPurchase
                                              ? Colors.blue
                                              : Colors.orange;

                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 14,
                                            ),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Color(0xFFEEEEEE),
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Left: icon + title + time
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: iconBgColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        icon,
                                                        color: iconColor,
                                                        size: 18,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        KText(
                                                          text: title,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black87,
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          TimeAgoHelper.getDetailedDifference(
                                                            data.createdAt
                                                                .toString(),
                                                          ),
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                                // Right: amount + paid
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      amount,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: amountColor,
                                                      ),
                                                    ),
                                                    if (paidAmount != null) ...[
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        paidAmount,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),

                                      // Analytics Tab
                                      // Center(
                                      //   child: KText(
                                      //     text: languagesController.tr(
                                      //       "ANALYTICS",
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Center(child: CircularProgressIndicator()),
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
