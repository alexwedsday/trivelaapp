import 'package:trivelaapp/model/picpay_model.dart';

class PaymentResponse {
  bool error;
  String message;
  PicpayModel item;

  PaymentResponse({this.error, this.message, this.item});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    item = json['item'] != null ? PicpayModel.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.item != null) {
      data['item'] = this.item.toJson();
    }
    return data;
  }
}
