class SaldoResponse {
  bool error;
  double saldo;

  SaldoResponse({this.error, this.saldo});

  SaldoResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    saldo = double.parse(json['saldo'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['saldo'] = this.saldo;
    return data;
  }
}
