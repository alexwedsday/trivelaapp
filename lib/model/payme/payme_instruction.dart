import 'package:trivelaapp/model/payme/payme_qrcode.dart';

class PaymeInstruction {
  PaymeQrcode qrCode;

  PaymeInstruction({this.qrCode});

  PaymeInstruction.fromJson(Map<String, dynamic> json) {
    if (json['qrCode'] != null) {
      qrCode = PaymeQrcode.fromJson(json['qrCode']);
    } else {
      qrCode = null;
    }
  }
}
