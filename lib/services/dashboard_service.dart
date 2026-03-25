import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/dashboard_model.dart';
import '../utils/api_endpoints.dart';

final box = GetStorage();

class DashboardApi {
  Future<DashboardModel> fetchdashboard() async {
    final url = Uri.parse("${ApiEndPoints.baseUrl}topup/dashboard/summary");

    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
    );

    if (response.statusCode == 200) {
      // print(response.body.toString());
      final dashboardModel = DashboardModel.fromJson(
        json.decode(response.body),
      );

      return dashboardModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
