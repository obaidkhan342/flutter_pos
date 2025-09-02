// ignore_for_file: unused_local_variable, use_build_context_synchronously, deprecated_member_use, unused_import

import 'package:flutter/material.dart';
import 'package:pos/page-and-routes/routes-name.dart';
import 'package:pos/utils/hive/boxes.dart';
import 'package:pos/widgets/custom-widgets/custom-drawer.dart';
import 'package:pos/widgets/custom-widgets/home-card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/login/login-provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LoginProvider>(context, listen: false).loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final uBox = Boxes.getUser();
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                Text(
                  'Buisness Overview',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(.8),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.customerScreen);
                  },
                  icon: Icon(
                    Icons.person_add_alt_1_outlined,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white, size: 30),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Works now
              },
            );
          },
        ),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: mq.height * 0.02),
              HomeCard(),
              // GestureDetector(
              //   onTap: () async {
              //     await uBox.clear();
              //     final sPref = await SharedPreferences.getInstance();
              //     await sPref.setBool("isLogin", false);
              //     Navigator.pushReplacementNamed(context, RoutesName.login);
              //   },
              //   child: Center(child: Text("Logout")),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
