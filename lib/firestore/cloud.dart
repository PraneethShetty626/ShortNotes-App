import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CloudStorage {
  static final authstate = FirebaseAuth.instance.currentUser;
  Future adddata(String notehead, String description, DateTime date,
      TimeOfDay time) async {
    try {
      final ef = await FirebaseFirestore.instance
          .collection(authstate!.uid)
          .doc(notehead)
          .set(
        {
          'notehead': notehead,
          'description': description,
          'date': date,
          'time': time.toString(),
        },
      );
    } catch (e) {
      print('failure');
    }
  }
}
