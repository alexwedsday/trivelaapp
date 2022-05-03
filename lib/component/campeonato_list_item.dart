import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivelaapp/model/campeonato_model.dart';

class CampeonatoListItem extends StatefulWidget {
  final CampeonatoModel campeonato;
  const CampeonatoListItem({
    @required this.campeonato,
    Key key,
  }) : super(key: key);

  @override
  _CampeonatoListItemState createState() => _CampeonatoListItemState();
}

class _CampeonatoListItemState extends State<CampeonatoListItem> {
  CampeonatoModel campeonato;

  @override
  void initState() {
    campeonato = widget.campeonato;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(16),
        elevation: 4,
        child: Column(children: <Widget>[
          campeonato != null
              ? Container(
                  child: Image.memory(
                    decodeBase64(campeonato?.imagem),
                    width: 150,
                    height: 150,
                  ),
                  decoration: BoxDecoration(color: Colors.white),
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
            subtitle: Text(' Pagantes \n ${campeonato?.participantes?.length}',
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
                  child: const Text(
                    'Participar',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  onPressed: () => {}),
            ],
          )
        ]));
  }

  Uint8List decodeBase64(String source) {
    Base64Decoder base64 = Base64Decoder();
    final Uint8List bytes = base64Decode(source);
    return bytes;
  }
}
