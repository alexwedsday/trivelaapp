class PaymeQrcode {
  String url;
  String base64;
  String plain;

  PaymeQrcode({this.url, this.base64, this.plain});

  PaymeQrcode.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    base64 = json['base64'];
    plain = json['plain'];
  }
}
