import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivelaapp/model/transaction_model.dart';
import 'package:trivelaapp/response/payment_response.dart';

class PaymentRepository {
  Map<String, String> _headers;

  Future<PaymentResponse> picpay(TransactionModel transactionModel) async {
    PaymentResponse paymentReponse;

    final String URL = 'https://app.trivelaligas.com/api/auth/transacao/add';
    final token = await getToken();
    this._headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };

    try {
      final String body = jsonEncode(transactionModel.toJson());
      http.Response response =
          await http.post(URL, headers: _headers, body: body);
      print('body: ${response.body} \n status: ${response.statusCode}');

      if (response.statusCode == 200) {
        paymentReponse = PaymentResponse.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }

    return paymentReponse;
  }

  Future<PaymentResponse> payme(TransactionModel transactionModel) async {
    PaymentResponse paymentReponse;
    final String URL = 'https://app.trivelaligas.com/api/auth/transacao/add';
    final token = await getToken();
    this._headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    try {
      final String body = jsonEncode(transactionModel.toJson());
      http.Response response =
          await http.post(URL, headers: _headers, body: body);
      print('body: ${response.body} \n status: ${response.statusCode}');

      if (response.statusCode == 200) {
        paymentReponse = PaymentResponse.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }

    return paymentReponse;
  }

  Future<PaymentResponse> check(String transactionId) async {
    PaymentResponse paymentReponse;
    final String URL =
        'https://app.trivelaligas.com/api/auth/picpay/status?transacao=' +
            transactionId;
    final token = await getToken();
    this._headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    try {
      http.Response response = await http.post(URL, headers: _headers);
      print('body: ${response.body} \n status: ${response.statusCode}');

      if (response.statusCode == 200) {
        paymentReponse = PaymentResponse.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }

    return paymentReponse;
  }

  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    return token;
  }
}
