import 'package:flutter/material.dart';
import '../utils/colors.dart';

class StatCard extends StatelessWidget {
  StatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.value,
    required this.sub,
    required this.label,
    this.badge,
    this.badgeColor,
    this.badgeIcon,
    this.bottomRight,
    this.bottomRightColor,
    this.onTap,
  });

  /// Icon inside the circle
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;

  /// Main big value  e.g. "4.2L" or "AFG 120,000"
  final String value;

  /// Small text below value  e.g. "AFG 400,000" or "3 Pending"
  final String sub;

  /// Bottom-left label  e.g. "Total Stock"
  final String label;

  /// Optional badge top-right  e.g. "High Due"
  final String? badge;
  final Color? badgeColor;
  final IconData? badgeIcon;

  /// Optional bottom-right text  e.g. "80.0%"
  final String? bottomRight;
  final Color? bottomRightColor;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: AppColors.scaffoldBg),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Row: icon  +  optional badge ─────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Circle icon
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 15),
                ),

                Spacer(),

                if (badge != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: badgeColor!.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (badgeIcon != null) ...[
                          Icon(badgeIcon, size: 11, color: badgeColor),
                          SizedBox(width: 3),
                        ],
                        Text(
                          badge!,
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: badgeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            SizedBox(height: 8),

            // ── Main value ────────────────────────────────────
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.titleText,
              ),
            ),

            SizedBox(height: 3),

            // ── Sub text ──────────────────────────────────────
            Text(
              sub,
              style: TextStyle(fontSize: 11, color: AppColors.mutedText),
            ),

            Spacer(),

            // ── Bottom row: label + optional right text ───────
            Divider(color: AppColors.scaffoldBg),
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 13, color: AppColors.mutedText),
                ),
                Spacer(),
                if (bottomRight != null)
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up_rounded,
                        size: 13,
                        color: bottomRightColor ?? AppColors.primaryColor,
                      ),
                      SizedBox(width: 2),
                      Text(
                        bottomRight!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: bottomRightColor ?? AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
