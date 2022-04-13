class QrcodeModel {
  String content;
  String base64;

  QrcodeModel();

  QrcodeModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    base64 = json['base64'];
  }
}
