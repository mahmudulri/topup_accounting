import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topup_accounting/controllers/transactions_controller.dart';
import 'package:topup_accounting/widgets/financecardreport.dart';

import '../controllers/profit_controller.dart';
import '../global_controllers/languages_controller.dart';
import '../helpers/report_helper.dart';
import '../models/monthly_model.dart';
import '../models/transactions_model.dart';
import '../utils/colors.dart';
import '../widgets/custom_text.dart';

class ReportsScreen extends StatefulWidget {
  ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final languagesController = Get.find<LanguagesController>();

  TransactionListController transactionListController = Get.put(
    TransactionListController(),
  );

  ProfitController profitController = Get.put(ProfitController());
  final box = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profitController.fetchprofitData();
    transactionListController.fetchtransactions(1000);
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
              text: languagesController.tr("REPORTS"),
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.titleText,
            ),
          ],
        ),
        actions: [],
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Obx(
            () =>
                transactionListController.isLoading.value == false &&
                    profitController.isLoading.value == false
                ? ListView(
                    children: [
                      Container(
                        height: 160,
                        width: screenWidth,

                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ReportContainer(
                                        title: "Total Revenue",
                                        value: profitController
                                            .allprofitData
                                            .value
                                            .profitAnalysis!
                                            .total!
                                            .revenue
                                            .toString(),
                                        myicon: Icons.attach_money,
                                        mycolor: AppColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      flex: 1,
                                      child: ReportContainer(
                                        title: "Total Cost",
                                        value: profitController
                                            .allprofitData
                                            .value
                                            .profitAnalysis!
                                            .total!
                                            .cost
                                            .toString(),
                                        myicon: Icons.trending_down,
                                        mycolor: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ReportContainer(
                                        title: "Total Profit",
                                        value: profitController
                                            .allprofitData
                                            .value
                                            .profitAnalysis!
                                            .total!
                                            .profit
                                            .toString(),
                                        myicon: Icons.trending_up,
                                        mycolor: Colors.green,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      flex: 1,
                                      child: ReportContainer(
                                        title: "Total Transactions",
                                        value: transactionListController
                                            .alltransactions
                                            .value
                                            .pagination!
                                            .totalRecords
                                            .toString(),
                                        myicon: Icons.show_chart,
                                        mycolor: Colors.purple,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      buildMonthlyChartCustom(),
                      buildMonthYearFilter(),
                      Obx(() => buildDailyBreakdown()),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

class ReportContainer extends StatelessWidget {
  final String? title;
  final String? value;
  final IconData? myicon;
  final Color? mycolor;

  ReportContainer({
    super.key,
    this.title,
    this.value,
    this.myicon,
    this.mycolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: mycolor!.withAlpha(20),
                child: Icon(myicon, color: mycolor),
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: title.toString(),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 5),
                  Text(
                    value.toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildDailyBreakdown() {
  final controller = Get.find<TransactionListController>();

  final box = GetStorage();

  List<DailyReport> data = generateDailyReport(
    controller.alltransactions.value.transactions ?? [],
  );

  Widget headerCell(
    String text, {
    int flex = 1,
    TextAlign align = TextAlign.left,
  }) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget dataCell(
    String text, {
    int flex = 1,
    TextAlign align = TextAlign.left,
    Color? color,
    FontWeight? weight,
  }) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: weight ?? FontWeight.w500,
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.only(top: 15),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TITLE
        Text(
          "Daily Breakdown",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),

        /// 🔥 NO DATA
        if (data.isEmpty)
          Container(
            height: 150,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.insert_chart_outlined_rounded,
                  size: 40,
                  color: Colors.grey.shade400,
                ),
                SizedBox(height: 10),
                Text(
                  "No Data Found",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          )
        else ...[
          /// HEADER
          Row(
            children: [
              headerCell("Date", flex: 2),
              headerCell("Purchases", flex: 2, align: TextAlign.center),
              headerCell("Sales", flex: 2, align: TextAlign.right),
              headerCell("Profit", flex: 2, align: TextAlign.right),
            ],
          ),
          SizedBox(height: 8),
          Divider(),

          /// LIST
          ListView.separated(
            itemCount: data.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = data[index];

              return Row(
                children: [
                  /// DATE
                  dataCell(item.date, flex: 2),

                  /// PURCHASE
                  dataCell(
                    "${box.read("currencyCode")} ${item.purchases.toStringAsFixed(0)}",
                    flex: 2,
                    align: TextAlign.right,
                    color: Colors.blue,
                  ),

                  /// SALES
                  dataCell(
                    "${box.read("currencyCode")} ${item.sales.toStringAsFixed(0)}",
                    flex: 2,
                    align: TextAlign.right,
                    color: Colors.green,
                  ),

                  /// PROFIT
                  dataCell(
                    "${item.profit >= 0 ? '+' : ''}${box.read("currencyCode")} ${item.profit.toStringAsFixed(0)}",
                    flex: 2,
                    align: TextAlign.right,
                    color: item.profit >= 0 ? Colors.green : Colors.red,
                    weight: FontWeight.bold,
                  ),
                ],
              );
            },
          ),
        ],
      ],
    ),
  );
}

var selectedMonth = DateTime.now().month.obs;
var selectedYear = DateTime.now().year.obs;

List<String> monthNames = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

List<DailyReport> generateDailyReport(List<Transaction> list) {
  Map<String, DailyReport> map = {};

  for (var t in list) {
    final date = t.transactionDate;

    if (date == null) continue;

    /// 🔥 FILTER BY MONTH + YEAR
    if (date.month != selectedMonth.value || date.year != selectedYear.value) {
      continue;
    }

    String key = date.toString().split(" ")[0];

    if (!map.containsKey(key)) {
      map[key] = DailyReport(date: key, purchases: 0, sales: 0);
    }

    if (t.transactionType == "purchase") {
      map[key] = DailyReport(
        date: key,
        purchases: map[key]!.purchases + t.totalAmountDouble,
        sales: map[key]!.sales,
      );
    } else if (t.transactionType == "sale") {
      map[key] = DailyReport(
        date: key,
        purchases: map[key]!.purchases,
        sales: map[key]!.sales + t.totalAmountDouble,
      );
    }
  }

  return map.values.toList()..sort((a, b) => b.date.compareTo(a.date));
}

Widget buildMonthYearFilter() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        /// MONTH
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: selectedMonth.value,
                  items: List.generate(12, (index) {
                    return DropdownMenuItem(
                      value: index + 1,
                      child: Text(monthNames[index]),
                    );
                  }),
                  onChanged: (value) {
                    selectedMonth.value = value!;
                  },
                ),
              ),
            ),
          ),
        ),

        SizedBox(width: 10),

        /// YEAR
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: selectedYear.value,
                  items: List.generate(5, (index) {
                    int year = DateTime.now().year - index;
                    return DropdownMenuItem(
                      value: year,
                      child: Text(year.toString()),
                    );
                  }),
                  onChanged: (value) {
                    selectedYear.value = value!;
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

List<MonthlyReport> generateMonthlyReport(List<Transaction> list) {
  int currentYear = DateTime.now().year;

  Map<int, MonthlyReport> map = {
    for (int i = 1; i <= 12; i++) i: MonthlyReport(month: i),
  };

  for (var t in list) {
    final date = t.transactionDate;
    if (date == null) continue;

    /// 🔥 ONLY CURRENT YEAR
    if (date.year != currentYear) continue;

    int month = date.month;

    if (t.transactionType == "purchase") {
      map[month]!.purchases += t.totalAmountDouble;
    } else if (t.transactionType == "sale") {
      map[month]!.sales += t.totalAmountDouble;
    }
  }

  return map.values.toList();
}

Widget buildMonthlyChartCustom() {
  final controller = Get.find<TransactionListController>();

  List<MonthlyReport> data = generateMonthlyReport(
    controller.alltransactions.value.transactions ?? [],
  );

  double maxValue = _getMaxY(data);

  return Container(
    margin: EdgeInsets.only(top: 15),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Monthly Performance - ${DateTime.now().year}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 20),

        /// 🔥 CHART + Y AXIS
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /// LEFT SCALE
            _buildYAxis(maxValue),

            SizedBox(width: 8),

            /// CHART
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(data.length, (index) {
                    return _monthBarItem(data[index], maxValue);
                  }),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 15),

        /// LEGEND
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _legend("Purchases", Colors.blue),
            SizedBox(width: 10),
            _legend("Sales", Colors.green),
            SizedBox(width: 10),
            _legend("Profit", Colors.orange),
          ],
        ),
      ],
    ),
  );
}

