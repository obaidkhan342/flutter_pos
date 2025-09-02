class LoginModel {
  Response? response;

  LoginModel({this.response});

  LoginModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class Response {
  String? status;
  UserData? userData;
  String? message;
  String? permission;

  Response({this.status, this.userData, this.message, this.permission});

  Response.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userData = json['user_data'] != null
        ? UserData.fromJson(json['user_data'])
        : null;
    message = json['message'];
    permission = json['permission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    data['message'] = message;
    data['permission'] = permission;
    return data;
  }
}

class UserData {
  String? userId;
  String? userName;
  String? userEmail;
  String? userType;
  String? image;
  String? password;

  UserData({
    this.userId,
    this.userName,
    this.userEmail,
    this.userType,
    this.image,
    this.password,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userType = json['user_type'];
    image = json['image'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['user_type'] = userType;
    data['image'] = image;
    data['password'] = password;
    return data;
  }
}
