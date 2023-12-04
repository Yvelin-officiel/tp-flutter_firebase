import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/Notes/images/image_upload.dart';

class EditBottomSheet extends StatefulWidget {
  final Map<String, dynamic> noteData;
  final String noteID;

  const EditBottomSheet(
      {Key? key, required this.noteData, required this.noteID})
      : super(key: key);

  @override
  State<EditBottomSheet> createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.noteData['title']);
    _contentController =
        TextEditingController(text: widget.noteData['content']);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: null,
            ),
            const SizedBox(height: 16),
            const ImageUpload(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String newTitle = _titleController.text;
                String newContent = _contentController.text;
                FirebaseFirestore.instance
                    .collection('notes')
                    .doc(widget.noteID)
                    .update({
                  'title': newTitle,
                  'content': newContent,
                }).then((_) {
                  Navigator.pop(
                      context); // Close the bottom sheet after updating
                }).catchError((error) {
                  print("Failed to update note: $error");
                  // Handle error message or show a Snackbar to the user
                });
              },
              child: const Text('Update Note'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
