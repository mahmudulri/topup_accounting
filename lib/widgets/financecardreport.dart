import 'package:flutter/material.dart';

class FinanceDashboard extends StatelessWidget {
  const FinanceDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Data for the grid items
    final List<GridItem> gridItems = [
      GridItem(
        title: 'Total Revenue',
        value: '1.3L',
        icon: Icons.currency_rupee,
        color: Colors.white,
        textColor: Colors.black87,
      ),
      GridItem(
        title: 'Total Cost',
        value: '9.3L',
        icon: Icons.shopping_cart,
        color: Colors.white,
        textColor: Colors.black87,
      ),
      GridItem(
        title: 'Total Profit',
        value: '-797449.94',
        icon: Icons.trending_up,
        color: Colors.white,
        textColor: Colors.redAccent,
      ),
      GridItem(
        title: 'Total Transactions',
        value: '53',
        icon: Icons.swap_horiz,
        color: Colors.white,
        textColor: Colors.black87,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two cards per row
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.5, // Width > Height for rectangular cards
                ),
                itemCount: gridItems.length,
                itemBuilder: (context, index) {
                  final item = gridItems[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: item.color,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                item.icon,
                                size: 24,
                                color: Colors.grey[700],
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            item.value,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: item.textColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GridItem {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color textColor;

  GridItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.textColor,
  });
}

void main() {
  runApp(
    const MaterialApp(
      home: FinanceDashboard(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
