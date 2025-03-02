import 'package:easy_talk/Pages/home_page.dart';
import 'package:easy_talk/services/auth/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return  HomePage();
          }
          // user is logged in
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
