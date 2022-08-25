class LoginModel {
  String? type;
  String? message;
  UserData? userData;

  LoginModel();

  LoginModel.fromjson(Map<String, dynamic>? json) {
    if (json != null) {
      type = json['type'];
      message = json['message'];

      userData = UserData.fromjson(json['data']);
    }
  }
}

class UserData {
  UserModel? user;
  String? accessToken;
  String? refreshToken;

  UserData.fromjson(Map<String, dynamic>? json) {
    if (json != null) {
      user = UserModel.fromjson(json['data']);
      accessToken = json['accessToken'];
      refreshToken = json['refreshToken'];
    }
  }
}

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;

  UserModel.fromjson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['userId'];
      firstName = json['firstName'];
      lastName = json['lastName'];
      email = json['email'];
      imageUrl = json['email'];
    }
  }
}
