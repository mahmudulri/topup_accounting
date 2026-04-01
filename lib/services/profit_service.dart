import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/profit_model.dart';
import '../utils/api_endpoints.dart';

final box = GetStorage();

class ProfitApi {
  Future<ProfitModel> fetchprofit() async {
    final url = Uri.parse("${ApiEndPoints.baseUrl}topup/statistics/profit");

    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
    );

    if (response.statusCode == 200) {
      print(response.body.toString());
      final profitModel = ProfitModel.fromJson(json.decode(response.body));

      return profitModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
