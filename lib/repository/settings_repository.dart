import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivelaapp/model/user_object.dart';
import 'package:trivelaapp/model/user_settings_model.dart';
import 'package:trivelaapp/response/user_response.dart';
import 'package:trivelaapp/shared/trivela_api.dart';

class SettingsRepository {
  final String _URL = TrivelaApi.BASE_API + '/api/auth/users/show/';
  Map<String, String> _headers;

  Future<UserResponse> save(UserResponse user) async {
    final String _URL_SAVE = TrivelaApi.BASE_API + '/api/auth/users/add';
    UserResponse userResponse;
    final token = await getToken();
    this._headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    try {
      if (user?.id != null) {
        UserSettingsModel userSettingsModel = UserSettingsModel();
        UserObject userObject = UserObject();
        userObject.value = user;
        userSettingsModel.usuario = userObject;

        final String body = jsonEncode(userSettingsModel.toJson());
        final http.Response response =
            await http.post(_URL_SAVE, headers: _headers, body: body);
        print('response: ${response?.body} ${response.statusCode}');
        if (response.statusCode == 200) {
          userResponse = UserResponse.fromJson(jsonDecode(response.body));
          print('repository ${userResponse}');
        }
      }
    } catch (e) {}
    return userResponse;
  }

  Future<UserResponse> findById(int userId) async {
    UserResponse userResponse;
    final token = await getToken();
    this._headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };

    try {
      if (userId != null) {
        final http.Response response =
            await http.get(_URL + userId.toString(), headers: _headers);
        print('response: ${response?.body} ${response.statusCode}');
        if (response.statusCode == 200) {
          userResponse = UserResponse.fromJson(jsonDecode(response.body));
          print('repository ${userResponse.toString()}');
        }
      }
    } catch (e) {}
    return userResponse;
  }

  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    return token;
  }
}
