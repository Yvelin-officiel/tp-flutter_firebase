import 'package:file_picker/file_picker.dart';
import 'package:firebase_app/Notes/Widgets/add_button.dart';
import 'package:firebase_app/Notes/images/image_upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddBottomSheet extends StatefulWidget {
  final User? user;

  const AddBottomSheet({super.key, required this.user});

  @override
  State<AddBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<AddBottomSheet> {
  PlatformFile? pickedFile;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            autofocus: true,
            controller: _titleController,
            decoration: const InputDecoration(hintText: 'Ajouter un titre'),
          ),
        )),
        SizedBox(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: 'Ajouter un texte'),
          ),
        )),
        const ImageUpload(),
        AddButton(
          title: _titleController.text,
          text: _textController.text,
          user: widget.user,
          pickedFile: pickedFile,
        )
      ]),
    );
  }
}
