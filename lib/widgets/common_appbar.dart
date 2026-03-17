import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../global_controllers/languages_controller.dart';
import '../utils/colors.dart';
import 'custom_text.dart';
import 'languagepicker.dart';

class CommonAppbar extends StatefulWidget implements PreferredSizeWidget {
  CommonAppbar({super.key, this.appbarName});

  String? appbarName;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  State<CommonAppbar> createState() => _CommonAppbarState();
}

class _CommonAppbarState extends State<CommonAppbar> {
  final lang = Get.find<LanguagesController>();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            text: widget.appbarName.toString(),
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.titleText,
          ),
        ],
      ),
      actions: [],
    );
  }
}
