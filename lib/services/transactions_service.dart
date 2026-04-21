import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/transactions_model.dart';
import '../utils/api_endpoints.dart';

final box = GetStorage();

class TransactionsApi {
  Future<TransactionsModel> fetchtransaction(int pageNo, int limit) async {
    final url = Uri.parse(
      "${ApiEndPoints.baseUrl}topup?page=$pageNo&$limit=20&transaction_type=${box.read("transaction_type")}&start_date=${box.read("start_date")}&end_date=${box.read("end_date")}&min_amount=${box.read("min_amount")}&max_amount=${box.read("max_amount")}",
    );
    print(url);
    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
    );

    if (response.statusCode == 200) {
      // print(response.body.toString());
      final transactionModel = TransactionsModel.fromJson(
        json.decode(response.body),
      );

      return transactionModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
