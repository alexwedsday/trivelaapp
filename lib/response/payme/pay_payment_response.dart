import 'package:trivelaapp/model/payme/payme_model.dart';

class PayPaymentResponse {
  bool error;
  String message;
  PaymeModel item;

  PayPaymentResponse({this.error, this.message, this.item});

  PayPaymentResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    item = json['item'] != null ? PaymeModel.fromJson(json['item']) : null;
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
