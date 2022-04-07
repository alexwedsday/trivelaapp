import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivelaapp/component/globo_account_view.dart';
import 'package:trivelaapp/model/profile_model.dart';
import 'package:trivelaapp/model/time_model.dart';
import 'package:trivelaapp/repository/profile_repository.dart';
import 'package:trivelaapp/repository/time_repository.dart';
import 'package:trivelaapp/response/profile_response.dart';
import 'package:trivelaapp/response/user_response.dart';

class SettingsLinkedAccount extends StatefulWidget {
  @override
  _SettingsLinkedAccountState createState() => _SettingsLinkedAccountState();
}

class _SettingsLinkedAccountState extends State<SettingsLinkedAccount> {
  List<TimeModel> times = [];

  @override
  void initState() {
    _populateFromTrivela();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            child: Scaffold(
              floatingActionButton: IconButton(
                icon: Icon(Icons.account_circle),
                iconSize: 50,
                color: Color.fromRGBO(242, 210, 110, 1.0),
                onPressed: () => {
                  {_goToGloboLogin(context)}
                },
              ),
              body: Container(
                  child: ListView.builder(
                      itemCount: times.length,
                      itemBuilder: (context, index) {
                        final TimeModel time =
                            index != null ? times[index] : {};

                        return Card(
                          child: Column(children: <Widget>[
                            time == null
                                ? ListTile()
                                : ListTile(
                                    leading: time != null
                                        ? Image.network(time.url_escudo_png)
                                        : Icon(Icons.account_circle),
                                    title: Text(time?.nome),
                                    subtitle: Text(time?.nome_cartola),
                                  )
                          ]),
                        );
                      })),
            ),
          ),
        ),
      ],
    );
  }

  _goToGloboLogin(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GloboAccountView()));
  }

  void _populateAccount() async {
    var timeResponse;

    SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      final String XGlbToken = preferences.getString('X-GLB-Token');
      if (XGlbToken != null && XGlbToken.isNotEmpty) {
        final TimeRepository repository = TimeRepository();
        final ProfileRepository profileRepository = ProfileRepository();
        timeResponse = await repository.doGet(XGlbToken);

        if (timeResponse != null && timeResponse.time != null) {
          final TimeModel timeModel = timeResponse.time;
          final UserResponse userResponse = UserResponse.fromJson(
              jsonDecode(preferences.getString('userData')));
          final String token = preferences.getString('token');
          if (userResponse != null && userResponse.id != null) {
            ProfileModel profileModel = ProfileModel();
            profileModel.usersId = userResponse.id;
            profileModel.token = XGlbToken;
            profileModel.nomeusuario = timeModel.nome;
            profileModel.nomercartola = timeModel.nome_cartola;
            profileModel.escudopng = timeModel.url_escudo_png;
            profileModel.escudosvg = timeModel.url_escudo_svg;
            profileModel.glbid = timeModel.globo_id;
            profileModel.fotoperfil = timeModel.foto_perfil;
            profileModel.slug = timeModel.slug;

            final ProfileResponse profileResponse =
                await profileRepository.doPostBody(token, profileModel);
            List<ProfileModel> lista = profileResponse.lista;
          }
        }
      }
    } catch (e) {}
  }

  void _populateFromTrivela() async {
    _populateAccount();
    var profileModel;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jsonUserdata = preferences.get('userData');
    String token = preferences.get('token');
    UserResponse user = UserResponse.fromJson(jsonDecode(jsonUserdata));
    if (user == null || user.id == null) {
    } else {
      List<ProfileModel> lista = <ProfileModel>[];
      final ProfileRepository repository = ProfileRepository();
      final ProfileResponse profileResponse = await repository.doPost(token);
      if (profileResponse != null &&
          !profileResponse.error &&
          profileResponse.lista != null) {
        lista = profileResponse.lista;
        setState(() {
          this.times = convertToTimeModel(lista);
        });
      }
    }
  }

  List<TimeModel> convertToTimeModel(List<ProfileModel> lista) {
    List<TimeModel> times = <TimeModel>[];
    TimeModel timeModel = TimeModel.empty();

    lista.forEach((l) {
      timeModel.nome_cartola = l.nomercartola;
      timeModel.url_escudo_png = l.escudopng;
      timeModel.nome = l.nomeusuario;
      times.add(timeModel);
      timeModel = TimeModel.empty();
    });

    return times;
  }
}
