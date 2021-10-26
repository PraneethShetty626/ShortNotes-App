import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Note {
  String header;
  String description;
  Timestamp date;
  String time;
  bool isEpanded = false;
  Note({
    required this.header,
    required this.description,
    required this.date,
    required this.time,
  });
}
