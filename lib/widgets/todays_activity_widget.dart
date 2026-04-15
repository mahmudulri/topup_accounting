import 'package:flutter/material.dart';

class TodaysActivityCard extends StatelessWidget {
  final String purchasesAmount;
  final int purchasesTransactions;

  final String salesAmount;
  final int salesTransactions;

  final String todaysProfit;
  final String profitMargin;
  final String dailyTarget;

  const TodaysActivityCard({
    super.key,
    required this.purchasesAmount,
    required this.purchasesTransactions,
    required this.salesAmount,
    required this.salesTransactions,
    required this.todaysProfit,
    required this.profitMargin,
    required this.dailyTarget,
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
            children: [
              const Icon(
                Icons.schedule_rounded,
                color: Color(0xFF9333EA),
                size: 22,
              ),
              const SizedBox(width: 10),
              const Text(
                "Today's Activity",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E1E2D),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Purchases Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Color(0xFF3B82F6),
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Purchases',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3B82F6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  purchasesAmount,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1E2D),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.inventory_2_outlined,
                      size: 14,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$purchasesTransactions Transactions',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Sales Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.credit_card_outlined,
                      color: Color(0xFF22C55E),
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Sales',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF22C55E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  salesAmount,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1E2D),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.people_outline,
                      size: 14,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$salesTransactions Transactions',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Today's Profit Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's Profit",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  todaysProfit,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF16A34A),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Profit Margin',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profitMargin,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF16A34A),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.track_changes_outlined,
                      size: 15,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Daily Target: $dailyTarget',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
