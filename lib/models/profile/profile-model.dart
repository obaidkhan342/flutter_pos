// ignore_for_file: file_names

class ProfileModel {
  String? userId;
  String? userName;
  String? userEmail;
  String? userType;
  String? image;
  String? password;

  ProfileModel({
    this.userId,
    this.userName,
    this.userEmail,
    this.userType,
    this.image,
    this.password,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
