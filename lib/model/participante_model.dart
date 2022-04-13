import 'package:trivelaapp/model/profile_model.dart';

class ParticipanteModel {
  int id;
  String valor;
  int profilesId;
  int campeonatosId;
  String createdAt;
  String updatedAt;
  dynamic pontosrodada;
  ProfileModel profile;

  ParticipanteModel(
      {this.id,
      this.valor,
      this.profilesId,
      this.campeonatosId,
      this.createdAt,
      this.updatedAt,
      this.pontosrodada,
      this.profile});

  ParticipanteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    valor = json['valor'];
    profilesId = json['profiles_id'];
    campeonatosId = json['campeonatos_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pontosrodada = json['pontosrodada'];
    profile = json['profile'] != null
        ? new ProfileModel.fromJson(json['profile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['valor'] = this.valor;
    data['profiles_id'] = this.profilesId;
    data['campeonatos_id'] = this.campeonatosId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    return data;
  }
}
