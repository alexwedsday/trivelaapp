import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trivelaapp/controller/payment_controller.dart';
import 'package:trivelaapp/page/pay_qrcode_page.dart';
import 'package:trivelaapp/page/pic_qrcode_page.dart';
import 'package:trivelaapp/response/payme/pay_payment_response.dart';
import 'package:trivelaapp/response/picpay/pic_payment_response.dart';
import 'package:trivelaapp/shared/moeda_formatter.dart';
import 'package:trivelaapp/shared/trivela_assets.dart';
import 'package:validators/validators.dart' as validator;

class DepositPage extends StatefulWidget {
  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  TextEditingController _textEditingController = TextEditingController();
  PaymentController _controller;
  bool _isLoadingPic = false;
  bool _isLoadingPix = false;
  bool _isDisablePic = false;
  bool _isDisablePix = false;

  @override
  void initState() {
    super.initState();
    _controller = PaymentController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            child: Scaffold(
              backgroundColor: Colors.white70,
              body: Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    Stack(
                      children: [
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
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Positioned(
                            child: Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            child: Form(
                              key: _controller.formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.right,
                                    controller: _textEditingController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      new MoedaFormatter()
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 0.0),
                                      prefixText: 'Valor:',
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.0, horizontal: 5.0),
                                        child: Icon(Icons.attach_money),
                                      ),
                                      suffixIconConstraints:
                                          BoxConstraints.tight(Size(25, 20)),
                                      labelText: 'Valor',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
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
                                        _controller.transactionValor(value),
                                  ),
                                  const SizedBox(height: 32),
                                  _isLoadingPic
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
                                              '\$ Pagar com Picpay',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0),
                                            ),
                                            onPressed: () => {
                                              _isDisablePic
                                                  ? null
                                                  : _transactionPic()
                                            },
                                          ),
                                        ),
                                  SizedBox(height: 32),
                                  _isLoadingPix
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
                                              '\$ Pagar com Pix',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0),
                                            ),
                                            onPressed: () => {
                                              _isDisablePix
                                                  ? null
                                                  : _transactionPix()
                                            },
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _strValid(String value) {
    String str = '';

    if (validator.isNull(value))
      str = 'É necessário digitar um valor';
    else if (validator.isLength(str, 4)) str = 'Entre com um valor válido';

    return str.isEmpty ? null : str;
  }

  void _transactionPic() async {
    setState(() {
      _isDisablePix = true;
      _isLoadingPic = true;
    });

    PicPaymentResponse response = await _controller.picpay();

    if (response != null && response.error) {
      _showDialog('Atenção', response.message);
    } else if (response != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PicQrcodePage(
                    picpayModel: response?.item,
                  )));
    }
    setState(() {
      _isLoadingPic = false;
      _isDisablePix = false;
    });
  }

  void _transactionPix() async {
    setState(() {
      _isDisablePic = true;
      _isLoadingPix = true;
    });
    PayPaymentResponse response = await _controller.payme();

    if (response != null && response.error) {
      _showDialog('Ops!', response.message);
    } else if (response != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PayQrcodePage(
                    paymeModel: response?.item,
                  )));
    }

    setState(() {
      _isLoadingPix = false;
      _isDisablePic = false;
    });
  }

  _showDialog(String title, String message) {
    setState(() {
      _isLoadingPix = false;
      _isLoadingPic = false;
      _isDisablePic = false;
      _isDisablePix = false;
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
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: const Text('Fechar'))
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
