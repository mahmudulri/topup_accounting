import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/resellerlist_model.dart';
import '../models/supplierlist_model.dart';
import '../utils/api_endpoints.dart';

final box = GetStorage();

class ResellerlistApi {
  Future<ResellerListModel> fetchReseller() async {
    final url = Uri.parse("${ApiEndPoints.baseUrl}resellers");

    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
    );

    if (response.statusCode == 200) {
      // print(response.body.toString());
      final resellerListModel = ResellerListModel.fromJson(
        json.decode(response.body),
      );

      return resellerListModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
