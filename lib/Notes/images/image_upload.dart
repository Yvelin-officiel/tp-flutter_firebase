import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  PlatformFile? pickedFile;

  Future<bool> requestStoragePermission() async {
    var status = await Permission.storage.status;
    // verify if storage permission is granted, and ask it if not
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        // if user dont grant
        return false;
      }
    }
    return true;
  }

  Future selectFile() async {
    var permissionStatus = await requestStoragePermission();
    if (!permissionStatus) {
      return;
    }

    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (pickedFile != null) Text(pickedFile!.name),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: selectFile,
          child: const Text('Select file'),
        ),
      ],
    ));
  }
}
