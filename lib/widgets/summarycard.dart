import 'package:flutter/material.dart';
import '../utils/colors.dart';

import '../global_controllers/languages_controller.dart';
import 'package:get/get.dart';

class SummaryCard extends StatelessWidget {
  SummaryCard({
    super.key,
    required this.totalBase,
    required this.totalPaid,
    required this.totalBonus,
  });

  final String totalBase;
  final String totalPaid;
  final String totalBonus;

  @override
  Widget build(BuildContext context) {
    final lang = Get.find<LanguagesController>();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: Offset(0, -4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Total Base
          Expanded(
            child: _SummaryItem(
              label: lang.tr("TOTAL_BASE"),
              value: totalBase,
              icon: Icons.account_balance_wallet_outlined,
              iconColor: Color(0xFF5B8DEF),
              iconBgColor: Color(0xFFEEF4FF),
            ),
          ),

          _Divider(),

          // Total Paid
          Expanded(
            child: _SummaryItem(
              label: lang.tr("TOTAL_PAID"),
              value: totalPaid,
              icon: Icons.check_circle_outline_rounded,
              iconColor: AppColors.primaryColor,
              iconBgColor: Color(0xFFE8FBF5),
            ),
          ),

          _Divider(),

          // Total Bonus
          Expanded(
            child: _SummaryItem(
              label: lang.tr("TOTAL_BONUS"),
              value: totalBonus,
              icon: Icons.card_giftcard_rounded,
              iconColor: Color(0xFF9C6EFF),
              iconBgColor: Color(0xFFF3EEFF),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Single item ───────────────────────────────────────────────────────────────
class _SummaryItem extends StatelessWidget {
  _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon circle
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 18),
        ),

        SizedBox(height: 8),

        // Value
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.titleText,
          ),
        ),

        SizedBox(height: 3),

        // Label
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: AppColors.mutedText,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

// ── Vertical divider ──────────────────────────────────────────────────────────
class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    width: 1,
    height: 60,
    margin: EdgeInsets.symmetric(horizontal: 8),
    color: Color(0xFFF0F4FA),
  );
}
