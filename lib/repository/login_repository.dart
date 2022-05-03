import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivelaapp/model/user_model.dart';
import 'package:trivelaapp/response/response_model.dart';
import 'package:trivelaapp/response/user_response.dart';
import 'package:trivelaapp/shared/trivela_api.dart';

class LoginRepository {
  final Map<String, String> _headers = {"Content-Type": "application/json"};
  final String _PATH = '/api/auth/login';

  Future<ResponseModel> login(UserModel user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ResponseModel responseModel;
    try {
      String body = jsonEncode(user.toJsonLogin());
      http.Response response = await http.post(TrivelaApi.BASE_API + _PATH,
          headers: _headers, body: body);
      print('body: ${response.body} \n status: ${response.statusCode}');

      if (response.statusCode == 200) {
        responseModel = ResponseModel.fromJson(jsonDecode(response.body));
        preferences.setString('userData', jsonEncode(responseModel.userData));
      }
    } catch (e) {
      print(e);
    }
    return responseModel;
  }

  Future<UserResponse> doUpdate(UserResponse user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserResponse userResponse;
    final String token = preferences.get('token');
    Map<String, String> headers = {
      'token': token,
    };
    final String _USER_PATH = TrivelaApi.BASE_API + '/api/auth/users/general';

    String body = jsonEncode(user.toJson());
    http.Response response =
        await http.post(_USER_PATH, headers: headers, body: body);

    if (response.statusCode == 200) {
      userResponse = UserResponse.fromJson(jsonDecode(response.body));
    }

    return userResponse;
  }
}
