class ResponseModel {
  bool error;
  String accessToken;
  String message;
  Object userData;
  String token_type;

  ResponseModel(this.error, this.accessToken, this.message, this.userData,
      this.token_type);

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    final bool error = json['error'];
    final accessToken = json['accessToken'];
    final String message = json['message'];
    final Object userData = json['userData'];
    final String token_type = json['tokenType'];
    return ResponseModel(error, accessToken, message, userData, token_type);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['error'] = error;
    json['accessToken'] = accessToken;
    json['userData'] = userData;
    return json;
  }
}
