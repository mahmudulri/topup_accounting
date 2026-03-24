import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global_controllers/languages_controller.dart';
import '../global_controllers/scaffold_controller.dart';
import '../utils/colors.dart';
import '../widgets/custom_text.dart';

class ResellersScreen extends StatelessWidget {
  ResellersScreen({super.key});

  final languagesController = Get.find<LanguagesController>();

  final scaffoldController = Get.find<ScaffoldController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldController.scaffoldKey,
      backgroundColor: AppColors.cardBg,
      // drawer: Drawer(),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.cardBg,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                scaffoldController.openDrawer();
              },
              child: Container(
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

      body: Center(child: Text("ResellersScreen")),
    );
  }
}
