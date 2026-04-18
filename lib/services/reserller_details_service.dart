import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/reseller_details_model.dart';
import '../utils/api_endpoints.dart';

final box = GetStorage();

class ReserllerDetailsApi {
  Future<ResellerDetailsModel> fetchDetails(String id) async {
    final url = Uri.parse("${ApiEndPoints.baseUrl}topup?reseller_id=$id");
    print(url);
    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
    );

    if (response.statusCode == 200) {
      // print(response.body.toString());
      final resellerDetailsModel = ResellerDetailsModel.fromJson(
        json.decode(response.body),
      );

      return resellerDetailsModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
