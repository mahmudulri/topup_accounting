import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/package_model.dart';
import '../models/profit_model.dart';
import '../utils/api_endpoints.dart';

final box = GetStorage();

class PackagesLisApi {
  Future<PackagesModel> fetchpackages() async {
    final url = Uri.parse("${ApiEndPoints.baseUrl}subscription-packages");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      // print(response.body.toString());
      final packageModel = PackagesModel.fromJson(json.decode(response.body));

      return packageModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
