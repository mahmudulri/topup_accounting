// ═══════════════════════════════════════════════════════════════
// supplier_card.dart
// Import this file and call SupplierCard(data: …, actions: …)
// ═══════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:topup_accounting/controllers/selltop_up_controller.dart';
import 'package:topup_accounting/helpers/compactnumber_helpder.dart';
import 'package:topup_accounting/utils/colors.dart';

// ───────────────────────────────────────────────────────────────
// PALETTE
// ───────────────────────────────────────────────────────────────
const _kBandDark = Color(0xFF0C447C);
const _kBandMid = AppColors.primaryColor;
const _kBandAccent = Color(0xFF378ADD);
const _kBandText = Color(0xFFE6F1FB);
const _kBandSub = Color(0xFF85B7EB);
const _kBandPill = Color(0xFFB5D4F4);
const _kGreenDot = Color(0xFF5DCAA5);
const _kBlueVal = Color(0xFF185FA5);
const _kGreenVal = Color(0xFF3B6D11);
const _kRedVal = Color(0xFFA32D2D);
const _kAmberBg = Color(0xFFFAEEDA);
const _kAmberText = Color(0xFF633806);
const _kAmberBar = Color(0xFFEF9F27);
const _kRedBg = Color(0xFFFCEBEB);
const _kRedBorder = Color(0xFFF09595);

// ───────────────────────────────────────────────────────────────
// 1. DATA MODEL
// ───────────────────────────────────────────────────────────────
class SupplierCardData {
  final String name;
  final String company;
  final String phone;
  final String lastContact;
  final double bonusPercentage;
  final String totalBuyAmount;
  final String totalPaidAmount;
  final String totalBuyTopupWithBonus;
  final String currentStock;
  final String totalDueAmount;
  final String totalDueFormatted;

  const SupplierCardData({
    required this.name,
    required this.company,
    required this.phone,
    required this.lastContact,
    required this.bonusPercentage,
    required this.totalBuyAmount,
    required this.totalPaidAmount,
    required this.totalBuyTopupWithBonus,
    required this.currentStock,
    required this.totalDueAmount,
    required this.totalDueFormatted,
  });
}

// ───────────────────────────────────────────────────────────────
// 2. ACTIONS MODEL
// ───────────────────────────────────────────────────────────────
class SupplierCardActions {
  final VoidCallback? onBuy;
  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final VoidCallback? onUpdatePercent;
  final VoidCallback? onPay;
  final VoidCallback? onDisable;
  final VoidCallback? onDelete;

  const SupplierCardActions({
    this.onBuy,
    this.onView,
    this.onEdit,
    this.onUpdatePercent,
    this.onPay,
    this.onDisable,
    this.onDelete,
  });
}

// ───────────────────────────────────────────────────────────────
// 3. PUBLIC WIDGET
// ───────────────────────────────────────────────────────────────
class SupplierCard extends StatelessWidget {
  final SupplierCardData data;
  final SupplierCardActions actions;

  const SupplierCard({super.key, required this.data, required this.actions});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withOpacity(0.08), width: 0.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TopBand(data: data),
            RatioRow(
              totalpaidAmount: double.parse(data.totalPaidAmount),
              totalBuyAmount: double.parse(data.totalBuyAmount),
            ),
            _StatsRow(data: data),
            _InfoRows(data: data),

