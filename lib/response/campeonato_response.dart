import 'package:trivelaapp/model/campeonato_model.dart';

class CampeonatoResponse {
  bool error;
  List<CampeonatoModel> lista;
  String message;

  CampeonatoResponse({this.error, this.lista, this.message});
  CampeonatoResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['lista'] != null) {
      lista = <CampeonatoModel>[];
      json['lista'].forEach((l) {
        lista.add(CampeonatoModel.fromJson(l));
      });
    } else {
      lista = <CampeonatoModel>[];
    }
    message = json['message'];
  }
}
