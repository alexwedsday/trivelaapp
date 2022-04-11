import 'package:flutter/cupertino.dart';
import 'package:trivelaapp/model/transaction_model.dart';
import 'package:trivelaapp/repository/payment_repository.dart';
import 'package:trivelaapp/response/payment_response.dart';

class PaymentController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PaymentRepository _repository = PaymentRepository();
  TransactionModel transactionModel = TransactionModel();

  Future<PaymentResponse> picpay() async {
    PaymentResponse paymentResponse;

    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      transactionModel.site = 'picpay';
      paymentResponse = await _repository.picpay(transactionModel);
    }

    return paymentResponse;
  }

  Future<PaymentResponse> payme() async {
    PaymentResponse paymentResponse;

    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      transactionModel.site = 'payme';
      paymentResponse = await _repository.picpay(transactionModel);
    }
    return paymentResponse;
  }

  Future<PaymentResponse> check(String transactionId) async {
    return await _repository.check(transactionId);
  }

  transactionValor(String value) => transactionModel.valor = value;
  transactionSite(String value) => transactionModel.site = value;
}
