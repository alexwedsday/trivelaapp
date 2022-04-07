import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivelaapp/controller/login_controller.dart';
import 'package:trivelaapp/page/home_page.dart';
import 'package:trivelaapp/page/signin_page.dart';
import 'package:trivelaapp/repository/login_repository.dart';
import 'package:trivelaapp/response/response_model.dart';
import 'package:trivelaapp/shared/trivela_assets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController _controller;
  bool _isVisible = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = LoginController(LoginRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            child: Container(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              child: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 200,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Image(
                              width: 200,
                              image: AssetImage(TrivelaAssets.logoPng),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      Positioned(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Form(
                              key: _controller.formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'E-mail',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  242, 210, 110, 1.0))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  242, 210, 110, 1.0))),
                                    ),
                                    onSaved: (value) =>
                                        _controller.userEmail(value),
                                  ),
                                  const SizedBox(height: 32),
                                  TextFormField(
                                    obscureText: _isVisible,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Senha',
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      suffixIcon: IconButton(
                                          onPressed: () => _showPassword(),
                                          icon: Icon(_isVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  242, 210, 110, 1.0))),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  242, 210, 110, 1.0))),
                                    ),
                                    onSaved: (value) =>
                                        _controller.userPassword(value),
                                  ),
                                  const SizedBox(height: 32),
                                  _isLoading
                                      ? Center(
                                          child: Container(
                                              child:
                                                  const CircularProgressIndicator(
                                          backgroundColor: Colors.amber,
                                        )))
                                      : Container(
                                          height: 50,
                                          width: double.infinity,
                                          color: const Color.fromRGBO(
                                              242, 210, 110, 1.0),
                                          child: TextButton(
                                            child: const Text(
                                              'Entrar',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0),
                                            ),
                                            onPressed: () =>
                                                {_goToHome(context)},
                                          ),
                                        ),
                                  const SizedBox(height: 32),
                                  Container(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            1, 32, 1, 0),
                                        child: RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                            children: <TextSpan>[
                                              const TextSpan(
                                                  text:
                                                      'Novo em nossa plataforma?'),
                                              TextSpan(
                                                  text:
                                                      ' Crie a sua conta aqui.',
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () => {
                                                              _goToSignin(
                                                                  context)
                                                            },
                                                  style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          242, 210, 110, 1.0)))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
            ),
          ),
        )),
      ],
    );
  }

  void _showPassword() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _goToSignin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SigninPage()));
  }

  void _goToHome(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    ResponseModel responseModel = await _controller.doLogin();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (responseModel != null &&
        !responseModel.error &&
        responseModel.accessToken.isNotEmpty) {
      if (preferences.containsKey('token')) {
        preferences.clear();
      }
      setState(() {
        _isLoading = false;
      });
      preferences.setString('token', responseModel.accessToken);
      _setUser(responseModel.userData);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage(index: 0)));
    } else {
      setState(() {
        _isLoading = false;
      });
      final String title = 'Ops';
      final String message = responseModel.message;
      _showDialog(title, message);
    }
  }

  _showDialog(String title, String message) {
    setState(() {
      _isLoading = false;
    });

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    title == 'Ops!'
                        ? Navigator.pop(context)
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                  },
                  child: const Text('Fechar'))
            ],
          );
        });
  }

  void _setUser(Object user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user);
    preferences.setString('userData', userJson);
  }
}
