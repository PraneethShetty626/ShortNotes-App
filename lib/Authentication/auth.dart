import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthFire {
  static final authstate = FirebaseAuth.instance;

  //sign in
  Future signin(String email, String password, BuildContext context) async {
    try {
      await authstate.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Email/password')));
    }
  }

  //signup
  Future signup(String email, String password, BuildContext context) async {
    try {
      await authstate.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Email/password signup again')));
    }
  }

  //delete

}
