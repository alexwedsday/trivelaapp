import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:trivelaapp/controller/payment_controller.dart';
import 'package:trivelaapp/model/picpay/picpay_model.dart';
import 'package:trivelaapp/page/home_page.dart';
import 'package:trivelaapp/response/picpay/pic_payment_response.dart';
import 'package:trivelaapp/shared/trivela_assets.dart';

class PicQrcodePage extends StatefulWidget {
  PicpayModel picpayModel;

  PicQrcodePage({Key key, this.picpayModel}) : super(key: key);

  @override
  _PicQrcodePageState createState() => _PicQrcodePageState(picpayModel);
}

class _PicQrcodePageState extends State<PicQrcodePage> {
  final PicpayModel valor;
  PaymentController _controller = PaymentController();
  String temporizador = "";
  Timer _timer;
  _PicQrcodePageState(this.valor);

  @override
  void initState() {
    super.initState();
    int tentativas = 0;

    this._timer = Timer.periodic(Duration(seconds: 30), (timer) {
      tentativas++;
      setState(() {
        temporizador = "Consultando $tentativas";
      });
      check();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: <Widget>[
              Center(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image(
                        width: 150,
                        image: AssetImage(TrivelaAssets.picpay),
                      ),
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(temporizador,
                    style: TextStyle(fontSize: 28, color: Colors.black)),
              )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: QrImage(
                data: valor?.retorno?.qrcode?.content,
                version: QrVersions.auto,
                size: 300,
                errorCorrectionLevel: QrErrorCorrectLevel.H,
                foregroundColor: Colors.black,
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: TextButton.icon(
                  icon: Icon(Icons.copy, color: Colors.black),
                  label: Text(
                    valor.retorno.qrcode.content.substring(0, 30),
                    softWrap: true,
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => {_copy()},
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Uint8List decodeBase64(String source) {
    String str = source;
    if (source.isNotEmpty) str = removeHeader(source);

    Base64Decoder base64 = Base64Decoder();
    final Uint8List bytes = base64Decode(str);
    return bytes;
  }

  String removeHeader(String source) {
    return source.split(',')[1];
  }

  Future<PicPaymentResponse> check() async {
    PicPaymentResponse response = await _controller.checkPic(valor.transacao);
    if (response != null && response.error) {
      setState(() {
        temporizador = "Aguardando ...";
      });
    } else {
      _showDialog('', 'Credito Adicionado');
    }
  }

  void _copy() async {
    await Clipboard.setData(
        ClipboardData(text: valor?.retorno?.qrcode?.content));
  }

  _showDialog(String title, String message) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: const Text('Fechar'))
            ],
          );
        });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
