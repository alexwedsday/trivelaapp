class TransactionModel {
  String valor;
  String site;

  TransactionModel({this.valor, this.site});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['valor'] = valor;
    json['site'] = site;
    return json;
  }
}