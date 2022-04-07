import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivelaapp/controller/settings_controller.dart';
import 'package:trivelaapp/page/home_page.dart';
import 'package:trivelaapp/response/user_response.dart';
import 'package:validators/validators.dart' as validator;

class SettingsGeneralForm extends StatefulWidget {
  @override
  _SettingsGeneralForm createState() => _SettingsGeneralForm();
}

class _SettingsGeneralForm extends State<SettingsGeneralForm> {
  SettingsController _controller;
  bool _isLoading = false;
  UserResponse _user;
  var _fullNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _cpfController = TextEditingController();
  var _phoneController = TextEditingController();

  @override
  void initState() {
    _controller = SettingsController();
    _populateUser();
    super.initState();
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
                              key: _controller.formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: _fullNameController,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Nome',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
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
                                    validator: (value) => _strValid(value),
                                    onSaved: (value) => _controller.name(value),
                                  ),
                                  SizedBox(height: 32),
                                  TextFormField(
                                    controller: _cpfController,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'CPF',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
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
                                    validator: (value) => _strValid(value),
                                    onSaved: (value) => _controller.cpf(value),
                                  ),
                                  SizedBox(height: 32),
                                  TextFormField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Telefone',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
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
                                    validator: (value) => _strValid(value),
                                    onSaved: (value) =>
                                        _controller.phone(value),
                                  ),
                                  SizedBox(height: 32),
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'E-mail',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
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
                                        _controller.email(value),
                                    validator: (value) => _isEmail(value),
                                  ),
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
                                            onPressed: () {
                                              _save();
                                            },
                                            child: Text(
                                              'Salvar Alterações',
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

  String _isEmail(String value) {
    String str = '';
    if (validator.isNull(value))
      str = 'É necessário digitar um e-mail';
    else if (!validator.isEmail(value)) str = 'E-mail invalido';

    return str;
  }

  String _isPwd(String value) {
    String str = '';

    if (validator.isNull(value))
      str = 'É necessário digitar uma senha';
    else if (validator.isLength(str, 6)) str = 'Senha mínimo de 6 caracteres';

    return str;
  }

  String _strValid(String value) {
    String str = '';

    if (validator.isNull(value))
      str = 'É necessário digitar um nome';
    else if (validator.isLength(str, 4))
      str = 'Nome tem que ter mais de 4 caracteres';

    return str;
  }

  void _save() async {
    UserResponse userResponse = await _controller.doGeneral();
    print(userResponse.toString());

    if (userResponse == null) _populateUser();

    setState(() {
      _user = userResponse;
      _controller.id(_user?.id);
    });
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
                                builder: (context) => HomePage()));
                  },
                  child: Text('Fechar'))
            ],
          );
        });
  }

  void _populateUser() async {
    var userResponse = await _controller.getUserById();
    setState(() {
      _user = userResponse;
      _fullNameController.text = _user?.name == null ? '' : _user?.name;
      _phoneController.text = _user?.phone == null ? '' : _user?.phone;
      _emailController.text = _user?.email == null ? '' : _user?.email;
      _cpfController.text = _user?.cpf == null ? '' : _user?.cpf;
    });
    _controller.id(_user?.id);
    _controller.email(_user?.email);
    _controller.address(_user?.address);
  }
}
