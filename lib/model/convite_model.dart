class ConviteModel {
  int id;
  String processado;
  int users_id;
  int profiles_id;
  int usuario_convite;
  int campeonato_id;

  ConviteModel({
    this.id,
    this.processado,
    this.users_id,
    this.profiles_id,
    this.usuario_convite,
    this.campeonato_id,
  });

  ConviteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    processado = json['processado'];
    users_id = json['users_id'];
    profiles_id = json['profiles_id'];
    usuario_convite = json['usuario_convite'];
    campeonato_id = json['campeonato_id'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['id'] = id;
    json['processado'] = processado;
    json['users_id'] = users_id;
    json['profiles_id'] = profiles_id;
  }
}
