import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Notes/add_bottom_sheet.dart';
import 'package:firebase_app/Notes/edit_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestorePage extends StatefulWidget {
  final User? user;
  const FirestorePage({super.key, required this.user});

  @override
  State<FirestorePage> createState() => _FirestorePageState();
}

class _FirestorePageState extends State<FirestorePage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference notes = FirebaseFirestore.instance.collection('notes');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: notes.where('user', isEqualTo: widget.user?.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Une erreur s'est produite ");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Chargement"),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              void deleteNote() {
                notes.doc(document.id).delete();
              }

              void showEditBottomSheet() {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: EditBottomSheet(
                        noteData: data,
                        noteID: document.id,
                      ),
                    );
                  },
                );
              }

              return Padding(
                padding: const EdgeInsets.all(4),
                child: ListTile(
                    // No idea on how to get the right image from the firebase storage
                    title: Text(data['title']),
                    subtitle: Text(data['content']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: showEditBottomSheet,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: deleteNote,
                        ),
                      ],
                    )),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddBottomSheet(
                  user: widget.user,
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
