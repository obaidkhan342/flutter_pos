// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:pos/utils/color/color-constant.dart';

class AuthButton extends StatefulWidget {
  final Widget title;
  final VoidCallback onTap;
  const AuthButton({required this.onTap, required this.title});

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: mq.size.width * 0.8,
        height: mq.size.height * 0.07,

        decoration: BoxDecoration(
          // color: Constants.authBtnColor,
          color: ColorConstant.loginBtn,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: widget.title,

          // Text(
          //   widget.title,
          //   style: TextStyle(
          //     fontSize: 18,
          //     color: Colors.white,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ),
      ),
    );
  }
}
