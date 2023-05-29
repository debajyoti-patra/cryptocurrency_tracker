import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static Future<List<dynamic>> getMarkets() async {
    try {
      var response = await http.get(
        Uri.parse(
            'https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=20&page=1&sparkline=false&locale=en'),
      );
      var result = jsonDecode(response.body);
      print('result');
      print(result);
      List markets = result as List<dynamic>;
      return markets;
    } catch (ex) {
      return [];
    }
  }

  static Future<List<dynamic>> getChartData(String id) async {

    var response = await http.get(
      Uri.parse(
          'https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=inr&days=7'),
    );
    var result = jsonDecode(response.body);
   var list =  result['prices'];
   return list;
  }
}
