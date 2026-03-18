import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../controllers/transactions_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../utils/colors.dart';
import '../widgets/common_appbar.dart';
import '../widgets/custom_text.dart';
import '../widgets/summarycard.dart';
import '../widgets/togglebutton.dart';

class TransactionsScreen extends StatefulWidget {
  TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  TransactionListController transactionListController = Get.put(
    TransactionListController(),
  );

  final languagesController = Get.find<LanguagesController>();

  @override
  void initState() {
    super.initState();
    box.write("startdate", "");
    box.write("enddate", "");

    transactionListController.fetchtransactions();
  }

  final List<String> items = [
    "All",
    "Purchase",
    "Sales",
    "Supplier Payment",
    "Reseller Payment",
  ];
  int selectedIndex = 0;

  bool _isGridView = true;

  bool isVisible = false;

  final box = GetStorage();

  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);

  Future<void> pickStartDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      startDate.value = picked;
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      print("Selected Start Date: $formattedDate");
      box.write("startdate", "&filter_startdate=$formattedDate");

      // Reset end date if it's before start date
      if (endDate.value != null && endDate.value!.isBefore(picked)) {
        endDate.value = null;
      }
    }
  }

  Future<void> pickEndDate(BuildContext context) async {
    if (startDate.value == null) {
      Get.snackbar(
        languagesController.tr("WARNING"),
        languagesController.tr("SELECT_START_DATE_FIRST"),
      );
      return;
    }

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value!,
      firstDate: startDate.value!, // 👈 important
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      endDate.value = picked;
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      print("Selected Start Date: $formattedDate");
      box.write("enddate", "&filter_enddate=$formattedDate");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.cardBg,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
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
              text: languagesController.tr("TRANSACTIONS"),
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.titleText,
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsetsDirectional.only(end: 12),
            child: ViewToggleButton(
              initialIsGrid: true,
              onToggle: (isGridView) {
                setState(() {
                  _isGridView = isGridView; // your state variable
                });
              },
            ),
          ),
        ],
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Obx(
            () => transactionListController.isLoading.value == false
                ? ListView(
                    children: [
                      SummaryCard(
                        totalBase: transactionListController
                            .alltransactions
                            .value
                            .summary!
                            .totalBaseAmount
                            .toString(),
                        totalPaid: transactionListController
                            .alltransactions
                            .value
                            .summary!
                            .totalPaidAmount
                            .toString(),
                        totalBonus: transactionListController
                            .alltransactions
                            .value
                            .summary!
                            .totalBonusAmount
                            .toString(),
                      ),

                      SizedBox(height: 5),
                      Container(
                        height: 50,
                        width: screenWidth,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 1,
                                    color: AppColors.borderColor,
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.search, color: Colors.grey),
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Searh transactions..",
                                              hintStyle: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 5),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.filter_alt_outlined,
                                          color: AppColors.cardBg,
                                        ),
                                        SizedBox(width: 5),
                                        KText(
                                          text: languagesController.tr(
                                            "FILTERS",
                                          ),
                                          color: AppColors.cardBg,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Visibility(
                        visible: isVisible,
                        child: Container(
                          height: 200,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColors.borderColor,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.filter_alt_outlined,
                                      color: AppColors.primaryColor,
                                    ),
                                    SizedBox(width: 5),
                                    KText(
                                      text: languagesController.tr("FILTERS"),
                                      color: AppColors.bodyText,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      child: Icon(
                                        Icons.close_sharp,
                                        color: AppColors.hintText,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    // Start date
                                    Obx(
                                      () => Expanded(
                                        child: _buildDateField(
                                          label: startDate.value == null
                                              ? languagesController.tr(
                                                  "START_DATE",
                                                )
                                              : DateFormat(
                                                  'yyyy/MM/dd',
                                                ).format(startDate.value!),
                                          onTap: () => pickStartDate(context),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // End date
                                    Obx(
                                      () => Expanded(
                                        child: _buildDateField(
                                          label: endDate.value == null
                                              ? languagesController.tr(
                                                  "END_DATE",
                                                )
                                              : DateFormat(
                                                  'yyyy/MM/dd',
                                                ).format(endDate.value!),
                                          onTap: () => pickEndDate(context),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 75,
                                  width: screenWidth,

                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          // color: Colors.cyan,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  KText(
                                                    text: languagesController
                                                        .tr("MIN_AMOUNT"),
                                                    color: AppColors.mutedText,
                                                    fontSize: 12,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color:
                                                          AppColors.borderColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                        ),
                                                    child: TextField(
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      decoration:
                                                          InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: "0.00",
                                                            hintStyle: TextStyle(
                                                              color: AppColors
                                                                  .hintText,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          // color: Colors.cyan,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  KText(
                                                    text: languagesController
                                                        .tr("MAX_AMOUNT"),
                                                    color: AppColors.mutedText,
                                                    fontSize: 12,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color:
                                                          AppColors.borderColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                        ),
                                                    child: TextField(
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      decoration:
                                                          InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: "0.00",
                                                            hintStyle: TextStyle(
                                                              color: AppColors
                                                                  .hintText,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(items.length, (index) {
                          final isSelected = selectedIndex == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });

                              print(items[index]); // selected value
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 1,
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.borderColor,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 13,
                                  vertical: 7,
                                ),
                                child: KText(
                                  text: items[index],
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),

                      SizedBox(height: 8),
                      Container(
                        height: 400,
                        width: screenWidth,

                        child: Obx(
                          () =>
                              transactionListController.isLoading.value == false
                              ? ListView.builder(
                                  itemCount: transactionListController
                                      .alltransactions
                                      .value
                                      .transactions!
                                      .length,
                                  itemBuilder: (context, index) {
                                    final data = transactionListController
                                        .alltransactions
                                        .value
                                        .transactions![index];

                                    // ── helpers ──────────────────────────────────────────────
                                    String partyName =
                                        data.supplier?.name ??
                                        data.reseller?.name ??
                                        "—";

                                    String txType;
                                    Color txColor;
                                    IconData txIcon;

                                    switch (data.transactionType.toString()) {
                                      case "purchase":
                                        txType = "Purchase";
                                        txColor = const Color(
                                          0xFF6366F1,
                                        ); // indigo
                                        txIcon = Icons.shopping_bag_outlined;
                                        break;
                                      case "reseller_payment":
                                        txType = "Reseller Payment";
                                        txColor = const Color(
                                          0xFF0EA5E9,
                                        ); // sky-blue
                                        txIcon = Icons.swap_horiz_rounded;
                                        break;
                                      case "sale":
                                        txType = "Sale";
                                        txColor = const Color(
                                          0xFF10B981,
                                        ); // emerald
                                        txIcon = Icons.point_of_sale_rounded;
                                        break;
                                      default:
                                        txType = "Supplier Payment";
                                        txColor = const Color(
                                          0xFFF59E0B,
                                        ); // amber
                                        txIcon = Icons
                                            .account_balance_wallet_outlined;
                                    }

                                    final double baseAmount =
                                        (data.baseAmount as num?)?.toDouble() ??
                                        0;
                                    final double paidAmount =
                                        (data.paidAmount as num?)?.toDouble() ??
                                        0;
                                    final double dueAmount =
                                        (data.dueAmount as num?)?.toDouble() ??
                                        0;

                                    // ── card ─────────────────────────────────────────────────
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: txColor.withOpacity(0.08),
                                            blurRadius: 16,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                        border: Border.all(
                                          color: txColor.withOpacity(0.15),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          // ── header strip ──────────────────────────────────
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: txColor.withOpacity(0.06),
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                    top: Radius.circular(16),
                                                  ),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                    7,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: txColor.withOpacity(
                                                      0.12,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: Icon(
                                                    txIcon,
                                                    size: 18,
                                                    color: txColor,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        partyName,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color(
                                                            0xFF1E293B,
                                                          ),
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(height: 1),
                                                      Text(
                                                        txType,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: txColor,
                                                          letterSpacing: 0.3,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // due-amount badge (red when > 0)
                                                if (dueAmount > 0)
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                          vertical: 4,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                        0xFFFEF2F2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                      border: Border.all(
                                                        color: const Color(
                                                          0xFFFCA5A5,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "Due ${dueAmount.toStringAsFixed(2)}",
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color(
                                                          0xFFDC2626,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),

                                          // ── amounts row ───────────────────────────────────
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                            child: Row(
                                              children: [
                                                _AmountTile(
                                                  label: "Base Amount",
                                                  value: baseAmount,
                                                  color: const Color(
                                                    0xFF64748B,
                                                  ),
                                                ),
                                                _divider(),
                                                _AmountTile(
                                                  label: "Paid Amount",
                                                  value: paidAmount,
                                                  color: const Color(
                                                    0xFF10B981,
                                                  ),
                                                ),
                                                _divider(),
                                                _AmountTile(
                                                  label: "Due Amount",
                                                  value: dueAmount,
                                                  color: dueAmount > 0
                                                      ? const Color(0xFFDC2626)
                                                      : const Color(0xFF64748B),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  )
                : Center(child: CircularProgressIndicator(color: Colors.grey)),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField({required String label, required VoidCallback onTap}) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 0.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.calendar_month_rounded,
              size: 18,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _divider() => Container(
  width: 1,
  height: 36,
  margin: const EdgeInsets.symmetric(horizontal: 8),
  color: const Color(0xFFE2E8F0),
);

class _AmountTile extends StatelessWidget {
  const _AmountTile({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Color(0xFF94A3B8),
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
