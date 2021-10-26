import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/homescreen.dart';
import './formscreen.dart';
import './auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final auth = AuthFire.authstate;
  void _authenticate(String email, String password, AuthState state) {
    if (state == AuthState.login) {
      AuthFire().signin(email, password, context);
    } else {
      AuthFire().signup(email, password, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (ctx, AsyncSnapshot<User?> snap) {
        if (snap.hasData) {
          return const HomeScreen();
        }
        return FormScreen(_authenticate);
      },
    );
  }
}
