import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/supplierlist_model.dart';
import '../utils/api_endpoints.dart';

final box = GetStorage();

class SupplierlistApi {
  Future<SuppliersListModel> fetchsupplier() async {
    final url = Uri.parse("${ApiEndPoints.baseUrl}suppliers");

    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
    );

    if (response.statusCode == 200) {
      // print(response.body.toString());
      final supplierlistModel = SuppliersListModel.fromJson(
        json.decode(response.body),
      );

      return supplierlistModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
