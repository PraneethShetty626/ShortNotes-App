import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:noteitshort/firestore/cloud.dart';
import 'package:noteitshort/firestore/note.dart';

class BottomSheetModal extends StatefulWidget {
  const BottomSheetModal({Key? key}) : super(key: key);

  @override
  State<BottomSheetModal> createState() => _BottomSheetModalState();
}

class _BottomSheetModalState extends State<BottomSheetModal> {
  String header = '';
  String description = '';
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  final _formkey = GlobalKey<FormState>();
  ////////////////////
  ///
  ///
  void submit() {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    _formkey.currentState!.save();
    CloudStorage().adddata(header, description, date, time);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.amber.shade100,
      child: Card(
        margin: const EdgeInsets.only(
          top: 60,
          left: 20,
          right: 20,
          bottom: 150,
        ),
        shadowColor: Colors.black,
        borderOnForeground: true,
        color: Colors.yellowAccent.shade100,
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  maxLines: 5,
                  decoration: const InputDecoration(labelText: 'key head'),
                  onSaved: (value) {
                    //
                    header = value!;
                  },
                ),
                TextFormField(
                  maxLines: 50,
                  
                  decoration: const InputDecoration(labelText: 'description'),
                  onSaved: (value) {
                    //
                    description = value!;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                          width: 150,
                          child:
                              Text(DateFormat.yMEd().format(date).toString())),
                      ElevatedButton.icon(
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2050))
                              .then((value) {
                            setState(() {
                              date = value!;
                            });
                          });
                        },
                        icon: const Icon(Icons.date_range_outlined),
                        label: const Text('pick a date'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(time.format(context).toString()),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          showTimePicker(
                            context: context,
                            initialTime: time,
                          ).then((value) {
                            setState(() {
                              time = value!;
                            });
                          });
                        },
                        icon: const Icon(Icons.date_range_outlined),
                        label: const Text('pick a time'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      submit();
                    },
                    icon: const Icon(Icons.add_comment_sharp),
                    label: const Text('add to todoLost'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
