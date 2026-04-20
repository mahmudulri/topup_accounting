import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topup_accounting/controllers/transactions_controller.dart';
import 'package:topup_accounting/widgets/financecardreport.dart';

import '../controllers/profit_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../utils/colors.dart';
import '../widgets/custom_text.dart';

class ReportsScreen extends StatefulWidget {
  ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final languagesController = Get.find<LanguagesController>();

  TransactionListController transactionListController = Get.put(
    TransactionListController(),
  );

  ProfitController profitController = Get.put(ProfitController());
  final box = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profitController.fetchprofitData();
    transactionListController.fetchtransactions();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
            KText(
              text: languagesController.tr("REPORTS"),
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.titleText,
            ),
          ],
        ),
        actions: [],
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Obx(
            () =>
                transactionListController.isLoading.value == false &&
                    profitController.isLoading.value == false
                ? ListView(
                    children: [
                      Container(
                        height: 160,
                        width: screenWidth,

                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ReportContainer(
                                        title: "Total Revenue",
                                        value: profitController
                                            .allprofitData
                                            .value
                                            .profitAnalysis!
                                            .total!
                                            .revenue
                                            .toString(),
                                        myicon: Icons.attach_money,
                                        mycolor: AppColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      flex: 1,
                                      child: ReportContainer(
                                        title: "Total Cost",
                                        value: profitController
                                            .allprofitData
                                            .value
                                            .profitAnalysis!
                                            .total!
                                            .cost
                                            .toString(),
                                        myicon: Icons.trending_down,
                                        mycolor: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ReportContainer(
                                        title: "Total Profit",
                                        value: profitController
                                            .allprofitData
                                            .value
                                            .profitAnalysis!
                                            .total!
                                            .profit
                                            .toString(),
                                        myicon: Icons.trending_up,
                                        mycolor: Colors.green,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      flex: 1,
                                      child: ReportContainer(
                                        title: "Total Transactions",
                                        value: transactionListController
                                            .alltransactions
                                            .value
                                            .pagination!
                                            .totalRecords
                                            .toString(),
                                        myicon: Icons.show_chart,
                                        mycolor: Colors.purple,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

class ReportContainer extends StatelessWidget {
  final String? title;
  final String? value;
  final IconData? myicon;
  final Color? mycolor;

  ReportContainer({
    super.key,
    this.title,
    this.value,
    this.myicon,
    this.mycolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: mycolor!.withAlpha(20),
                child: Icon(myicon, color: mycolor),
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: title.toString(),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 5),
                  Text(
                    value.toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
