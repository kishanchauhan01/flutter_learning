import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ImagePicker _picker = ImagePicker();
  XFile? _picked;
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    final uri = Uri.http(
    "10.109.179.35:8000",                   // host:port
    "/api/v1/images/image-upload",         // endpoint path
    {"event_name": "webBuilder"} // query params
  );

  var request = http.MultipartRequest('POST', uri);

  // "image" must match the field name in multer (upload.single("image"))
  request.files.add(await http.MultipartFile.fromPath('images', _image!.path));

  var response = await request.send();

  if (response.statusCode == 200) {
    print("✅ Upload success");
  } else {
    print("❌ Upload failed: ${response.statusCode}");
  }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Images')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick image'),
              ),

              const SizedBox(height: 16),
              if (_image != null) Image.file(_image!, height: 200),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _uploadImage,
                child: const Text("Upload"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
