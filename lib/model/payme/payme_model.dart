import 'dart:convert';

import 'package:trivelaapp/model/payme/payme_transaction.dart';

class PaymeModel {
  String transacao;
  String valor;
  String status;
  String site;
  PaymeTransaction retorno;
  String tipo;
  int usersId;
  String destino;
  String updatedAt;
  String createdAt;
  int id;
  String referenceid;

  PaymeModel(
      {this.transacao,
      this.valor,
      this.status,
      this.site,
      this.retorno,
      this.tipo,
      this.usersId,
      this.destino,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.referenceid});

  PaymeModel.fromJson(Map<String, dynamic> json) {
    transacao = json['transacao'];
    valor = json['valor'];
    status = json['status'];
    site = json['site'];
    if (json['retorno'] != null) {
      retorno = PaymeTransaction.fromJson(jsonDecode(json['retorno']));
    } else {
      retorno = null;
    }

    tipo = json['tipo'];
    usersId = json['users_id'];
    destino = json['destino'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    referenceid = json['referenceid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transacao'] = this.transacao;
    data['valor'] = this.valor;
    data['status'] = this.status;
    data['site'] = this.site;
    data['retorno'] = this.retorno;
    data['tipo'] = this.tipo;
    data['users_id'] = this.usersId;
    data['destino'] = this.destino;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['referenceid'] = this.referenceid;
    return data;
  }
}
