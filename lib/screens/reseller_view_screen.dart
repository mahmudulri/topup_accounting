import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global_controllers/languages_controller.dart';
import '../utils/colors.dart';
import '../widgets/custom_text.dart';

class ResellerViewScreen extends StatelessWidget {
  String? resellerID;
  String? status;
  String? name;
  String? phone;
  String? city;
  String? totalSales;
  String? totalDue;
  String? totalReceived;
  String? totalBonus;
  String? created;

  ResellerViewScreen({
    super.key,
    this.resellerID,
    this.status,
    this.name,
    this.city,
    this.totalSales,
    this.totalDue,
    this.totalReceived,
    this.totalBonus,
    this.created,
  });

  final languagesController = Get.find<LanguagesController>();

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: "Reseler view screen",
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.titleText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
