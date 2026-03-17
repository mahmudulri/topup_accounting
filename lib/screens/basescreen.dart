import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../global_controllers/languages_controller.dart';
import '../utils/colors.dart';
import 'dashboard.dart';
import 'report_screen.dart';
import 'transactions_screen.dart';
import 'suppliers_screen.dart';
import 'resellers_screen.dart';

class Basescreen extends StatefulWidget {
  Basescreen({super.key});

  @override
  State<Basescreen> createState() => _BasescreenState();
}

class _BasescreenState extends State<Basescreen> {
  final lang = Get.find<LanguagesController>();
  int _currentIndex = 0;

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return Dashboard();
      case 1:
        return TransactionsScreen();
      case 2:
        return SuppliersScreen();
      case 3:
        return ResellersScreen();
      case 4:
        return ReportsScreen();
      default:
        return Dashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: _getScreen(_currentIndex),
      bottomNavigationBar: _BottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        lang: lang,
      ),
    );
  }
}

// ── Bottom Nav Bar ────────────────────────────────────────────────────────────
class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;
  final LanguagesController lang;

  _BottomNav({
    required this.currentIndex,
    required this.onTap,
    required this.lang,
  });

  static const List<Map<String, Object>> _items = [
    {'key': 'HOME', 'icon': Icons.home_rounded, 'iconOff': Icons.home_outlined},
    {
      'key': 'TRANSACTIONS',
      'icon': Icons.swap_horiz_rounded,
      'iconOff': Icons.swap_horiz_outlined,
    },
    {
      'key': 'SUPPLIERS',
      'icon': Icons.local_shipping_rounded,
      'iconOff': Icons.local_shipping_outlined,
    },
    {
      'key': 'RESELLERS',
      'icon': Icons.people_rounded,
      'iconOff': Icons.people_outline,
    },
    {
      'key': 'REPORTS',
      'icon': Icons.bar_chart_rounded,
      'iconOff': Icons.bar_chart_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final isSelected = currentIndex == i;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon with teal circle bg when selected
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isSelected
                              ? item['icon'] as IconData
                              : item['iconOff'] as IconData,
                          size: 22,
                          color: isSelected
                              ? Colors.white
                              : AppColors.mutedText,
                        ),
                      ),
                      SizedBox(height: 2),
                      // Label
                      AnimatedDefaultTextStyle(
                        duration: Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.mutedText,
                        ),
                        child: Text(lang.tr(item['key'] as String)),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
