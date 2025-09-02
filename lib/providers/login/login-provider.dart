// ignore_for_file: override_on_non_overriding_member, file_names, depend_on_referenced_packages, unnecessary_import, prefer_final_fields, avoid_print, unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:pos/api-helpers/services-endpoints.dart';
import 'package:pos/models/profile/profile-model.dart';
import 'package:pos/utils/hive/boxes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import '../../utils/hive/hive_user_model.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late FocusNode emailFocus;
  late FocusNode passwordFocus;

  HiveUserModel? _currentUser;
  HiveUserModel? get currentUser => _currentUser;

  bool _isLoginCorrect = false;
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  LoginProvider() {
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  bool get isLoginCorrect => _isLoginCorrect;
  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;

  Future<ProfileModel> loginApi() async {
    _isLoading = true;
    notifyListeners();

    final url =
        '${SEP.BASE_URL}${SEP.userLoginApi}email=${emailController.text}&password=${passwordController.text}';
    final response = await http.post(Uri.parse(url));
    print("url is $url");
    print("response is ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("data $data");
      if (data["response"]["status"] == "ok") {
        _isLoading = false;
        _isLoginCorrect = true;
        ProfileModel userProfileModel = ProfileModel.fromJson(
          data['response']['user_data'],
        );

        //let's play with hive here
        final userBox = Boxes.getUser();
        await userBox.clear();
        await userBox.add(
          HiveUserModel(
            userId: userProfileModel.userId,
            userEmail: userProfileModel.userEmail,
            userName: userProfileModel.userName,
            userType: userProfileModel.userType,
            image: userProfileModel.image,
            password: userProfileModel.password,
          ),
        );

        /// Save login flag in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool("isLogin", true);
        notifyListeners();
        return userProfileModel;
      } else {
        _isLoading = false;
        notifyListeners();
        throw Exception(data['response']['message']);
      }
    } else {
      _isLoading = false;
      notifyListeners();
      throw Exception("Failed to login");
    }
  }

  //get user data
  void loadUser() {
    final userBox = Boxes.getUser();
    if (userBox.isNotEmpty) {
      _currentUser = userBox.get(0) as HiveUserModel;
    }
    notifyListeners();
  }

  void visibleToggle() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void unFocusAll() {
    emailFocus.unfocus();
    passwordFocus.unfocus();
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  // init Hive
  // init Hive
  static Future<void> initHive() async {
    // Initialize Hive with Flutter support
    await Hive.initFlutter();

    // Register adapter if not already registered
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(HiveUserModelAdapter());
    }

    // Open user box
    await Hive.openBox<HiveUserModel>(Constants.userBox);
  }
}
