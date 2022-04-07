import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trivelaapp/model/profile_model.dart';
import 'package:trivelaapp/response/profile_response.dart';
import 'package:trivelaapp/shared/trivela_api.dart';

class ProfileRepository {
  final String _URL = TrivelaApi.BASE_API + '/api/auth/profiles';
  Map<String, String> _headers;

  Future<ProfileResponse> doPost(String token) async {
    this._headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    var profileResponse;

    try {
      http.Response response = await http.post(_URL, headers: _headers);
      print('response: ${response?.body} ${response.statusCode}');

      if (response.statusCode == 417 || response.statusCode == 200) {
        profileResponse = ProfileResponse.fromJson(jsonDecode(response.body));
        print('repository ${profileResponse}');
      }
    } catch (e) {}
    return profileResponse;
  }

  Future<ProfileResponse> doPostBody(
      String token, ProfileModel profileModel) async {
    this._headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };

    var profileResponse;

    if (profileModel != null && profileModel.usersId != null) {
      final body = jsonEncode(profileModel.toJson());
      print('Enviando para o servidor ${body}');
      try {
        http.Response response =
            await http.post(_URL + '/add', headers: _headers, body: body);
        print('response: ${response?.body} ${response.statusCode}');
        if (response.statusCode == 417 || response.statusCode == 200) {
          profileResponse = ProfileResponse.fromJson(jsonDecode(response.body));
          print('repository: ${profileResponse}');
        }
      } catch (e) {}
    }
    return profileResponse;
  }
}
