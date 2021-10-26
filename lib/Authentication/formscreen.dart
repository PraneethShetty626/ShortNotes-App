import 'package:flutter/material.dart';

enum AuthState { login, signup }

// ignore: use_key_in_widget_constructors
// ignore: must_be_immutable
class FormScreen extends StatefulWidget {
  Function(String email, String password, AuthState state) authenticate;
  // ignore: use_key_in_widget_constructors
  FormScreen(this.authenticate);
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String email = '', password = '';
  AuthState state = AuthState.signup;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  spreadRadius: 20,
                  color: Colors.black,
                )
              ],
              border: Border.symmetric(),
              color: Colors.yellowAccent,
            ),
            height: 300,
            width: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 100),
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'email'),
                    validator: (value) {
                      if (value != null && value.contains('@')) {
                        return null;
                      }
                      return 'Enter valid email';
                    },
                    onSaved: (value) {
                      if (value != null) email = value.trim();
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'password'),
                    validator: (value) {
                      if (value != null && value.length >= 5) {
                        return null;
                      }
                      return 'Enter valid password';
                    },
                    onSaved: (value) {
                      if (value != null) password = value;
                    },
                  ),
                  // if (state == AuthState.signup)
                  //   TextFormField(
                  //     decoration: const InputDecoration(labelText: 'confirmpassword'),
                  //   ),
                  TextButton.icon(
                    onPressed: () {
                      if (!_formkey.currentState!.validate()) {
                        return;
                      }
                      _formkey.currentState!.save();
                      widget.authenticate(email, password, state);
                    },
                    icon: state == AuthState.login
                        ? const Icon(Icons.login)
                        : const Icon(Icons.no_accounts_outlined),
                    label: state == AuthState.login
                        ? const Text(
                            'login',
                            style: TextStyle(color: Colors.black),
                          )
                        : const Text(
                            'signup',
                            style: TextStyle(color: Colors.black),
                          ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            state == AuthState.login
                                ? state = AuthState.signup
                                : state = AuthState.login;
                          });
                        },
                        icon: state != AuthState.login
                            ? const Icon(Icons.login)
                            : const Icon(Icons.login),
                        label: state != AuthState.login
                            ? const Text(
                                'login',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              )
                            : const Text(
                                'Dont have account',
                                style: TextStyle(color: Colors.black),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
