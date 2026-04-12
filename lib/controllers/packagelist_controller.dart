import 'package:get/get.dart';
import '../models/package_model.dart';
import '../services/packages_service.dart';

enum PackageFilter { all, featured, web, mobile, both }

class PackagelistController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var allpackages = PackagesModel().obs;
  var selectedFilter = PackageFilter.all.obs;

  Future<void> fetchpackagesData() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await PackagesLisApi().fetchpackages();
      allpackages.value = response;
    } catch (e) {
      errorMessage.value = "Failed to load packages";
    } finally {
      isLoading(false);
    }
  }

  /// FILTER LOGIC
  List<Package> get filteredPackages {
    final packages = allpackages.value.packages ?? [];

    switch (selectedFilter.value) {
      case PackageFilter.featured:
        return packages.where((p) => p.isFeatured == true).toList();

      case PackageFilter.web:
        return packages.where((p) => p.webAccess == true).toList();

      case PackageFilter.mobile:
        return packages.where((p) => p.mobileAccess == true).toList();

      case PackageFilter.both:
        return packages
            .where((p) => p.webAccess == true && p.mobileAccess == true)
            .toList();

      default:
        return packages;
    }
  }
}
