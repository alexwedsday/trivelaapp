class SigninResponse {
  bool error;
  String message;
  String accessToken;

  SigninResponse(this.error, this.message, this.accessToken);

  factory SigninResponse.fromJson(Map<String, dynamic> json) {
    final bool error = json['error'];
    final String message = json['message'];
    final String accessToken = json['accessToken'];
    return SigninResponse(error, message, accessToken);
  }

  @override
  String toString() {
    return super.toString();
  }
}
