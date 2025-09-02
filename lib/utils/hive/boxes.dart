// ignore_for_file: non_constant_identifier_names
import 'package:hive_flutter/hive_flutter.dart';
import '../constants.dart';
import 'hive_user_model.dart';

class Boxes {
  static Box<HiveUserModel> getUser() =>
      Hive.box<HiveUserModel>(Constants.userBox);
}
