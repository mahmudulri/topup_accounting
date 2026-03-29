import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/supplierlist_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../utils/colors.dart';
import '../widgets/custom_text.dart';
import '../widgets/suppliercard.dart';
import 'supplier_view_screen.dart';

class SuppliersScreen extends StatefulWidget {
  SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  SupplierlistController supplierlistController = Get.put(
    SupplierlistController(),
  );

  final languagesController = Get.find<LanguagesController>();

  @override
  void initState() {
    super.initState();
    supplierlistController.fetchsupplierlist();
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
              text: languagesController.tr("SUPPLIERS"),
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
            () => supplierlistController.isLoading.value == false
                ? ListView.builder(
                    itemCount:
                        supplierlistController
                            .allsupplierlist
                            .value
                            .suppliers
                            ?.length ??
                        0,
                    itemBuilder: (context, index) {
                      final data = supplierlistController
                          .allsupplierlist
                          .value
                          .suppliers?[index];

                      return SupplierCard(
                        data: SupplierCardData(
                          name: data!.name.toString(),
                          company: data.company.toString(),
                          phone: '01777777777',
                          lastContact: 'Mar 12, 2026',
                          bonusPercentage: 5,
                          totalBuyAmount: '5.0L',
                          totalBuyTopupWithBonus: '5.3L',
                          currentStock: '4.3L',
                          totalDueAmount: '120K',
                          totalDueFormatted: 'AFG 120,000',
                        ),
                        actions: SupplierCardActions(
                          onBuy: () {},
                          onView: () {
                            Get.to(
                              () => SupplierViewScreen(
                                supplierID: data.id.toString(),
                                status: data.status.toString(),
                                name: data.name,
                                company: data.company,
                                totalPurchase: data.totalBuyAmount.toString(),
                              ),
                            );
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
