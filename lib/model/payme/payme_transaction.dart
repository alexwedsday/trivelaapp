import 'package:trivelaapp/model/payme/payme_response.dart';

class PaymeTransaction {
  int status;
  String message;
  PaymeResponse response;

  PaymeTransaction({this.status, this.message, this.response});

  PaymeTransaction.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['response'] != null) {
      response = PaymeResponse.fromJson(json['response']);
    } else {
      response = null;
    }
  }
}