            _ActionsBar(actions: actions),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────
// 4. TOP BAND
// ───────────────────────────────────────────────────────────────
class _TopBand extends StatelessWidget {
  final SupplierCardData data;
  const _TopBand({required this.data});

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: EdgeInsets.fromLTRB(18, 18, 18, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2),
                Text(
                  data.name,
                  style: const TextStyle(
                    color: _kBandText,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${data.company}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Phone pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _kBandMid,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: _kGreenDot,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  data.phone,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────
// 5. BONUS ROW
// ───────────────────────────────────────────────────────────────
class RatioRow extends StatelessWidget {
  final double totalpaidAmount;
  final double totalBuyAmount;

  const RatioRow({
    super.key,
    required this.totalpaidAmount,
    required this.totalBuyAmount,
  });

  @override
  Widget build(BuildContext context) {
    final div = Colors.black.withOpacity(0.07);

    // ✅ Safe calculation
    double ratio = 0;
    if (totalBuyAmount > 0) {
      ratio = (totalpaidAmount / totalBuyAmount) * 100;
    }

    // ✅ Clamp ratio (0–100)
    ratio = ratio.clamp(0, 100);

    double progressValue = ratio / 100;

    // ✅ Dynamic color based on ratio
    Color progressColor;
    Color bgColor;

    if (ratio < 50) {
      progressColor = Colors.red;
      bgColor = const Color(0xFFFCEBEB);
    } else if (ratio < 80) {
      progressColor = _kAmberBar;
      bgColor = _kAmberBg;
    } else {
      progressColor = Colors.green;
      bgColor = const Color(0xFFE9F7EF);
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: div, width: 0.5)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        children: [
          Text(
            languagesController.tr("PAYMENT_RATIO"),
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),

          const SizedBox(width: 10),

          // ✅ Progress Bar
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progressValue,
                minHeight: 6,
                backgroundColor: Colors.black.withOpacity(0.07),
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // ✅ Percentage Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${ratio.toStringAsFixed(0)}%',
              style: TextStyle(
                color: progressColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────
// 6. STATS ROW
// ───────────────────────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  final SupplierCardData data;
  const _StatsRow({required this.data});

  @override
  Widget build(BuildContext context) {
    final div = Colors.black.withOpacity(0.07);
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: div, width: 0.5)),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _StatCell(
              label: languagesController.tr("PURCHASE"),
              value: formatCompactNumber(double.parse(data.totalBuyAmount)),
              hint:
                  '+${data.totalBuyTopupWithBonus} ${languagesController.tr("WITH_BONUS")}',
              valueColor: _kBlueVal,
            ),
            VerticalDivider(width: 0.5, color: div),
            _StatCell(
              label: languagesController.tr("STOCK"),
              value: data.currentStock,
              hint: languagesController.tr("AVAILABLE_NOW"),
              valueColor: _kGreenVal,
            ),
            VerticalDivider(width: 0.5, color: div),
            _StatCell(
              label: languagesController.tr("DUE"),
              value: data.totalDueAmount,
              hint: data.totalDueFormatted,
              valueColor: _kRedVal,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  final String label;
  final String value;
  final String hint;
  final Color valueColor;

  const _StatCell({
    required this.label,
    required this.value,
    required this.hint,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,

                color: Theme.of(
                  context,
                ).textTheme.bodySmall?.color?.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: valueColor,
                height: 1,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              hint,
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(
                  context,
                ).textTheme.bodySmall?.color?.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────
// Company Row
// ───────────────────────────────────────────────────────────────
class _InfoRows extends StatelessWidget {
  final SupplierCardData data;
  const _InfoRows({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          PaidRow(
            label: languagesController.tr("TOTAL_PAID"),
            value: data.totalPaidAmount,
          ),
          _InfoRow(
            label: languagesController.tr("COMPANY"),
            value: data.company,
          ),
          _InfoRow(
            label: languagesController.tr("SINCE"),
            value: data.lastContact,
          ),
        ],
      ),
    );
  }
}

class PaidRow extends StatelessWidget {
  final String label;
  final String value;
  const PaidRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final div = Colors.black.withOpacity(0.07);
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: div, width: 0.5)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final div = Colors.black.withOpacity(0.07);
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: div, width: 0.5)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 13, color: AppColors.fontColor),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────
// 8. ACTIONS BAR
// ───────────────────────────────────────────────────────────────
class _ActionsBar extends StatelessWidget {
  final SupplierCardActions actions;
  const _ActionsBar({required this.actions});

  @override
  Widget build(BuildContext context) {
    final div = Colors.black.withOpacity(0.07);
    final surfaceBg = Theme.of(context).colorScheme.surface.withOpacity(0.6);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(
        color: surfaceBg,
        border: Border(top: BorderSide(color: div, width: 0.5)),
      ),
      child: Row(
        children: [
          // ── "Quick action ▾" button ───────────────────────
          _QuickActionButton(actions: actions),

          const Spacer(),

          // ── Disable ───────────────────────────────────────
          _OutlineIconButton(
            label: languagesController.tr("DISABLE"),
            icon: Icons.block,
            foreground: _kAmberText,
            borderColor: _kAmberBar.withOpacity(0.6),
            hoverColor: _kAmberBg,
            onTap: actions.onDisable,
          ),
          const SizedBox(width: 8),

          // ── Delete ────────────────────────────────────────
          _OutlineIconButton(
            label: languagesController.tr("DELETE"),
            icon: Icons.delete_outline,
            foreground: _kRedVal,
            borderColor: _kRedBorder,
            hoverColor: _kRedBg,
            onTap: actions.onDelete,
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────
// 9. QUICK ACTION BUTTON
//    Single button "Quick action ▾" — opens a popup menu
//    with all 5 actions listed under a "Quick actions" header
// ───────────────────────────────────────────────────────────────
class _QuickActionButton extends StatelessWidget {
  final SupplierCardActions actions;
  const _QuickActionButton({required this.actions});

  void _open(BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    // Position menu ABOVE the button
    final Offset topLeft = box.localToGlobal(Offset.zero, ancestor: overlay);
    final Offset bottomRight = box.localToGlobal(
      box.size.bottomRight(Offset.zero),
      ancestor: overlay,
    );
    final Size screen = overlay.size;

    final RelativeRect position = RelativeRect.fromLTRB(
      topLeft.dx,
      screen.height - topLeft.dy, // bottom of menu = top of button
      screen.width - bottomRight.dx,
      0,
    );

    showMenu<String>(
      context: context,
      position: position,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      items: [
        // ── Section header (non-interactive) ──────────────
        PopupMenuItem<String>(
          enabled: false,
          height: 32,
          child: Text(
            'QUICK ACTIONS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: Theme.of(
                context,
              ).textTheme.bodySmall?.color?.withOpacity(0.6),
            ),
          ),
        ),
        const PopupMenuDivider(height: 1),

        // ── Menu items ────────────────────────────────────
        _menuItem(
          context: context,
          value: 'buy',
          icon: Icons.shopping_cart_outlined,
          label: languagesController.tr("BUY"),
          onTap: actions.onBuy,
        ),
        _menuItem(
          context: context,
          value: 'view',
          icon: Icons.visibility_outlined,
          label: languagesController.tr("VIEW"),
          onTap: actions.onView,
        ),
        _menuItem(
          context: context,
          value: 'edit',
          icon: Icons.edit_outlined,
          label: languagesController.tr("EDIT"),
          onTap: actions.onEdit,
        ),
        // _menuItem(
        //   context: context,
        //   value: 'pct',
        //   icon: Icons.percent,
        //   label: languagesController.tr("UPDATE_%"),
        //   onTap: actions.onUpdatePercent,
        // ),
        _menuItem(
          context: context,
          value: 'pay',
          icon: Icons.credit_card_outlined,
          label: languagesController.tr("PAY"),
          onTap: actions.onPay,
        ),
      ],
    );
  }

  PopupMenuItem<String> _menuItem({
    required BuildContext context,
    required String value,
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return PopupMenuItem<String>(
      value: value,
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 15,
            color: Theme.of(context).iconTheme.color?.withOpacity(0.55),
          ),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Uses its own context so findRenderObject() points to THIS widget
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _open(context),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(
              color: Colors.black.withOpacity(0.15),
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                languagesController.tr("QUICK_ACTION"),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────
// 10. OUTLINE ICON BUTTON  (Disable / Delete)
// ───────────────────────────────────────────────────────────────
class _OutlineIconButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color foreground;
  final Color borderColor;
  final Color hoverColor;
  final VoidCallback? onTap;

  const _OutlineIconButton({
    required this.label,
    required this.icon,
    required this.foreground,
    required this.borderColor,
    required this.hoverColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        hoverColor: hoverColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: foreground),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
