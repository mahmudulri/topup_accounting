import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../global_controllers/languages_controller.dart';
import '../utils/colors.dart';

import 'custom_text.dart'; // adjust path

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemTap,
  });

  final int selectedIndex;
  final void Function(int) onItemTap;

  static const _items = [
    {'iconKey': 'HOME', 'icon': Icons.home_rounded},
    {'iconKey': 'TRANSACTIONS', 'icon': Icons.swap_horiz_rounded},
    {'iconKey': 'SUPPLIERS', 'icon': Icons.local_shipping_outlined},
    {'iconKey': 'RESELLERS', 'icon': Icons.people_outline},
    {'iconKey': 'BUY_TOPUP', 'icon': Icons.add_shopping_cart},
    {'iconKey': 'SELL_TOPUP', 'icon': Icons.sell_outlined},
    {'iconKey': 'REPORTS', 'icon': Icons.bar_chart_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    final lang = Get.find<LanguagesController>();

    return Drawer(
      backgroundColor: AppColors.cardBg,
      child: SafeArea(
        child: Column(
          children: [
            // ── Logo header ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  KText(
                    text: lang.tr("APP_NAME"),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.titleText,
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFEEF2F5)),
            const SizedBox(height: 10),

            // ── Nav items ────────────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _items.length,
                itemBuilder: (context, i) {
                  final item = _items[i];
                  final isSelected = selectedIndex == i;

                  return GestureDetector(
                    onTap: () {
                      onItemTap(i);
                      Navigator.pop(context);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item['icon'] as IconData,
                            size: 20,
                            color: isSelected
                                ? Colors.white
                                : AppColors.mutedText,
                          ),
                          const SizedBox(width: 12),
                          KText(
                            text: lang.tr(item['iconKey'] as String),
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isSelected
                                ? Colors.white
                                : AppColors.labelText,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
