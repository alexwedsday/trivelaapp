import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivelaapp/model/campeonato_model.dart';
import 'package:trivelaapp/response/campeonato_response.dart';

class CampeonatoRepository {
  Map<String, String> _headers;

  Future<CampeonatoResponse> getCampeonatos() async {
    final String URL = 'https://app.trivelaligas.com/api/auth/campeonatos';
    final token = await getToken();
    CampeonatoResponse campeonatoResponse;
    this._headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    try {
      http.Response response = await http.get(URL, headers: _headers);
      print('body: ${response.body} \n status: ${response.statusCode}');

      if (response.statusCode == 200) {
        campeonatoResponse =
            CampeonatoResponse.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return campeonatoResponse;
  }

  Future<List<CampeonatoModel>> pagination(int pageKey, int pageSize) async {
    CampeonatoResponse response = await getCampeonatos();
    List<CampeonatoModel> campeonatos = <CampeonatoModel>[];
    if (response != null && !response.error) {
      campeonatos = response.lista;
      if (campeonatos.isNotEmpty) {
        int length = campeonatos.length;
        final int start = (pageKey - 1) * pageSize;
        final isValidPage = length < start;
        if (!isValidPage) {
          final int end = min(start + pageSize, length);
          return campeonatos.sublist(start, end);
        }
      }
    }
    return <CampeonatoModel>[];
  }

  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    return token;
  }
}
