import 'package:trivelaapp/model/profile_model.dart';

class ProfileResponse {
  bool error;
  String message;
  List<ProfileModel> lista;

  ProfileResponse({this.error, this.message, this.lista});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['lista'] != null) {
      lista = <ProfileModel>[];
      json['lista'].forEach((p) {
        lista.add(new ProfileModel.fromJson(p));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['error'] = this.error;
    if (this.lista != null) {
      json['lista'] = this.lista.map((p) => p.toJson()).toList();
    }
    json['message'] = this.message;
    return json;
  }
}
