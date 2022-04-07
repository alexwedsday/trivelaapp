import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trivelaapp/model/user_model.dart';
import 'package:trivelaapp/response/signin_response.dart';
import 'package:trivelaapp/shared/trivela_api.dart';

class SigninRepository {
  final String _PATH = '/api/auth/register';
  final Map<String, String> _headers = {"Content-Type": "application/json"};

  Future<SigninResponse> doRegister(UserModel userModel) async {
    var siginResponse = null;
    String body = jsonEncode(userModel.toJson());

    try {
      http.Response response = await http.post(TrivelaApi.BASE_API + _PATH,
          headers: _headers, body: body);
      print('response: ${response?.body} ${response.statusCode}');

      if (response.statusCode == 200) {
        siginResponse = SigninResponse.fromJson(jsonDecode(response.body));
        print('repository ${siginResponse}');
      }
    } catch (e) {}
    return siginResponse;
  }
}
