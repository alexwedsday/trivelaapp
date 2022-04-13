import 'package:flutter/cupertino.dart';
import 'package:trivelaapp/model/user_model.dart';
import 'package:trivelaapp/repository/signin_repository.dart';
import 'package:trivelaapp/response/signin_response.dart';

class SigninController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SigninRepository _repository;
  UserModel userModel = UserModel();

  SigninController(this._repository);

  Future<SigninResponse> doRegister() async {
    var signinResponse;

    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      try {
        signinResponse = await _repository.doRegister(userModel);
      } catch (e) {}
    }
    return signinResponse;
  }

  username(String value) => userModel.name = value;

  userEmail(String value) => userModel.email = value;

  userPassword(String value) => userModel.password = value;
}
