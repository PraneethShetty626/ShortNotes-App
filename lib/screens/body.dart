import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noteitshort/firestore/note.dart';

class BodyList extends StatefulWidget {
  const BodyList({Key? key}) : super(key: key);

  @override
  _BodyListState createState() => _BodyListState();
}

class _BodyListState extends State<BodyList> {
  Timestamp date = Timestamp.now();
//////////////////////

  ///
//
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snap) {
        if (snap.hasError ||
            snap.connectionState == ConnectionState.none ||
            !snap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
            child: SizedBox(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height,
          child: ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (ctx, index) {
                var data = snap.data!.docs[index];
                bool col = (DateTime.fromMicrosecondsSinceEpoch(
                            data['date'].microsecondsSinceEpoch)
                        .isAfter(DateTime.now()))
                    ? true
                    : (TimeOfDay.now()
                                .format(context)
                                .compareTo(data['time']) >=
                            1)
                        ? true
                        : false;

                return Dismissible(
                  //////////
                  ///
                  onDismissed: (DismissDirection direction) async {
                    bool ret = true;
                    await showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(actions: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  ret = false;
                                });
                              },
                              child: Text('Confirm Delete'))
                        ]);
                      },
                    );
                    if (ret == true) {
                      return;
                    }

                    ///
                    await FirebaseFirestore.instance
                        .collection(FirebaseAuth.instance.currentUser!.uid)
                        .doc(data['notehead'])
                        .delete()
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('One Note deleted'),
                        duration: Duration(seconds: 1),
                      ));
                    });
                  },

                  ///
                  ///
                  ///
                  ///
                  ///

                  key: Key(data['notehead']),
                  child: Card(
                    shadowColor: Colors.amber.shade500,
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 30,
                      left: 10,
                      right: 10,
                    ),
                    elevation: 30,
                    child: ExpansionTile(
                      collapsedBackgroundColor:
                          col ? Colors.amber.shade400 : Colors.red,
                      tilePadding: const EdgeInsets.all(15),
                      iconColor: col ? Colors.amber : Colors.red,
                      title: Column(
                        children: [
                          Text(
                            data['notehead'],
                          ),
                          Text(
                            DateFormat.yMEd().format(
                                DateTime.fromMicrosecondsSinceEpoch(
                                    data['date'].microsecondsSinceEpoch)),
                          ),
                          Text('@time:${data['time']}'),
                        ],
                      ),
                      children: [
                        SizedBox(
                          height: 70,
                          child: Text(
                            data['description'],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
      },
    );
  }
}

// List.generate(
//   snap.data!.docs.length,
//   (index) {

//   },
// ),


