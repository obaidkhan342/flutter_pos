// ignore_for_file: unused_local_variable, avoid_unnecessary_containers, sized_box_for_whitespace, use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pos/page-and-routes/routes-name.dart';
import 'package:pos/providers/login/login-provider.dart';
import 'package:pos/widgets/login/auth-button.dart';
import 'package:pos/widgets/login/build-text-formField.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          loginProvider.unFocusAll();
        },
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: mq.size.height * 0.09),
              Image.asset('assets/images/TFS_LOGO.png'),
              SizedBox(height: mq.size.height * 0.09),
              Card(
                color: Colors.white.withOpacity(0.8),
                elevation: 5,
                child: Container(
                  height: mq.size.height * 0.4,
                  width: mq.size.width * 1,
                  child: Column(
                    children: [
                      SizedBox(height: mq.size.height * 0.03),
                      Consumer<LoginProvider>(
                        builder: (context, value, child) {
                          return buildTextFormField(
                            focus: value.emailFocus,
                            context: context,
                            controller: value.emailController,
                            name: " Email",
                            prefixIcon: Icon(Icons.email),
                            nextFocus: value.passwordFocus,
                          );
                        },
                      ),

                      SizedBox(height: mq.size.height * 0.03),
                      Consumer<LoginProvider>(
                        builder: (context, value, child) {
                          return buildTextFormField(
                            focus: value.passwordFocus,
                            context: context,
                            isPassword: value.isPasswordVisible,
                            controller: value.passwordController,
                            name: " Password",
                            prefixIcon: Icon(Icons.email),
                            // onChanged: () {},
                            suffixIcon: IconButton(
                              icon: Icon(
                                value.isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                value
                                    .visibleToggle(); // toggle password visibility
                              },
                            ),
                            nextFocus: loginProvider.passwordFocus,
                          );
                        },
                      ),
                      // buildTextFormField(
                      //   focus: loginProvider.passwordFocus,
                      //   context: context,
                      //   controller: loginProvider.emailController,
                      //   name: " Password",
                      //   prefixIcon: Icon(Icons.lock),
                      // ),
                      SizedBox(height: mq.size.height * 0.02),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password? ",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 143, 142, 142),
                              // color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: mq.size.height * 0.03),
                      Consumer<LoginProvider>(
                        builder: (context, provider, child) {
                          return provider.isLoading
                              ? CircularProgressIndicator()
                              : AuthButton(
                                  onTap: () async {
                                    try {
                                      final user = await provider.loginApi();
                                      if (provider.isLoginCorrect) {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          RoutesName.homeScreen,
                                        );
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text(e.toString())),
                                      );
                                    }
                                  },
                                  title: Text('Login'),
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
