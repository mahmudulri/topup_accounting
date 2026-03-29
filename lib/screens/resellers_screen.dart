import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reseller_list_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../global_controllers/scaffold_controller.dart';
import '../utils/colors.dart';
import '../widgets/custom_text.dart';
import '../widgets/resellercard.dart';
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
          ],
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => resellerListController.isLoading.value == false
                ? ListView.builder(
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

                      return ResellerCard(
                        data: ResellerCardData(
                          name: data!.name.toString(),

                          phone: '01777777777',
                          lastContact: 'Mar 12, 2026',
                          bonusPercentage: 5,
                          totalBuyAmount: '5.0L',
                          totalBuyTopupWithBonus: '5.3L',
                          currentStock: '4.3L',
                          totalDueAmount: '120K',
                          totalDueFormatted: 'AFG 120,000',
                        ),
                        actions: ResellerCardActions(
                          onBuy: () {},
                          onView: () {
                            Get.to(() => ResellerViewScreen());
                          },
                          onEdit: () {},
                          onUpdatePercent: () {},
                          onPay: () {},
                          onDisable: () {},
                          onDelete: () {},
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
