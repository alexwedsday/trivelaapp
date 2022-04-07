import 'package:trivelaapp/model/atleta_model.dart';
import 'package:trivelaapp/model/time_model.dart';

class TimeResponse {
  List<AtletaModel> atletas;
  TimeModel time;

  TimeResponse(this.time);

  factory TimeResponse.fromJson(Map<String, dynamic> json) {
    final TimeModel time = TimeModel.fromJson(json['time']);
    return TimeResponse(time);
  }
}
