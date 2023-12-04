import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  final String title;
  final String text;
  final User? user;
  final PlatformFile? pickedFile;
  const AddButton(
      {super.key,
      required this.title,
      required this.text,
      required this.user,
      required this.pickedFile});

  @override
  State<AddButton> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddButton> {
  Future uploadFile() async {
    if (widget.pickedFile == null) {
      return;
    }
    final path = 'files/${widget.pickedFile!.name}';
    final file = File(widget.pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }

  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (widget.title.isNotEmpty || widget.text.isNotEmpty) {
          notes.add({
            'title': widget.title,
            'content': widget.text,
            'user': widget.user?.uid,
          });
          uploadFile();
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('La tâche doit contenir un texte et un titre !'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      child: const Text("Ajouter une notes "),
    );
  }
}
