import 'package:flutter/material.dart';
import 'package:pos/page-and-routes/routes-name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loginStatus();
  }

  Future<void> _loginStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    final pref = await SharedPreferences.getInstance();
    final isLoggedIn = pref.getBool("isLogin") ?? false;
    if (mounted) {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "POINT OF SALE ",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
