import 'package:trivelaapp/model/atleta_model.dart';

class ProfileModel {
  int id;
  String escudopng;
  String escudosvg;
  String fotoperfil;
  String cartoletas;
  String mercado;
  String ultimapontuacao;
  String idtime;
  String nomeusuario;
  String nomercartola;
  String slug;
  String facebookId;
  String status;
  int usersId;
  String createdAt;
  String updatedAt;
  String glbid;
  String esquemaId;
  String pontosCampeonato;
  String capitaoId;
  String patrimonio;
  String valorTime;
  String variacaoPatrimonio;
  String variacaoPontos;
  AtletaModel capitao;
  String token;

  ProfileModel(
      {this.id,
      this.escudopng,
      this.escudosvg,
      this.fotoperfil,
      this.cartoletas,
      this.mercado,
      this.ultimapontuacao,
      this.idtime,
      this.nomeusuario,
      this.nomercartola,
      this.slug,
      this.facebookId,
      this.status,
      this.usersId,
      this.createdAt,
      this.updatedAt,
      this.glbid,
      this.esquemaId,
      this.pontosCampeonato,
      this.capitaoId,
      this.patrimonio,
      this.valorTime,
      this.variacaoPatrimonio,
      this.variacaoPontos,
      this.capitao,
      this.token});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    escudopng = json['escudopng'];
    escudosvg = json['escudosvg'];
    fotoperfil = json['fotoperfil'];
    cartoletas = json['cartoletas'];
    mercado = json['mercado'];
    ultimapontuacao = json['ultimapontuacao'];
    idtime = json['idtime'];
    nomeusuario = json['nomeusuario'];
    nomercartola = json['nomercartola'];
    slug = json['slug'];
    facebookId = json['facebook_id'];
    status = json['status'];
    usersId = json['users_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    glbid = json['glbid'];
    esquemaId = json['esquema_id'];
    pontosCampeonato = json['pontos_campeonato'];
    capitaoId = json['capitao_id'];
    patrimonio = json['patrimonio'];
    valorTime = json['valor_time'];
    variacaoPatrimonio = json['variacao_patrimonio'];
    variacaoPontos = json['variacao_pontos'];
    if (json['capitao'] == null) {
      capitao = AtletaModel();
    } else {
      capitao = AtletaModel.fromJson(json['capitao']);
    }

    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['escudopng'] = this.escudopng;
    data['escudosvg'] = this.escudosvg;
    data['fotoperfil'] = this.fotoperfil;
    data['cartoletas'] = this.cartoletas;
    data['mercado'] = this.mercado;
    data['ultimapontuacao'] = this.ultimapontuacao;
    data['idtime'] = this.idtime;
    data['nomeusuario'] = this.nomeusuario;
    data['nomercartola'] = this.nomercartola;
    data['slug'] = this.slug;
    data['facebook_id'] = this.facebookId;
    data['status'] = this.status;
    data['users_id'] = this.usersId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['glbid'] = this.glbid;
    data['esquema_id'] = this.esquemaId;
    data['pontos_campeonato'] = this.pontosCampeonato;
    data['capitao_id'] = this.capitaoId;
    data['patrimonio'] = this.patrimonio;
    data['valor_time'] = this.valorTime;
    data['variacao_patrimonio'] = this.variacaoPatrimonio;
    data['variacao_pontos'] = this.variacaoPontos;
    data['capitao'] = this.capitao;
    data['token'] = this.token;
    return data;
  }
}
