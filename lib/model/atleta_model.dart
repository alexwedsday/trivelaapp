class AtletaModel {
  int id;
  int idatleta;
  String nome;
  String slug;
  String apelido;
  String foto;
  int idrodada;
  int idclube;
  int idposicao;
  int idstatus;
  String pontos;
  String preco;
  String variacao;
  String media;
  int jogos;
  String scout;
  String createdAt;
  String updatedAt;

  AtletaModel(
      {this.id,
      this.idatleta,
      this.nome,
      this.slug,
      this.apelido,
      this.foto,
      this.idrodada,
      this.idclube,
      this.idposicao,
      this.idstatus,
      this.pontos,
      this.preco,
      this.variacao,
      this.media,
      this.jogos,
      this.scout,
      this.createdAt,
      this.updatedAt});

  AtletaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idatleta = json['idatleta'];
    nome = json['nome'];
    slug = json['slug'];
    apelido = json['apelido'];
    foto = json['foto'];
    idrodada = json['idrodada'];
    idclube = json['idclube'];
    idposicao = json['idposicao'];
    idstatus = json['idstatus'];
    pontos = json['pontos'];
    preco = json['preco'];
    variacao = json['variacao'];
    media = json['media'];
    jogos = json['jogos'];
    scout = json['scout'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idatleta'] = this.idatleta;
    data['nome'] = this.nome;
    data['slug'] = this.slug;
    data['apelido'] = this.apelido;
    data['foto'] = this.foto;
    data['idrodada'] = this.idrodada;
    data['idclube'] = this.idclube;
    data['idposicao'] = this.idposicao;
    data['idstatus'] = this.idstatus;
    data['pontos'] = this.pontos;
    data['preco'] = this.preco;
    data['variacao'] = this.variacao;
    data['media'] = this.media;
    data['jogos'] = this.jogos;
    data['scout'] = this.scout;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
