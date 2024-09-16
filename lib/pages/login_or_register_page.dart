import 'package:flutter/material.dart';
import 'package:login_page/pages/login/login_page_screen.dart';
import 'package:login_page/pages/register/register_page_screen.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages, // Ensure LoginPage has an onTap parameter
      );
    } else {
      return RegisterPage(
        onTap: togglePages, // Ensure RegisterPageScreen has an onTap parameter
      );
    }
  }
}
