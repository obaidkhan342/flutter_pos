// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:pos/view/auth-ui/splash_screen.dart';
import 'package:pos/view/user-panel/customer-ui/add-customer.dart';
import 'package:pos/view/user-panel/customer-ui/customer-profile.dart';
import 'package:pos/view/user-panel/customer-ui/customers-screen.dart';
import 'package:pos/view/user-panel/home/home_screen.dart';

import '../view/auth-ui/login.dart';
import 'routes-name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: ((context) => SplashScreen()));
      case RoutesName.login:
        return MaterialPageRoute(builder: ((context) => LoginScreen()));
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: ((context) => HomeScreen()));
      case RoutesName.customerScreen:
        return MaterialPageRoute(builder: ((context) => CustomersScreen()));
      case RoutesName.addCustomer:
        return MaterialPageRoute(builder: ((context) => AddCustomer()));
      // case RoutesName.customerProfile:
      //   return MaterialPageRoute(builder: ((context) => CustomerProfile()));
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(body: Center(child: Text("No Routes Defined")));
          },
        );
    }
  }
}
