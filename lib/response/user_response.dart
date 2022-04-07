import 'package:trivelaapp/model/ability_model.dart';

class UserResponse {
  int id;
  String name;
  String email;
  List<AbilityModel> ability;
  String address;
  String image;
  String bio;
  String birthday;
  String country;
  String phone;
  String news;
  String leagues;
  String cpf;
  String status;
  String cep;
  String estado;
  String cidade;
  String bairro;
  String numero;
  String complemento;
  String role;
  String avatar;
  dynamic extras;
  String fullName;
  String userName;

  UserResponse.empty();

  UserResponse(
      this.id,
      this.name,
      this.email,
      this.ability,
      this.address,
      this.image,
      this.bio,
      this.birthday,
      this.country,
      this.phone,
      this.news,
      this.leagues,
      this.cpf,
      this.status,
      this.cep,
      this.estado,
      this.cidade,
      this.bairro,
      this.numero,
      this.complemento,
      this.role,
      this.avatar,
      this.extras,
      this.fullName,
      this.userName);

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    if (json['ability'] != null) {
      ability = <AbilityModel>[];
      json['ability'].forEach((v) {
        ability.add(new AbilityModel.fromJson(v));
      });
    } else {
      ability = <AbilityModel>[];
    }
    address = json['address'];
    image = json['image'];
    bio = json['bio'];
    birthday = json['birthday'];
    country = json['country'];
    phone = json['phone'];
    news = json['news'];
    leagues = json['leagues'];
    cpf = json['cpf'];
    status = json['status'];
    cep = json['cep'];
    estado = json['estado'];
    cidade = json['cidade'];
    bairro = json['bairro'];
    numero = json['numero'];
    role = json['role'];
    complemento = json['complemento'];
    avatar = json['avatar'];
    fullName = json['fullName'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    if (this.ability != null) {
      data['ability'] = this.ability.map((v) => v.toJson()).toList();
    } else {
      data['ability'] = <AbilityModel>[];
    }
    data['address'] = this.address;
    data['image'] = this.image;
    data['bio'] = this.bio;
    data['birthday'] = this.birthday;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['cpf'] = this.cpf;
    data['status'] = this.status;
    data['cep'] = this.cep;
    data['estado'] = this.estado;
    data['cidade'] = this.cidade;
    data['bairro'] = this.bairro;
    data['numero'] = this.numero;
    data['news'] = this.news;
    data['leagues'] = this.leagues;
    data['role'] = this.role;
    data['avatar'] = this.avatar;
    data['fullName'] = this.fullName;
    data['userName'] = this.userName;
    return data;
  }

  @override
  String toString() {
    return super.toString();
  }
}
