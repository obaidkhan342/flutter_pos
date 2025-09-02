// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:pos/page-and-routes/routes-name.dart';
import 'package:pos/page-and-routes/routes.dart';
import 'package:pos/providers/cusomters/add-update-customer-provider.dart';
import 'package:pos/providers/cusomters/fetch-customers-provider.dart';
import 'package:pos/providers/login/login-provider.dart';
import 'package:pos/providers/products/category-provider.dart';
import 'package:pos/utils/color/color-constant.dart';
import 'package:pos/view/user-panel/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoginProvider.initHive();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => CustomerProvider()),
        ChangeNotifierProvider(create: (context) => AddCustomerProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.black),
        appBarTheme: AppBarTheme(backgroundColor: ColorConstant.appBarColor),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
