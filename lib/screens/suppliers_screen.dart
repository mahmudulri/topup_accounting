import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topup_accounting/helpers/compactnumber_helpder.dart';
import 'package:topup_accounting/helpers/localtime_helper.dart';
import 'package:topup_accounting/widgets/payment_sheet.dart';
import '../controllers/buytop_up_controller.dart';
import '../controllers/delete_supplier_controller.dart';
import '../controllers/status_controller.dart';
import '../controllers/supplierlist_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../utils/colors.dart';
import '../widgets/add_suppliershett.dart';
import '../widgets/buy_topup_sheet.dart';
import '../widgets/custom_text.dart';
import '../widgets/suppliercard.dart';
import '../widgets/update_suppliersheet.dart';
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
  StatusController statusController = Get.put(StatusController());
  DeleteSupplierController deleteSupplierController = Get.put(
    DeleteSupplierController(),
  );
  BuytopUpController buytopUpController = Get.put(BuytopUpController());
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
            Spacer(),
            GestureDetector(
              onTap: () {
                showAddSupplierSheet(context);
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

                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => SupplierViewScreen(
                              supplierID: data.id.toString(),
                              status: data.status.toString(),
                              name: data.name,
                              company: data.company,
                              totalPurchase: data.totalBuyAmount.toString(),
                              totalPaid: data.totalPaidAmount.toString(),
                              totalDue: data.totalDueAmount!.toString(),
                              currentStock: data.currentStock.toString(),
                              phone: data.phone,
                              created: data.createdAt.toString(),
                              bonus: data.bonusPercentage.toString(),
                            ),
                          );
                        },
                        child: SupplierCard(
                          data: SupplierCardData(
                            name: data!.name.toString(),
                            status: data.status.toString(),
                            company: data.company.toString(),
                            phone: data.phone.toString(),
                            lastContact: convertToDate(
                              data.createdAt.toString(),
                            ),
                            bonusPercentage: double.parse(
                              data.bonusPercentage.toString(),
                            ),
                            totalBuyAmount: data.totalBuyAmount.toString(),
                            totalPaidAmount: data.totalPaidAmount.toString(),
                            totalBuyTopupWithBonus: formatCompactNumber(
                              double.parse(
                                data.totalBuyTopupWithBonus.toString(),
                              ),
                            ),
                            currentStock: formatCompactNumber(
                              double.parse(data.currentStock.toString()),
                            ),
                            totalDueAmount: formatCompactNumber(
                              double.parse(data.totalDueAmount.toString()),
                            ),
                            totalDueFormatted: data.totalDueAmount!.toString(),
                          ),
                          actions: SupplierCardActions(
                            onBuy: () {
                              buytopUpController.baseAmount.value == 0.0;
                              buytopUpController.paidAmount.value == 0.0;
                              buytopUpController.baseAmountController.clear();
                              buytopUpController.paidAmountController.clear();
                              buytopUpController.referenceController.clear();
                              buytopUpController.notesController.clear();
                              showBuyTopupSheet(
                                context: context,
                                title: languagesController.tr("BUY_TOP_UP"),

                                subtitle:
                                    data.name.toString() +
                                    " - " +
                                    data.company.toString() +
                                    " " +
                                    "(${data.bonusPercentage} % ${languagesController.tr("BONUS")})",

                                supplierID: data.id.toString(),
                              );
                            },
                            onView: () {
                              Get.to(
                                () => SupplierViewScreen(
                                  supplierID: data.id.toString(),
                                  status: data.status.toString(),
                                  name: data.name,
                                  company: data.company,
                                  totalPurchase: data.totalBuyAmount.toString(),
                                  totalPaid: data.totalPaidAmount.toString(),
                                  totalDue: data.totalDueAmount!.toString(),
                                  currentStock: data.currentStock.toString(),
                                  phone: data.phone,
                                  created: data.createdAt.toString(),
                                  bonus: data.bonusPercentage.toString(),
                                ),
                              );
                            },
                            onEdit: () {
                              updateSuppliersheet(context, {
                                "id": data.id,
                                "name": data.name,
                                "phone": data.phone,
                                "company": data.company,
                                "bonus_percentage": data.bonusPercentage,
                              });
                            },
                            onUpdatePercent: () {},
                            onPay: () {
                              paymentsheet(
                                context: context,
                                title: languagesController.tr("PAY_DUE"),
                                totalDue: data.totalDueAmount.toString(),
                                subtitle:
                                    data.name.toString() +
                                    " - " +
                                    data.name.toString(),

                                resellerID: data.id.toString(),
                              );
                            },
                            onDisable: () {
                              statusController.changeStatus(
                                type: "suppliers",
                                id: data.id.toString(),
                              );
                            },
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
                                          deleteSupplierController.deletenow(
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
                    },
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

void showBuyTopupSheet({
  required BuildContext context,
  required String title,
  required String subtitle,
  required String supplierID,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return BuyTopupSheet(
        title: title,
        subtitle: subtitle,
        supplierID: supplierID,
      );
    },
  );
}

void paymentsheet({
  required BuildContext context,
  required String title,
  required String subtitle,
  required String resellerID,
  required String totalDue,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      print(resellerID.toString());
      return PaymentSheet(
        title: title,
        subtitle: subtitle,
        resellerID: resellerID,
        totalDue: totalDue.toString(),
      );
    },
  );
}
