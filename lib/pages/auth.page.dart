import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/pages/home.page.dart';
import 'package:login_page/pages/login_or_register_page.dart';
import 'package:login_page/pages/login/login_page_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //logged
          if (snapshot.hasData) {
            return HomePage();
          }
          //NOT logged
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
