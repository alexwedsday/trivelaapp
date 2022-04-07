import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:trivelaapp/repository/settings_repository.dart';
import 'package:trivelaapp/response/user_response.dart';
import 'package:trivelaapp/shared/storage_service.dart';

class SettingsController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SettingsRepository _repository = SettingsRepository();
  UserResponse user = UserResponse.empty();

  Future<UserResponse> doGeneral() async {
    UserResponse userResponse;

    try {
      if (!formKey.currentState.validate()) {
        formKey.currentState.save();
        userResponse = await _repository.save(user);
      }
    } catch (e) {
      print(e);
    }

    return userResponse;
  }

  Future<UserResponse> getUserById() async {
    var userResponse;
    try {
      final userData = await StorageService.get('userData');
      if (userData != null && userData.isNotEmpty) {
        Map<String, dynamic> userMap = jsonDecode(userData);
        int userId = userMap['id'];

        userResponse = await _repository.findById(userId);
      }
    } catch (e) {
      print(e);
    }
    return userResponse;
  }

  id(int value) => user.id = value;
  name(String value) => user.name = value;
  cpf(String value) => user.cpf = value;
  phone(String value) => user.phone = value;
  address(String value) => user.address = value;
  email(String value) => user.email = value;
  bairro(String value) => user.bairro = value;
  numero(String value) => user.numero = value;
  cidade(String value) => user.cidade = value;
  estado(String value) => user.estado = value;
  pais(String value) => user.country = value;
  cep(String value) => user.cep = value;
  bio(String value) => user.bio = value;
}
