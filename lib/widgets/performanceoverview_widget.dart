import 'package:flutter/material.dart';

class PerformanceOverviewCard extends StatelessWidget {
  final String revenue;
  final String? revenueChange; // e.g. "+12.5%"
  final bool revenuePositive;

  final String cost;
  final String? costChange; // e.g. "-8.2%"
  final bool costPositive;

  final String profitMargin; // e.g. "-1062.9%"
  final String profitLabel; // e.g. "Overall"

  final String netBonus; // e.g. "+53.8K"
  final String netBonusLabel; // e.g. "units"

  const PerformanceOverviewCard({
    super.key,
    required this.revenue,
    this.revenueChange,
    required this.revenuePositive,
    required this.cost,
    this.costChange,
    required this.costPositive,
    required this.profitMargin,
    required this.profitLabel,
    required this.netBonus,
    required this.netBonusLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.bar_chart_rounded,
                      color: Color(0xFF6366F1),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Performance Overview',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E1E2D),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Revenue & Cost Row
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  label: 'Revenue',
                  value: revenue,
                  change: revenueChange,
                  isPositive: revenuePositive,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  label: 'Cost',
                  value: cost,
                  change: costChange,
                  isPositive: costPositive,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Profit Margin & Net Bonus Row
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  label: 'Profit Margin',
                  value: profitMargin,
                  subLabel: profitLabel,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  label: 'Net Bonus',
                  value: netBonus,
                  subLabel: netBonusLabel,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String? change;
  final bool? isPositive;
  final String? subLabel;

  const _MetricCard({
    required this.label,
    required this.value,
    this.change,
    this.isPositive,
    this.subLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E1E2D),
            ),
          ),
          const SizedBox(height: 4),
          if (change != null)
            Text(
              change!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: (isPositive ?? true)
                    ? const Color(0xFF22C55E)
                    : const Color(0xFFEF4444),
              ),
            ),
          if (subLabel != null)
            Text(
              subLabel!,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF9CA3AF),
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
    );
  }
}
