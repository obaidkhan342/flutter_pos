// ignore_for_file: file_names, unused_local_variable, unused_import, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pos/utils/constants.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Container(
      height: mq.size.height * 0.2,
      width: mq.size.width,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back , Admin! ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: mq.size.height * 0.02),
            Text(
              'Here\'s what\'s hapeening with your store today. ',
              style: TextStyle(
                fontSize: 15,
                // fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            SizedBox(height: mq.size.height * 0.02),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {},
              child: Text(
                "Refresh Data",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
