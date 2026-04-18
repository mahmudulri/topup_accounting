import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topup_accounting/helpers/localtime_helper.dart';
import '../controllers/delete_reseller_controller.dart';
import '../controllers/reseller_list_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../global_controllers/scaffold_controller.dart';
import '../utils/colors.dart';
import '../widgets/add_resellershet.dart';
import '../widgets/custom_text.dart';
import '../widgets/resellercard.dart';
import '../widgets/update_resellersheet.dart';
import 'reseller_view_screen.dart';

class ResellersScreen extends StatefulWidget {
  ResellersScreen({super.key});

  @override
  State<ResellersScreen> createState() => _ResellersScreenState();
}

class _ResellersScreenState extends State<ResellersScreen> {
  final languagesController = Get.find<LanguagesController>();

  final scaffoldController = Get.find<ScaffoldController>();

  ResellerListController resellerListController = Get.put(
    ResellerListController(),
  );

  DeleteResellerController deleteResellerController = Get.put(
    DeleteResellerController(),
  );

  @override
  void initState() {
    super.initState();
    resellerListController.fetchReseller();
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
              text: languagesController.tr("RESELLERS"),
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.titleText,
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                showAddResellerSheet(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(Icons.add, color: Colors.white, size: 28),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3),
          child: Obx(
            () => resellerListController.isLoading.value == false
                ? ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 0);
                    },
                    itemCount:
                        resellerListController
                            .allresellers
                            .value
                            .resellers
                            ?.length ??
                        0,
                    itemBuilder: (context, index) {
                      final data = resellerListController
                          .allresellers
                          .value
                          .resellers?[index];

                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => ResellerViewScreen(
                              resellerID: data.id.toString(),
                              name: data.name,
                              status: data.status.toString(),
                              phone: data.phone,
                              city: data.city,
                              totalSales: data.totalSellAmount,
                              totalDue: data.totalDueAmount,
                              totalReceived: data.totalReceivedAmount,
                              totalWithBonus: data.totalSellTopupWithBonus,
                            ),
                          );
                        },
                        child: ResellerCard(
                          data: ResellerCardData(
                            name: data!.name.toString(),
                            status: data.status.toString(),
                            totalsales: data.totalSellAmount.toString(),
                            city: data.city.toString(),
                            phone: data.phone.toString(),

                            createdat: convertToFormattedDate(
                              data.createdAt.toString(),
                            ),

                            bonusPercentage: data.bonusPercentage.toString(),
                            withbonus: data.totalSellTopupWithBonus.toString(),
                            totalDueAmount: data.totalDueAmount.toString(),
                            totalreceivedAmount: data.totalReceivedAmount
                                .toString(),

                            // ✅ Bonus Given
                            bonusGiven:
                                ((double.tryParse(
                                              data.totalSellTopupWithBonus
                                                  .toString(),
                                            ) ??
                                            0) -
                                        (double.tryParse(
                                              data.totalSellAmount.toString(),
                                            ) ??
                                            0))
                                    .toStringAsFixed(2),

                            // ✅ Collection Ratio (MAIN FIX)
                            currentRatio: (() {
                              final totalSales =
                                  double.tryParse(
                                    data.totalSellAmount.toString(),
                                  ) ??
                                  0;

                              final due =
                                  double.tryParse(
                                    data.totalDueAmount.toString(),
                                  ) ??
                                  0;

                              final received = totalSales - due;

                              if (totalSales == 0) return "0";

                              final ratio = (received / totalSales) * 100;

                              return ratio.toStringAsFixed(1); // 69.2
                            })(),
                          ),
                          actions: ResellerCardActions(
                            onBuy: () {},
                            onView: () {
                              Get.to(() => ResellerViewScreen());
                            },
                            onEdit: () {
                              upldateresellersheet(context, {
                                "id": data.id,
                                "name": data.name,
                                "phone": data.phone,
                                "city": data.city,
                                "bonus_percentage": data.bonusPercentage,
                              });
                            },
                            onUpdatePercent: () {},
                            onPay: () {},
                            onDisable: () {},
                            onDelete: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.warning_amber_rounded,
                                          color: Colors.orange,
                                          size: 28,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          languagesController.tr(
                                            "DELETE_CONFIRMATION",
                                          ),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    content: Text(
                                      languagesController.tr(
                                        "ARE_YOU_SURE_YOU_WANT_TO_DELETE_THIS_ITEM",
                                      ),

                                      style: TextStyle(fontSize: 16),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(
                                            context,
                                          ).pop(); // Close dialog
                                        },
                                        child: Text(
                                          languagesController.tr("CANCEL"),
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(
                                            context,
                                          ).pop(); // Close dialog first
                                          deleteResellerController.deletenow(
                                            data.id.toString(),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          languagesController.tr("DELETE"),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                      // return Container(
                      //   height: 250,
                      //   width: screenWidth,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(width: 1, color: AppColors.borderColor),
                      //   ),
                      //   child: Padding(
                      //     padding: EdgeInsets.all(12.0),
                      //     child: Column(
                      //       children: [
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text("Reseller Name"),
                      //             Text(data!.name.toString()),
                      //           ],
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text("Address"),
                      //             Text(data.company.toString()),
                      //           ],
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [Text("Contact"), Text(data.phone.toString())],
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text("Bonus"),
                      //             Text(data.bonusPercentage.toString()),
                      //           ],
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text("Purchase"),
                      //             Text(data.totalBuyAmount.toString()),
                      //           ],
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text("Purchase With bonus"),
                      //             Text(data.totalBuyTopupWithBonus.toString()),
                      //           ],
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text("Stock"),
                      //             Text(data.currentStock.toString()),
                      //           ],
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text("Due"),
                      //             Text(data.totalDueAmount.toString()),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // );
                    },
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
