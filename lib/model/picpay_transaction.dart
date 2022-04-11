import 'package:trivelaapp/model/qrcode_model.dart';

class PicpayTransaction {
  String referenceId;
  String paymentUrl;
  QrcodeModel qrcode;

  PicpayTransaction();

  PicpayTransaction.fromJson(Map<String, dynamic> json) {
    referenceId = json['referenceId'];
    paymentUrl = json['paymentUrl'];
    if (json['qrcode'] != null) {
      qrcode = QrcodeModel.fromJson(json['qrcode']);
    } else {
      qrcode = null;
    }
  }
}
