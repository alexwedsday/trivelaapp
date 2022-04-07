import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trivelaapp/response/time_response.dart';
import 'package:trivelaapp/shared/cartola_api.dart';

class TimeRepository {
  final String _URL = CartolaApi.AUTH_TIME;
  Map<String, String> _headers;

  Future<TimeResponse> doGet(String token) async {
    this._headers = {'Content-Type': 'application/json', 'X-GLB-Token': token};
    var timeResponse;

    try {
      http.Response response = await http.get(_URL, headers: _headers);
      print('response: ${response?.body} ${response.statusCode}');

      if (response.statusCode == 417 || response.statusCode == 200) {
        timeResponse = TimeResponse.fromJson(jsonDecode(response.body));
        print('repository ${timeResponse}');
      }
    } catch (e) {}
    return timeResponse;
  }
}
