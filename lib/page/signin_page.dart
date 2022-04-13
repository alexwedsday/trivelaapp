import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivelaapp/controller/signin_controller.dart';
import 'package:trivelaapp/page/login_page.dart';
import 'package:trivelaapp/repository/signin_repository.dart';
import 'package:trivelaapp/response/signin_response.dart';
import 'package:trivelaapp/shared/trivela_assets.dart';
import 'package:validators/validators.dart' as validator;

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  SigninController controller;
  bool _isVisible = false;
  bool _isAgree = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    controller = SigninController(SigninRepository());
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
                              key: controller.formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Nome de Usuário',
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
                                    validator: (value) => _strValid(value),
                                    onSaved: (value) =>
                                        controller.username(value),
                                  ),
                                  const SizedBox(height: 32),
                                  TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      style:
                                          const TextStyle(color: Colors.black),
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
                                      validator: (value) => _isEmail(value),
                                      onSaved: (value) =>
                                          controller.userEmail(value)),
                                  const SizedBox(height: 32),
                                  TextFormField(
                                      obscureText: _isVisible,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        labelText: 'Senha',
                                        labelStyle: const TextStyle(
                                            color: Colors.black),
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
                                      onSaved: (value) =>
                                          controller.userPassword(value)),
                                  Container(
                                      child: Row(
                                    children: <Widget>[
                                      Checkbox(
                                        activeColor: const Color.fromRGBO(
                                            242, 210, 110, 1.0),
                                        value: _isAgree,
                                        onChanged: (value) =>
                                            _agreeTerms(value),
                                      ),
                                      const Text(
                                        'Eu concordo com os termos e regras',
                                        style: const TextStyle(fontSize: 16),
                                      )
                                    ],
                                  )),
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
                                              'Cadastrar',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0),
                                            ),
                                            onPressed: () =>
                                                _doRegister(context),
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
                                                  text: 'Já possui conta?'),
                                              TextSpan(
                                                  text:
                                                      ' Clique aqui para logar',
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () => {
                                                              _goToLogin(
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

  void _agreeTerms(bool value) {
    setState(() {
      _isAgree = value;
    });
  }

  void _goToLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  String _isEmail(String value) {
    String str = '';

    if (!validator.isEmail(value)) str = 'E-mail invalido';

    return str.isEmpty ? null : str;
  }

  String _isPwd(String value) {
    String str = '';

    if (validator.isNull(value))
      str = 'É necessário digitar uma senha';
    else if (!validator.isLength(value, 6))
      str = 'Senha mínimo de 6 caracteres';

    return str.isEmpty ? null : str;
  }

  String _strValid(String value) {
    String str = '';

    if (validator.isNull(value))
      str = 'É necessário digitar um nome';
    else if (!validator.isLength(value, 4))
      str = 'Nome tem que ter mais de 4 caracteres';

    return str.isEmpty ? null : str;
  }

  _doRegister(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String message = 'Não foi possível fazer o cadastro';
    String title = 'Ops!';
    setState(() {
      _isLoading = true;
    });

    SigninResponse response = await controller.doRegister();
    print('page $response');

    if (!_isAgree) {
      message = 'Precisa concordo com os termos';
    } else if (response != null) {
      preferences.setString('token', response.accessToken);
      print('teste message ${response.message}');
      message = response.message;
      title = 'Bem Vindo!';
    }

    _showDialog(title, message);
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
}
