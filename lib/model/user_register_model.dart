class UserRegisterModel {
  String name = '';
  String email = '';

  UserRegisterModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];
}
