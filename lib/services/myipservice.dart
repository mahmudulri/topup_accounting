import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ipdetails_model.dart';

class MyipApi {
  Future<MyIpdetailsModel> fetchIP() async {
    final url = Uri.parse("https://proxycheck.io/v3/102.86.220.205");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body.toString());
      final ipdatamodel = MyIpdetailsModel.fromJson(json.decode(response.body));

      return ipdatamodel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
