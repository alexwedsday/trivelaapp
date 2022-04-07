import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivelaapp/controller/settings_information_controller.dart';
import 'package:trivelaapp/response/user_response.dart';

class SettingsInformationForm extends StatefulWidget {
  @override
  _SettingsInformationState createState() => _SettingsInformationState();
}

class _SettingsInformationState extends State<SettingsInformationForm> {
  bool _isLoading = false;
  SettingsInformationController _controller;
  var _addressController = TextEditingController();
  var _bairroController = TextEditingController();
  var _numeroController = TextEditingController();
  var _cidadeController = TextEditingController();
  var _estadoController = TextEditingController();
  var _paisController = TextEditingController();
  var _cepController = TextEditingController();
  var _dataController = TextEditingController();
  var _bioController = TextEditingController();
  UserResponse _user = UserResponse.empty();
  String _selectedValue;
  List<String> _country = ['Brasil', 'EUA'];
  @override
  void initState() {
    _controller = SettingsInformationController();
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
                                    controller: _addressController,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Endereço',
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
                                        _controller.address(value),
                                  ),
                                  SizedBox(height: 32),
                                  TextFormField(
                                    controller: _bairroController,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Bairro',
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
                                        _controller.bairro(value),
                                  ),
                                  SizedBox(height: 32),
                                  TextFormField(
                                    controller: _numeroController,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Número',
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
                                        _controller.numero(value),
                                  ),
                                  SizedBox(height: 32),
                                  TextFormField(
                                    controller: _cidadeController,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Cidade',
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
                                        _controller.cidade(value),
                                  ),
                                  SizedBox(height: 32),
                                  TextFormField(
                                    controller: _estadoController,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Estado',
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
                                        _controller.estado(value),
                                  ),
                                  SizedBox(height: 32),
                                  TextFormField(
                                    controller: _paisController,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'País',
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
                                    onSaved: (value) => _controller.pais(value),
                                  ),
                                  SizedBox(height: 32),
                                  TextFormField(
                                    controller: _cepController,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'CEP',
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
                                    onSaved: (value) => _controller.cep(value),
                                  ),
                                  SizedBox(height: 32),
                                  TextFormField(
                                    controller: _bioController,
                                    keyboardType: TextInputType.multiline,
                                    style: TextStyle(color: Colors.black),
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Bio',
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
                                    onSaved: (value) => _controller.bio(value),
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

  void _save() async {
    UserResponse userResponse = await _controller.doInformation();
    print(userResponse.toString());

    if (userResponse == null) await _populateUser();

    setState(() {
      _user = userResponse;
      _controller.id(_user?.id);
      _controller.name(_user?.name);
    });
  }

  void _populateUser() async {
    var userResponse = await _controller.getUserById();
    setState(() {
      _user = userResponse;
      _addressController.text = _user?.address == null ? '' : _user?.address;
      _bairroController.text = _user?.bairro == null ? '' : _user?.bairro;
      _numeroController.text = _user?.numero == null ? '' : _user?.numero;
      _cidadeController.text = _user?.cidade == null ? '' : _user?.cidade;
      _estadoController.text = _user?.estado == null ? '' : _user?.estado;
      _paisController.text = _user?.country == null ? '' : _user?.country;
      _cepController.text = _user?.cep == null ? '' : _user?.cep;
      _dataController.text = _user?.birthday == null ? '' : _user?.birthday;
      _bioController.text = _user?.bio == null ? '' : _user?.bio;
    });
    _controller.id(_user?.id);
    _controller.cpf(_user?.cpf);
    _controller.name(_user?.name);
    _controller.email(_user?.email);
    _controller.address(_user?.address);
    _controller.bairro(_user?.bairro);
    _controller.numero(_user?.numero);
    _controller.cidade(_user?.cidade);
    _controller.estado(_user?.estado);
    _controller.pais(_user?.country);
    _controller.phone(_user?.phone);
    _controller.bio(_user?.bio);
  }
}
