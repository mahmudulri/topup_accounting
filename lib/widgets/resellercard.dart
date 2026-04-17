// ═══════════════════════════════════════════════════════════════
// Reseller_card.dart
// Import this file and call ResellerCard(data: …, actions: …)
// ═══════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:topup_accounting/controllers/buytop_up_controller.dart';
import 'package:topup_accounting/utils/colors.dart';

// ───────────────────────────────────────────────────────────────
// PALETTE
// ───────────────────────────────────────────────────────────────

const _kBandMid = AppColors.primaryColor;
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
class ResellerCardData {
  final String name;
  final String city;
  final String status;
  final String totalsales;
  final String phone;
  final String bonusPercentage;
  final String currentRatio;
  final String bonusGiven;
  final String withbonus;
  final String totalDueAmount;
  final String createdat;

  const ResellerCardData({
    required this.name,
    required this.city,
    required this.status,
    required this.totalsales,
    required this.phone,
    required this.bonusPercentage,
    required this.currentRatio,
    required this.bonusGiven,
    required this.withbonus,
    required this.totalDueAmount,

    required this.createdat,
  });
}

// ───────────────────────────────────────────────────────────────
// 2. ACTIONS MODEL
// ───────────────────────────────────────────────────────────────
class ResellerCardActions {
  final VoidCallback? onBuy;
  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final VoidCallback? onUpdatePercent;
  final VoidCallback? onPay;
  final VoidCallback? onDisable;
  final VoidCallback? onDelete;

  const ResellerCardActions({
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
class ResellerCard extends StatelessWidget {
  final ResellerCardData data;
  final ResellerCardActions actions;

  ResellerCard({super.key, required this.data, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withOpacity(0.08), width: 0.5),
          boxShadow: [
            // Bottom shadow (main elevation)
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),

            // Top shadow (subtle)
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: Offset(0, -4), // 👈 negative for top
            ),

            // Ambient soft shadow
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TopBand(data: data),

              _StatsRow(data: data),
              _BonusRow(
                bonusPercentage: data.bonusPercentage.toString(),
                currentRatio: data.currentRatio,
              ),

              _ActionsBar(actions: actions),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────
// 4. TOP BAND
// ───────────────────────────────────────────────────────────────
class _TopBand extends StatelessWidget {
  final ResellerCardData data;
  const _TopBand({required this.data});

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(18, 18, 18, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2),
                Text(
                  data.name,
                  style: TextStyle(
                    color: AppColors.fontColor2,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  data.city,
                  style: TextStyle(
                    color: AppColors.fontColor2,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.call, color: AppColors.fontColor2, size: 16),
                    SizedBox(width: 5),
                    Text(
                      data.phone,
                      style: TextStyle(
                        color: AppColors.fontColor2,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.percent, color: AppColors.fontColor2, size: 16),
                    SizedBox(width: 5),
                    Text(
                      data.bonusPercentage.toString() +
                          "%"
                              " " +
                          languagesController.tr("BONUS"),
                      style: TextStyle(
                        color: AppColors.fontColor2,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: AppColors.fontColor2,
                      size: 16,
                    ),
                    SizedBox(width: 5),
                    Text(
                      languagesController.tr("SINCE") +
                          " " +
                          data.createdat.toString(),
                      style: TextStyle(
                        color: AppColors.fontColor2,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Phone pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.green.withAlpha(50),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  data.status == "1" ? "Active" : "Inactive",
                  style: TextStyle(color: Colors.green, fontSize: 12),
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
class _BonusRow extends StatelessWidget {
  final String bonusPercentage;
  final String currentRatio;

  const _BonusRow({required this.bonusPercentage, required this.currentRatio});

  @override
  Widget build(BuildContext context) {
    final div = Colors.black.withOpacity(0.07);
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: div, width: 0.5)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        children: [
          Text(
            'Current Ratio',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: (double.tryParse(currentRatio) ?? 0) / 100,
                minHeight: 6,
                backgroundColor: Colors.black.withOpacity(0.07),
                valueColor: const AlwaysStoppedAnimation<Color>(_kAmberBar),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _kAmberBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${double.tryParse(currentRatio)?.toStringAsFixed(1) ?? "0.0"}%',
              style: const TextStyle(
                color: _kAmberText,
                fontSize: 13,
                fontWeight: FontWeight.w500,
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
  final ResellerCardData data;
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
              label: 'Total Sales',
              value: data.totalsales,

              valueColor: _kBlueVal,
            ),
            VerticalDivider(width: 0.5, color: div),
            _StatCell(
              label: 'With Bonus',
              value: data.withbonus,

              valueColor: _kGreenVal,
            ),
            VerticalDivider(width: 0.5, color: div),
            _StatCell(
              label: 'Bonus Given',
              value: data.bonusGiven,

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

  final Color valueColor;

  const _StatCell({
    required this.label,
    required this.value,

    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
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
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: valueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────
// 7. INFO ROWS
// ───────────────────────────────────────────────────────────────
class _InfoRows extends StatelessWidget {
  final ResellerCardData data;
  const _InfoRows({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [_InfoRow(label: 'Since', value: data.createdat)],
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
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(
                context,
              ).textTheme.bodySmall?.color?.withOpacity(0.7),
            ),
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
  final ResellerCardActions actions;
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
            label: 'Disable',
            icon: Icons.block,
            foreground: _kAmberText,
            borderColor: _kAmberBar.withOpacity(0.6),
            hoverColor: _kAmberBg,
            onTap: actions.onDisable,
          ),
          const SizedBox(width: 8),

          // ── Delete ────────────────────────────────────────
          _OutlineIconButton(
            label: 'Delete',
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
  final ResellerCardActions actions;
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
          label: 'Buy',
          onTap: actions.onBuy,
        ),
        _menuItem(
          context: context,
          value: 'view',
          icon: Icons.visibility_outlined,
          label: 'View',
          onTap: actions.onView,
        ),
        _menuItem(
          context: context,
          value: 'edit',
          icon: Icons.edit_outlined,
          label: 'Edit',
          onTap: actions.onEdit,
        ),
        // _menuItem(
        //   context: context,
        //   value: 'pct',
        //   icon: Icons.percent,
        //   label: 'Update %',
        //   onTap: actions.onUpdatePercent,
        // ),
        _menuItem(
          context: context,
          value: 'pay',
          icon: Icons.credit_card_outlined,
          label: 'Pay',
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
                'Quick action',
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
