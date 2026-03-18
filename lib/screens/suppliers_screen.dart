import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/supplierlist_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../utils/colors.dart';
import '../widgets/custom_text.dart';

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

        child: ListView.builder(
          itemCount:
              supplierlistController.allsupplierlist.value.suppliers?.length ??
              0,
          itemBuilder: (context, index) {
            return Container(
              height: 250,
              width: screenWidth,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.borderColor),
              ),
            );
          },
        ),
      ),
    );
  }
}
