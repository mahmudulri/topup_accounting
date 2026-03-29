import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/supplier_details_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../utils/colors.dart';
import '../widgets/custom_text.dart';

class SupplierViewScreen extends StatefulWidget {
  String? supplierID;
  String? status;
  String? name;
  String? company;
  String? totalPurchase;
  String? totalDue;
  String? totalPaid;
  String? currentStock;
  SupplierViewScreen({
    super.key,
    this.supplierID,
    this.status,
    this.name,
    this.company,
    this.totalPurchase,
    this.totalDue,
    this.totalPaid,
    this.currentStock,
  });

  @override
  State<SupplierViewScreen> createState() => _SupplierViewScreenState();
}

class _SupplierViewScreenState extends State<SupplierViewScreen> {
  final languagesController = Get.find<LanguagesController>();

  SupplierDetailsController supplierDetailsController = Get.put(
    SupplierDetailsController(),
  );

  @override
  void initState() {
    super.initState();
    supplierDetailsController.fetchsupplierDetails(
      widget.supplierID.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      top: false,
      child: Scaffold(
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
                    text: widget.name.toString(),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.titleText,
                  ),
                  KText(
                    text: widget.company.toString(),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleText,
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Container(height: screenHeight, width: screenWidth),
      ),
    );
  }
}
