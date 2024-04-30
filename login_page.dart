import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudoperation/firestore.dart';
import 'package:flutter/material.dart';

class Loginn extends StatefulWidget {
  const Loginn({super.key});

  @override
  State<Loginn> createState() => _LoginnState();
}

class _LoginnState extends State<Loginn> {
  final TextEditingController tt = TextEditingController();
  final Firebaseee ff = Firebaseee();

  void popup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: tt,
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                ff.add(tt.text);
                tt.clear();
                Navigator.pop(context);
              },
              child: Text("ADD"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Note"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: popup,
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: ff.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List notessl = snapshot.data!.docs;

              return ListView.builder(itemBuilder: (context, index) {
                itemCount:
                notessl.length;
                DocumentSnapshot ds = notessl[index];
                String docId = ds.id;

                Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
                String text = data['note'];

                return ListTile(
                  title: Text(text),
                );
              });
            } else {
              return Text('Nope Data found');
            }
          },
        ));
  }
}
