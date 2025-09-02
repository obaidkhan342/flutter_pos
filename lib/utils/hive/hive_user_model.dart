import 'package:hive/hive.dart';

part 'hive_user_model.g.dart'; // Generated file

@HiveType(typeId: 0) // Make sure typeId is unique across all Hive models
class HiveUserModel extends HiveObject {
  @HiveField(0)
  String? userId;

  @HiveField(1)
  String? userName;

  @HiveField(2)
  String? userEmail;

  @HiveField(3)
  String? userType;

  @HiveField(4)
  String? image;

  @HiveField(5)
  String? password;

  HiveUserModel({
    this.userId,
    this.userName,
    this.userEmail,
    this.userType,
    this.image,
    this.password,
  });
}
