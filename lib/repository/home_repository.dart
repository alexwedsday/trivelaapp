import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivelaapp/response/saldo_response.dart';

class HomeRepository {
  Map<String, String> _headers;

  Future<SaldoResponse> getSaldoReal() async {
    final String URL = 'https://app.trivelaligas.com/api/auth/saldo/real';
    final token = await getToken();
    SaldoResponse saldoResponse;
    this._headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    try {
      http.Response response = await http.post(URL, headers: _headers);
      print('body: ${response.body} \n status: ${response.statusCode}');

      if (response.statusCode == 200) {
        saldoResponse = SaldoResponse.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return saldoResponse;
  }

  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    return token;
  }
}
