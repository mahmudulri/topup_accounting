import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/transactions_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../utils/colors.dart';
import '../widgets/common_appbar.dart';
import '../widgets/custom_text.dart';
import '../widgets/summarycard.dart';
import '../widgets/togglebutton.dart';

class TransactionsScreen extends StatefulWidget {
  TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  TransactionListController transactionListController = Get.put(
    TransactionListController(),
  );

  final languagesController = Get.find<LanguagesController>();

  @override
  void initState() {
    super.initState();

    transactionListController.fetchtransactions();
  }

  bool _isGridView = true;

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.cardBg,
      appBar: AppBar(
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
              text: languagesController.tr("TRANSACTIONS"),
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.titleText,
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsetsDirectional.only(end: 12),
            child: ViewToggleButton(
              initialIsGrid: true,
              onToggle: (isGridView) {
                setState(() {
                  _isGridView = isGridView; // your state variable
                });
              },
            ),
          ),
        ],
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Obx(
            () => transactionListController.isLoading.value == false
                ? ListView(
                    children: [
                      SummaryCard(
                        totalBase: transactionListController
                            .alltransactions
                            .value
                            .summary!
                            .totalBaseAmount
                            .toString(),
                        totalPaid: transactionListController
                            .alltransactions
                            .value
                            .summary!
                            .totalPaidAmount
                            .toString(),
                        totalBonus: transactionListController
                            .alltransactions
                            .value
                            .summary!
                            .totalBonusAmount
                            .toString(),
                      ),

                      SizedBox(height: 5),
                      Container(
                        height: 50,
                        width: screenWidth,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 1,
                                    color: AppColors.borderColor,
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.search, color: Colors.grey),
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Searh transactions..",
                                              hintStyle: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 5),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.filter_alt_outlined,
                                          color: AppColors.cardBg,
                                        ),
                                        SizedBox(width: 5),
                                        KText(
                                          text: languagesController.tr(
                                            "FILTERS",
                                          ),
                                          color: AppColors.cardBg,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Visibility(
                        visible: isVisible,
                        child: Container(
                          height: 200,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColors.borderColor,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.filter_alt_outlined,
                                      color: AppColors.primaryColor,
                                    ),
                                    SizedBox(width: 5),
                                    KText(
                                      text: languagesController.tr("FILTERS"),
                                      color: AppColors.bodyText,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      child: Icon(
                                        Icons.close_sharp,
                                        color: AppColors.hintText,
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
                  )
                : Center(child: CircularProgressIndicator(color: Colors.grey)),
          ),
        ),
      ),
    );
  }
}
