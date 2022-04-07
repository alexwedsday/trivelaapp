import 'package:trivelaapp/model/user_object.dart';

class UserSettingsModel {
  UserObject usuario;

  UserSettingsModel({this.usuario});

  UserSettingsModel.fromJson(Map<String, dynamic> json) {
    usuario =
        json['usuario'] != null ? UserObject.fromJson(json[usuario]) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.usuario != null) {
      data['usuario'] = this.usuario.toJson();
    }
    return data;
  }
}
