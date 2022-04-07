import 'package:trivelaapp/response/user_response.dart';

class UserObject {
  UserResponse value;

  UserObject({this.value});

  UserObject.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? UserResponse.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['value'] = this.value.toJson();
    }
    return data;
  }
}
