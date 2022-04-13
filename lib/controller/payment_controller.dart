import 'package:flutter/cupertino.dart';
import 'package:trivelaapp/model/transaction_model.dart';
import 'package:trivelaapp/repository/payment_repository.dart';
import 'package:trivelaapp/response/payme/pay_payment_response.dart';
import 'package:trivelaapp/response/picpay/pic_payment_response.dart';

class PaymentController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PaymentRepository _repository = PaymentRepository();
  TransactionModel transactionModel = TransactionModel();

  Future<PicPaymentResponse> picpay() async {
    PicPaymentResponse paymentResponse;

    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      transactionModel.site = 'picpay';
      paymentResponse = await _repository.picpay(transactionModel);
    }

    return paymentResponse;
  }

  Future<PayPaymentResponse> payme() async {
    PayPaymentResponse paymentResponse;

    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      transactionModel.site = 'paymee';
      paymentResponse = await _repository.payme(transactionModel);
    }
    return paymentResponse;
  }

  Future<PicPaymentResponse> checkPic(String transactionId) async {
    return await _repository.checkPic(transactionId);
  }

  Future<PayPaymentResponse> checkPay(String transactionId) async {
    return await _repository.checkPay(transactionId);
  }

  transactionValor(String value) => transactionModel.valor = value;
  transactionSite(String value) => transactionModel.site = value;
}
