import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivelaapp/component/change_password_form.dart';
import 'package:trivelaapp/component/settings_general_form.dart';
import 'package:trivelaapp/component/settings_information_form.dart';
import 'package:trivelaapp/component/settings_linked_account.dart';
import 'package:trivelaapp/shared/trivela_assets.dart';

import 'home_page.dart';

class SettingsPage extends StatefulWidget {
  final int index;

  const SettingsPage({Key key, this.index}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int selected = 0;

  @override
  void initState() {
    super.initState();
    selected = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Configurações',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
            backgroundColor: Color.fromRGBO(242, 210, 110, 1.0),
          ),
          drawer: Drawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 100,
                  child: DrawerHeader(
                    child: Image(
                      width: 50,
                      image: AssetImage(TrivelaAssets.logoPng),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text('CONFIGURAÇÕES'),
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Geral'),
                        onTap: () => {
                          _selectComponent(0, context),
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SettingsPage(
                                    index: 0,
                                  )))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.lock),
                        title: Text('Trocar Senha'),
                        onTap: () => {
                          _selectComponent(1, context),
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SettingsPage(
                                    index: 1,
                                  )))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text('Informações'),
                        onTap: () => {
                          _selectComponent(2, context),
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SettingsPage(
                                    index: 2,
                                  )))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.supervised_user_circle),
                        title: Text('Perfil Globo'),
                        onTap: () => {
                          _selectComponent(3, context),
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SettingsPage(
                                    index: 3,
                                  )))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications),
                        title: Text('Notificações'),
                        onTap: () => {_selectComponent(4, context)},
                      ),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Ir para Inicio'),
                        onTap: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()))
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          body: _selectComponent(selected, context),
        ));
  }

  StatefulWidget _selectComponent(int index, BuildContext context) {
    setState(() {
      selected = index;
    });
    switch (index) {
      case 0:
        return new SettingsGeneralForm();
        break;

      case 1:
        return new ChangePasswordForm();
        break;
      case 2:
        return new SettingsInformationForm();
        break;

      case 3:
        return SettingsLinkedAccount();
        break;
    }
    return new SettingsGeneralForm();
  }
}
