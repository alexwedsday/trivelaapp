import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:trivelaapp/controller/campeonato_controller.dart';
import 'package:trivelaapp/model/campeonato_model.dart';
import 'package:trivelaapp/response/campeonato_response.dart';

class ShopList extends StatefulWidget {
  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  CampeonatoController _controller;
  List<CampeonatoModel> campeonatos = [];
  @override
  void initState() {
    _controller = CampeonatoController();
    _populate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            child: Scaffold(
              body: Container(
                  child: ListView.builder(
                      padding: EdgeInsets.all(32.0),
                      itemCount: campeonatos.length,
                      itemBuilder: (context, index) {
                        final CampeonatoModel campeonato =
                            index != null ? campeonatos[index] : {};

                        return Card(
                            margin: EdgeInsets.all(16),
                            elevation: 4,
                            child: Column(children: <Widget>[
                              campeonato == null
                                  ? ListTile(
                                      leading: Icon(Icons.refresh_outlined),
                                      title: Text('Clique para recarregar'),
                                      onTap: () => {_populate()},
                                    )
                                  : campeonato != null
                                      ? Image.memory(
                                          decodeBase64(campeonato?.imagem),
                                          width: 150,
                                          height: 150,
                                        )
                                      : Icon(Icons.add_photo_alternate),
                              ListTile(
                                title: Text(campeonato?.nome),
                              ),
                              ListTile(
                                title: Text('CUSTO PARA PARTICIPAR'),
                                subtitle: Text('R\$ ${campeonato?.valor}',
                                    style: TextStyle(
                                      background: Paint()..color = Colors.grey,
                                      color: Colors.greenAccent,
                                    )),
                              ),
                              ListTile(
                                title: Text('COM CAPITAO'),
                                subtitle: Text('${campeonato?.capitao}',
                                    style: TextStyle(
                                      background: Paint()..color = Colors.grey,
                                      color: Colors.red,
                                    )),
                              ),
                              ListTile(
                                title: Text('ARRECADAÇÕES'),
                                subtitle: Text(
                                    ' Pagantes \n ${campeonato?.participantes?.length}',
                                    style: TextStyle(
                                      background: Paint()..color = Colors.grey,
                                      color: Colors.black,
                                    )),
                              ),
                              ListTile(
                                subtitle: Text('Premiação Parcial',
                                    style: TextStyle(
                                      background: Paint()..color = Colors.grey,
                                      color: Colors.black,
                                    )),
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () => {},
                                      child: Text('Participar'))
                                ],
                              )
                            ]));
                      })),
            ),
          ),
        ),
      ],
    );
  }

  void _populate() async {
    CampeonatoResponse response = await _controller.getCampeonatos();
    if (response != null && !response.error) {
      setState(() {
        campeonatos = response.lista;
      });
    }
  }

  Uint8List decodeBase64(String source) {
    Base64Decoder base64 = Base64Decoder();
    final Uint8List bytes = base64Decode(source);
    return bytes;
  }
}
