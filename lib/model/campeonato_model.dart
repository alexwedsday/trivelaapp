import 'package:trivelaapp/model/convite_model.dart';
import 'package:trivelaapp/model/participante_model.dart';

class CampeonatoModel {
  int id;
  String nome;
  String imagem;
  int ntimes;
  String datainicio;
  String valor;
  String capitao;
  int tiposcampeonatosId;
  int categoriacampeonatoId;
  String createdAt;
  String updatedAt;
  String minimo;
  String privado;
  String status;
  dynamic situacao;
  String encerramentoinsc;
  String regras;
  String encerrado;
  int rodadasId;
  String ngrupos;
  String faseatual;
  String rodadaini;
  String rodadafim;
  List<ConviteModel> convites;
  List<ParticipanteModel> participantes;
  String slug;

  CampeonatoModel(
      {this.id,
      this.nome,
      this.imagem,
      this.ntimes,
      this.datainicio,
      this.valor,
      this.capitao,
      this.tiposcampeonatosId,
      this.categoriacampeonatoId,
      this.createdAt,
      this.updatedAt,
      this.minimo,
      this.privado,
      this.status,
      this.situacao,
      this.encerramentoinsc,
      this.regras,
      this.encerrado,
      this.rodadasId,
      this.ngrupos,
      this.faseatual,
      this.rodadaini,
      this.rodadafim,
      this.convites,
      this.participantes,
      this.slug});

  CampeonatoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    imagem = json['imagem'];
    ntimes = json['ntimes'];
    datainicio = json['datainicio'];
    valor = json['valor'];
    capitao = json['capitao'];
    tiposcampeonatosId = json['tiposcampeonatos_id'];
    categoriacampeonatoId = json['categoriacampeonato_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    minimo = json['minimo'];
    privado = json['privado'];
    status = json['status'];
    situacao = json['situacao'];
    encerramentoinsc = json['encerramentoinsc'];
    regras = json['regras'];
    encerrado = json['encerrado'];
    rodadasId = json['rodadas_id'];
    ngrupos = json['ngrupos'];
    faseatual = json['faseatual'];
    rodadaini = json['rodadaini'];
    rodadafim = json['rodadafim'];
    if (json['convites'] != null) {
      convites = <ConviteModel>[];
      json['convites'].forEach((v) {
        convites.add(new ConviteModel.fromJson(v));
      });
    }
    if (json['participantes'] != null) {
      participantes = <ParticipanteModel>[];
      json['participantes'].forEach((v) {
        participantes.add(new ParticipanteModel.fromJson(v));
      });
    }
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['imagem'] = this.imagem;
    data['ntimes'] = this.ntimes;
    data['datainicio'] = this.datainicio;
    data['valor'] = this.valor;
    data['capitao'] = this.capitao;
    data['tiposcampeonatos_id'] = this.tiposcampeonatosId;
    data['categoriacampeonato_id'] = this.categoriacampeonatoId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['minimo'] = this.minimo;
    data['privado'] = this.privado;
    data['status'] = this.status;
    data['situacao'] = this.situacao;
    data['encerramentoinsc'] = this.encerramentoinsc;
    data['regras'] = this.regras;
    data['encerrado'] = this.encerrado;
    data['rodadas_id'] = this.rodadasId;
    data['ngrupos'] = this.ngrupos;
    data['faseatual'] = this.faseatual;
    data['rodadaini'] = this.rodadaini;
    data['rodadafim'] = this.rodadafim;
    if (this.convites != null) {
      data['convites'] = this.convites.map((v) => v.toJson()).toList();
    }
    if (this.participantes != null) {
      data['participantes'] =
          this.participantes.map((v) => v.toJson()).toList();
    }
    data['slug'] = this.slug;
    return data;
  }
}
