import 'package:trivelaapp/model/payme/payme_instruction.dart';

class PaymeResponse {
  PaymeInstruction instructions;

  PaymeResponse({this.instructions});

  PaymeResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    if (json['instructions'] != null) {
      instructions = PaymeInstruction.fromJson(json['instructions']);
    } else {
      instructions = null;
    }
  }
}
