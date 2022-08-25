class UserModel {
  String? type;
  String? message;
  userData? data;

  UserModel();

  UserModel.fromjson(Map<String, dynamic>? json) {
    if (json != null) {
      type = json['type'];
      message = json['message'];

      data = userData.fromjson(json['data']);
    }
  }
}

class userData {
  User? user;

  userData.fromjson(Map<String, dynamic>? json) {
    if (json != null) {
      user = User.fromjson(json['data']);
    }
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;
  String? accessToken;
  String? refreshToken;
  User.fromjson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      firstName = json['firstName'];
      lastName = json['lastName'];
      email = json['email'];
      imageUrl = json['email'];
      accessToken = json['accessToken'];
      refreshToken = json['refreshToken'];
    }
  }
}
