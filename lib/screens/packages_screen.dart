import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topup_accounting/models/package_model.dart';
import '../controllers/packagelist_controller.dart';
import '../utils/colors.dart';
import '../widgets/request_widget.dart';

class PackagesScreen extends StatefulWidget {
  PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  PackagelistController controller = Get.put(PackagelistController());

  @override
  void initState() {
    super.initState();

    controller.fetchpackagesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      appBar: AppBar(
        title: const Text(
          "Packages",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search_rounded), onPressed: () {}),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) return _buildLoading();
        if (controller.errorMessage.isNotEmpty) return _buildError();
        return _buildBody();
      }),
    );
  }

  Widget _buildLoading() => const Center(
    child: CircularProgressIndicator(
      strokeWidth: 3,
      valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
    ),
  );

  Widget _buildError() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline_rounded,
          size: 64,
          color: AppColors.bodyText.withOpacity(0.4),
        ),
        const SizedBox(height: 16),
        Text(
          controller.errorMessage.value,
          style: TextStyle(color: AppColors.bodyText, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: controller.fetchpackagesData,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text("Retry"),
        ),
      ],
    ),
  );

  Widget _buildBody() => Column(
    children: [
      _buildFilterBar(),
      Expanded(child: _buildList()),
    ],
  );

  Widget _buildFilterBar() {
    final filters = [
      (label: "All", filter: PackageFilter.all),
      (label: "🔥 Featured", filter: PackageFilter.featured),
      (label: "🌐 Web", filter: PackageFilter.web),
      (label: "📱 Mobile", filter: PackageFilter.mobile),
      (label: "💻📱 Both", filter: PackageFilter.both),
    ];

    return Obx(() {
      final packages = controller.allpackages.value.packages ?? [];

      int countFor(PackageFilter f) => switch (f) {
        PackageFilter.all => packages.length,
        PackageFilter.featured =>
          packages.where((p) => p.isFeatured == true).length,
        PackageFilter.web => packages.where((p) => p.webAccess == true).length,
        PackageFilter.mobile =>
          packages.where((p) => p.mobileAccess == true).length,
        PackageFilter.both =>
          packages
              .where((p) => p.webAccess == true && p.mobileAccess == true)
              .length,
      };

      return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final item = filters[i];
              return Obx(() {
                final selected = controller.selectedFilter.value == item.filter;
                return FilterChip(
                  label: Text("${item.label}  ${countFor(item.filter)}"),
                  selected: selected,
                  onSelected: (_) =>
                      controller.selectedFilter.value = item.filter,
                  backgroundColor: Colors.white,
                  selectedColor: AppColors.primaryColor.withOpacity(0.1),
                  checkmarkColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  visualDensity: VisualDensity.compact,
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: selected
                          ? AppColors.primaryColor
                          : Colors.grey.shade300,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: selected
                        ? AppColors.primaryColor
                        : Colors.grey.shade600,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 12,
                  ),
                );
              });
            },
          ),
        ),
      );
    });
  }

  Widget _buildList() {
    if (controller.filteredPackages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: AppColors.bodyText.withOpacity(0.3),
            ),
            const SizedBox(height: 12),
            Text(
              "No packages found",
              style: TextStyle(
                fontSize: 15,
                color: AppColors.bodyText.withOpacity(0.6),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: controller.filteredPackages.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (_, i) =>
          _PackageCard(package: controller.filteredPackages[i]),
    );
  }
}

// ─────────────────────────────────────────────
// Package Card — 1 per row, matches reference UI
// ─────────────────────────────────────────────
class _PackageCard extends StatelessWidget {
  final Package package;
  const _PackageCard({required this.package});

  @override
  Widget build(BuildContext context) {
    final p = package;
    final featured = p.isFeatured == true;
    final hasWeb = p.webAccess == true;
    final hasMobile = p.mobileAccess == true;

    String accessLabel() {
      if (hasWeb && hasMobile) return "Web & Mobile";
      if (hasWeb) return "Web";
      if (hasMobile) return "Mobile";
      return "—";
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Card body
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: featured
                  ? AppColors.primaryColor.withOpacity(0.4)
                  : Colors.grey.shade200,
              width: featured ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: featured
                    ? AppColors.primaryColor.withOpacity(0.08)
                    : Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + access badge
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      p.name ?? "",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _AccessBadge(label: accessLabel()),
                ],
              ),

              const SizedBox(height: 6),

              // Description
              Text(
                p.description ?? "",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                  height: 1.45,
                ),
              ),

              const SizedBox(height: 16),

              // Price
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "${p.price}",
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    p.currency ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),
              Divider(color: Colors.grey.shade100, height: 1),
              const SizedBox(height: 14),

              // Duration row
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 15,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${p.durationValue} ${p.durationType}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Features
              if (hasWeb)
                _featureRow(
                  "Web Access",
                  Colors.green.shade500,
                  Icons.check_circle_outline_rounded,
                ),
              if (hasMobile)
                _featureRow(
                  "Mobile Access",
                  Colors.green.shade500,
                  Icons.check_circle_outline_rounded,
                ),
              _featureRow(
                "24/7 Support",
                Colors.blue.shade400,
                Icons.shield_outlined,
              ),
              _featureRow(
                "Free Updates",
                Colors.purple.shade400,
                Icons.trending_up_rounded,
              ),

              const SizedBox(height: 20),

              // Buy Now button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => RequestPackageSheet.show(package: p),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Buy Now",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Featured badge — flush with top-right corner of the card
        if (featured)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: const BoxDecoration(
                color: Color(0xFFF5A623),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star_rounded, size: 12, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    "Featured",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _featureRow(String label, Color iconColor, IconData icon) => Padding(
    padding: const EdgeInsets.only(bottom: 9),
    child: Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );

  void _showPurchaseDialog(Package p) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 28,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                p.name ?? "",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                "${p.price} ${p.currency}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${p.durationValue} ${p.durationType} plan",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: Get.back,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        Get.snackbar(
                          "✓ Purchased",
                          "${p.name} activated successfully",
                          backgroundColor: Colors.green.shade600,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(12),
                          borderRadius: 12,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Confirm"),
                    ),
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

// ─────────────────────────────────────────────
// Access Badge
// ─────────────────────────────────────────────
class _AccessBadge extends StatelessWidget {
  final String label;
  const _AccessBadge({required this.label});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: const Color(0xFFE8F4FD),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.monitor_rounded, size: 12, color: Colors.blue.shade400),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.blue.shade500,
          ),
        ),
      ],
    ),
  );
}
