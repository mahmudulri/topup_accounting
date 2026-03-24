import 'package:flutter/material.dart';
import 'package:topup_accounting/widgets/custom_text.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    super.key,
    this.buttonName,
    this.onpressed,
    this.mycolor,
    this.textColor,
    this.fontsize,
  });

  final String? buttonName;
  final VoidCallback? onpressed;
  final Color? mycolor;
  final Color? textColor;
  final double? fontsize;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      width: screenWidth,
      decoration: BoxDecoration(
        color: mycolor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: KText(
          text: buttonName.toString(),
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: fontsize ?? 14,
        ),
      ),
    );
  }
}
