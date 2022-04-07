import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:trivelaapp/model/user_model.dart';
import 'package:trivelaapp/repository/login_repository.dart';
import 'package:trivelaapp/response/response_model.dart';

class LoginController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final LoginRepository _repository;
  UserModel userModel = UserModel();

  LoginController(this._repository);

  Future<ResponseModel> doLogin() async {
    var responseModel;

    try {
      formKey.currentState.save();
      responseModel = await _repository.login(userModel);
    } catch (e) {}

    return responseModel;
  }

  userEmail(String value) => userModel.email = value;

  userPassword(String value) => userModel.password = value;
}