// double _getMaxY(List<MonthlyReport> data) {
//   double maxVal = 0;

//   for (var e in data) {
//     maxVal = [maxVal, e.purchases, e.sales].reduce((a, b) => a > b ? a : b);
//   }

//   return maxVal == 0 ? 100 : maxVal * 1.2;
// }

Widget _legend(String text, Color color) {
  return Row(
    children: [
      Container(width: 10, height: 10, color: color),
      SizedBox(width: 4),
      Text(text),
    ],
  );
}

String _monthShort(int month) {
  const m = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  return m[month - 1]; // 🔥 FIX
}

String _monthName(int month) {
  const m = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  return m[month - 1];
}

Widget _monthBarItem(MonthlyReport item, double maxValue) {
  double chartHeight = 180;

  double purchaseH = (item.purchases / maxValue) * chartHeight;
  double salesH = (item.sales / maxValue) * chartHeight;
  double profitH = (item.profit.abs() / maxValue) * chartHeight;

  return Container(
    width: 60,
    margin: EdgeInsets.only(right: 12),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /// BAR AREA
        Container(
          height: chartHeight,
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _bar(purchaseH, Colors.blue),
              SizedBox(width: 3),
              _bar(salesH, Colors.green),
              SizedBox(width: 3),
              _bar(profitH, item.profit >= 0 ? Colors.orange : Colors.red),
            ],
          ),
        ),

        SizedBox(height: 6),

        Text(_monthShort(item.month), style: TextStyle(fontSize: 11)),
      ],
    ),
  );
}

Widget _bar(double height, Color color) {
  return Container(
    width: 6,
    height: height < 4 ? 4 : height,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(2),
    ),
  );
}

Widget _buildYAxis(double maxValue) {
  int steps = 5;

  return SizedBox(
    height: 180,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(steps + 1, (index) {
        double value = maxValue - (maxValue / steps) * index;

        return Text(
          _formatNumber(value),
          style: TextStyle(fontSize: 10, color: Colors.grey),
        );
      }),
    ),
  );
}

double _getMaxY(List<MonthlyReport> data) {
  double maxVal = 0;

  for (var e in data) {
    maxVal = [
      maxVal,
      e.purchases,
      e.sales,
      e.profit.abs(),
    ].reduce((a, b) => a > b ? a : b);
  }

  return maxVal == 0 ? 100 : maxVal;
}

String _formatNumber(double value) {
  if (value >= 1000000) {
    return "${(value / 1000000).toStringAsFixed(1)}M";
  } else if (value >= 1000) {
    return "${(value / 1000).toStringAsFixed(0)}K";
  } else {
    return value.toStringAsFixed(0);
  }
}
