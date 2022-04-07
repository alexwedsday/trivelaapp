class UserModel {
  String name = '';
  String email = '';
  String password = '';

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'c_password': password
      };

  Map<String, dynamic> toJsonLogin() => {'email': email, 'password': password};
}
