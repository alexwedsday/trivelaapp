import 'dart:convert';

import 'package:trivelaapp/model/payme/payme_response.dart';

class PaymeRetorno {
  PaymeResponse response;

  PaymeRetorno({this.response});

  PaymeRetorno.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = PaymeResponse.fromJson(jsonDecode(json['response']));
    } else {
      response = null;
    }
  }
}
