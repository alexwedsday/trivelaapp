class TimeModel {
  int temporada_inicial;
  String cor_fundo_escudo;
  String cor_camisa;
  String cor_borda_escudo;
  String foto_perfil;
  String nome_cartola;
  String globo_id;
  String nome;
  String url_escudo_svg;
  String url_escudo_png;
  String url_camisa_svg;
  String url_camisa_png;
  String slug;

  TimeModel.empty();

  TimeModel(
      this.temporada_inicial,
      this.cor_fundo_escudo,
      this.cor_camisa,
      this.cor_borda_escudo,
      this.foto_perfil,
      this.nome_cartola,
      this.globo_id,
      this.nome,
      this.url_escudo_svg,
      this.url_escudo_png,
      this.url_camisa_svg,
      this.url_camisa_png);

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    final int temporada_inicial = json['temporada_inicial'];
    final String cor_fundo_escudo = json['cor_fundo_escudo'];
    final String cor_camisa = json['cor_camisa'];
    final String cor_borda_escudo = json['cor_borda_escudo'];
    final String foto_perfil = json['foto_perfil'];
    final String nome_cartola = json['nome_cartola'];
    final String globo_id = json['globo_id'];
    final String nome = json['nome'];
    final String url_escudo_svg = json['url_escudo_svg'];
    final String url_escudo_png = json['url_escudo_png'];
    final String url_camisa_svg = json['url_camisa_svg'];
    final String url_camisa_png = json['url_camisa_png'];
    final String slug = json['slug'];
    return TimeModel(
        temporada_inicial,
        cor_fundo_escudo,
        cor_camisa,
        cor_borda_escudo,
        foto_perfil,
        nome_cartola,
        globo_id,
        nome,
        url_escudo_svg,
        url_escudo_png,
        url_camisa_svg,
        url_camisa_png);
  }
}
