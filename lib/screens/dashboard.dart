import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topup_accounting/screens/buytopup_screen.dart';
import 'package:topup_accounting/widgets/drawer.dart';

import '../controllers/dashboard_controller.dart';
import '../controllers/myipcontroller.dart';
import '../controllers/profit_controller.dart';
import '../controllers/summary_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../global_controllers/scaffold_controller.dart';
import '../helpers/compactnumber_helpder.dart';
import '../utils/colors.dart';
import '../widgets/balance_widget.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/performanceoverview_widget.dart';
import '../widgets/todays_activity_widget.dart';
import 'myipdetails_screen.dart';
import 'sell_topup_screen.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final languagesController = Get.find<LanguagesController>();
  String _period = 'TODAY';

  final scaffoldController = Get.find<ScaffoldController>();

  DashboardController dashboardController = Get.put(DashboardController());

  ProfitController profitController = Get.put(ProfitController());

  @override
  void initState() {
    super.initState();
    profitController.fetchprofitData();
  }

  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final periods = ['TODAY', 'WEEK', 'MONTH'];

    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        iconTheme: IconThemeData(color: Colors.white),
        activeIcon: Icons.close,
        backgroundColor: AppColors.primaryColor,
        children: [
          SpeedDialChild(
            child: Icon(Icons.sell),
            label: languagesController.tr("SELL_TOP_UP"),
            onTap: () {
              Get.to(() => SellTopupScreen());
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.shopping_cart),
            label: languagesController.tr("BUY_TOP_UP"),
            onTap: () {
              Get.to(() => BuytopupScreen());
            },
          ),
        ],
      ),
      backgroundColor: AppColors.cardBg,

      appBar: AppTopBar(),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Obx(
          () =>
              dashboardController.isLoading.value == false &&
                  profitController.isLoading.value == false
              ? ListView(
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(12, 5, 12, 0),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         padding: EdgeInsets.all(4),
                    //         decoration: BoxDecoration(
                    //           color: AppColors.cardBg,
                    //           borderRadius: BorderRadius.circular(30),
                    //           border: Border.all(
                    //             color: Colors.grey.shade200,
                    //             width: 1.5,
                    //           ),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.black.withOpacity(0.04),
                    //               blurRadius: 8,
                    //               offset: Offset(0, 2),
                    //             ),
                    //           ],
                    //         ),
                    //         child: Row(
                    //           children: periods.map((key) {
                    //             final isSel = _period == key;
                    //             return GestureDetector(
                    //               onTap: () => setState(() => _period = key),
                    //               child: AnimatedContainer(
                    //                 duration: Duration(milliseconds: 200),
                    //                 padding: EdgeInsets.symmetric(
                    //                   horizontal: 16,
                    //                   vertical: 8,
                    //                 ),
                    //                 decoration: BoxDecoration(
                    //                   color: isSel
                    //                       ? AppColors.primaryColor
                    //                       : Colors.transparent,
                    //                   borderRadius: BorderRadius.circular(24),
                    //                 ),
                    //                 child: Text(
                    //                   languagesController.tr(key),
                    //                   style: TextStyle(
                    //                     fontSize: 13,
                    //                     fontWeight: isSel
                    //                         ? FontWeight.w600
                    //                         : FontWeight.w400,
                    //                     color: isSel
                    //                         ? Colors.white
                    //                         : AppColors.mutedText,
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           }).toList(),
                    //         ),
                    //       ),

                    //       Spacer(),

                    //       GestureDetector(
                    //         onTap: () {},
                    //         child: Container(
                    //           width: 42,
                    //           height: 42,
                    //           decoration: BoxDecoration(
                    //             color: AppColors.cardBg,
                    //             shape: BoxShape.circle,
                    //             border: Border.all(
                    //               color: Colors.grey.shade200,
                    //               width: 1.5,
                    //             ),
                    //             boxShadow: [
                    //               BoxShadow(
                    //                 color: Colors.black.withOpacity(0.04),
                    //                 blurRadius: 8,
                    //                 offset: Offset(0, 2),
                    //               ),
                    //             ],
                    //           ),
                    //           child: GestureDetector(
                    //             onTap: () {},
                    //             child: Icon(
                    //               Icons.sync_rounded,
                    //               color: AppColors.labelText,
                    //               size: 20,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // inside your ListView children:
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1.1,
                        children: [
                          // Card 1 — Total Stock
                          StatCard(
                            icon: Icons.inventory_2_outlined,
                            iconColor: const Color(0xFF5B8DEF),
                            iconBgColor: const Color(0xFFEEF4FF),
                            value:
                                " ${box.read("currencyCode")} ${dashboardController.alldashboaddata.value.summary!.suppliers!.totalStock!.toString()}",

                            label: languagesController.tr("TOTAL_STOCK"),
                            bottomRight:
                                '${dashboardController.stockPercentage.toStringAsFixed(1)}%',
                            bottomRightColor: AppColors.primaryColor,
                          ),

                          // Card 2 — Supplier Due box.read("currencyCode")
                          StatCard(
                            icon: Icons.trending_down_rounded,
                            iconColor: const Color(0xFFFF6B6B),
                            iconBgColor: const Color(0xFFFFEEEE),
                            value:
                                " ${box.read("currencyCode")} ${dashboardController.alldashboaddata.value.summary!.suppliers!.totalSupplierDue!.toString()}",
                            // sub: '3 ${languagesController.tr("PENDING")}',
                            label: languagesController.tr("SUPPLIER_DUE"),
                            badge: languagesController.tr("HIGH_DUE"),
                            badgeColor: const Color(0xFFFF9800),
                            badgeIcon: Icons.warning_amber_rounded,
                          ),

                          // Card 3 — Reseller Due
                          StatCard(
                            icon: Icons.trending_up_rounded,
                            iconColor: AppColors.primaryColor,
                            iconBgColor: const Color(0xFFE8FBF5),
                            value:
                                " ${box.read("currencyCode")} ${profitController.allprofitData.value.dueAnalysis!.totalResellerDue.toString()}",

                            // sub: '1 ${languagesController.tr("PENDING")}',
                            label: languagesController.tr("RESELLER_DUE"),
                          ),

                          // Card 4 — Today's Profit
                          StatCard(
                            icon: Icons.trending_up_rounded,
                            iconColor: AppColors.primaryColor,
                            iconBgColor: const Color(0xFFE8FBF5),
                            value:
                                '${box.read("currencyCode")} ${profitController.allprofitData.value.profitAnalysis!.today!.profit.toString()}',
                            // sub: languagesController.tr("PROFIT"),
                            label: languagesController.tr("TODAY'S_PROFIT"),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),
                    PerformanceOverviewCard(
                      revenue: profitController
                          .allprofitData
                          .value
                          .profitAnalysis!
                          .total!
                          .revenue
                          .toString(),
                      // revenueChange: '+12.5%',
                      revenuePositive: true,
                      cost: profitController
                          .allprofitData
                          .value
                          .profitAnalysis!
                          .total!
                          .cost!
                          .toString(),

                      // costChange: '-8.2%',
                      costPositive: false,
                      profitMargin: profitController
                          .allprofitData
                          .value
                          .profitAnalysis!
                          .total!
                          .profitMargin!
                          .toString(),
                      profitLabel: 'Overall',
                      netBonus: profitController
                          .allprofitData
                          .value
                          .bonusAnalysis!
                          .netBonusImpact
                          .toString(),
                      netBonusLabel: 'units',
                    ),
                    SizedBox(height: 10),
                    TodaysActivityCard(
                      purchasesAmount:
                          '${box.read("currencyCode")} ${dashboardController.alldashboaddata.value.summary!.today!.purchases.toString()}',

                      purchasesTransactions: 0,
                      salesAmount:
                          '${box.read("currencyCode")} ${dashboardController.alldashboaddata.value.summary!.today!.sales.toString()}',
                      salesTransactions: 0,
                      todaysProfit:
                          '${box.read("currencyCode")} ${profitController.allprofitData.value.profitAnalysis!.today!.profit.toString()}',
                      profitMargin: '0%',
                    ),
                  ],
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

String formatDouble(double? value) {
  double v = value ?? 0;
  return v.toStringAsFixed(2);
}
