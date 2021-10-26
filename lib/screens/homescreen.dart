import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noteitshort/screens/body.dart';
import 'package:noteitshort/screens/bottomsheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoteItShort'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () {
              FirebaseAuth.instance.signOut();
              setState(() {});
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FloatingActionButton.extended(
          elevation: 30,
          backgroundColor: Colors.amber.shade400,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) {
                  return const BottomSheetModal();
                },
              ),
            );
          },
          label: const Text(
            'add note',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: const BodyList(),
    );
  }
}
