import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/resellerlist_model.dart';
import '../models/supplier_details_model.dart';
import '../utils/api_endpoints.dart';

final box = GetStorage();

class SupplierDetailsApi {
  Future<SupplierDetailsModel> fetchDetails(String id) async {
    final url = Uri.parse(
      "${ApiEndPoints.baseUrl}topup/supplier/statistics/$id",
    );
    print(url);
    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
    );

    if (response.statusCode == 200) {
      // print(response.body.toString());
      final suppliderdetailsModel = SupplierDetailsModel.fromJson(
        json.decode(response.body),
      );

      return suppliderdetailsModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
