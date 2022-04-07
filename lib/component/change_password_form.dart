import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivelaapp/controller/settings_controller.dart';
import 'package:validators/validators.dart' as validator;

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  SettingsController controller;
  bool _isLoading = false;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    controller = SettingsController();
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
                    children: [
                      Positioned(
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 32),
                                  TextFormField(
                                      obscureText: _isVisible,
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        labelText: 'Senha Antiga',
                                        labelStyle:
                                            TextStyle(color: Colors.black),
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
                                      validator: (value) => _isPwd(value),
                                      onSaved: (value) => {value}),
                                  SizedBox(height: 32),
                                  TextFormField(
                                      obscureText: _isVisible,
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        labelText: 'Senha Nova',
                                        labelStyle:
                                            TextStyle(color: Colors.black),
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
                                      validator: (value) => _isPwd(value),
                                      onSaved: (value) => {value}),
                                  SizedBox(height: 32),
                                  _isLoading
                                      ? Center(
                                          child: Container(
                                              child: CircularProgressIndicator(
                                          backgroundColor: Colors.amber,
                                        )))
                                      : Container(
                                          height: 50,
                                          width: double.infinity,
                                          color: Color.fromRGBO(
                                              242, 210, 110, 1.0),
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'Redefinir Senha',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                        ),
                                  SizedBox(height: 32),
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

  String _isPwd(String value) {
    String str = '';

    if (validator.isNull(value))
      str = 'É necessário digitar uma senha';
    else if (validator.isLength(str, 6)) str = 'Senha mínimo de 6 caracteres';

    return str;
  }
}
