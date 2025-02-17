import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ClimbingApp());
}

class ClimbingApp extends StatefulWidget {
  @override
  _ClimbingAppState createState() => _ClimbingAppState();
}

class _ClimbingAppState extends State<ClimbingApp> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:8000/process-image/')
    );
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path));
    
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image uploaded successfully!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Climbing App")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image != null ? Image.file(_image!) : Text("No image selected"),
              ElevatedButton(onPressed: _pickImage, child: Text("Pick Image")),
              ElevatedButton(onPressed: _uploadImage, child: Text("Upload Image")),
            ],
          ),
        ),
      ),
    );
  }
}
