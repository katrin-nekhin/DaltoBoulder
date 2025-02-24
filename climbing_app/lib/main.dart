import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
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
  Uint8List? _processedImage;
  String  _msg = "Captue wall";

  Future<void> _processImage() async {
    if (_image == null) return;

    _msg = "parsing";
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://refactored-space-yodel-6954xjpwp7xjc7wq-8000.app.github.dev/process-image/')
    );//http://127.0.0.1:8000/docs
    _msg = "sending request";
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path));
    
    _msg = "waiting for response";
    var response = await request.send().timeout(Duration(seconds: 15));
    if (response.statusCode == 200) {
      _msg = "sucsess! downloading image";
      String responseString = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseString);
      String base64Image = jsonResponse['image'];
      setState(() {
        _processedImage = base64Decode(base64Image);
      });
    } else {
      _msg = "Upload failed with status: ${response.statusCode}";
    }
  }

  Future<void> _captureImage() async {
    final XFile? image = await ImagePicker().pickImage( source: ImageSource.camera, imageQuality: 50, );
    if (image != null) {
      setState(() => _image = File(image.path));
      // Automatically upload the image after it is captured.
      _processImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Decide which image to display:
    Widget displayedImage;
    if (_processedImage != null) {
      // If we have the processed image, display it.
      displayedImage = Image.memory(_processedImage!, height: 200);
    } else {
      // Otherwise, show a placeholder text.
      displayedImage = Text(_msg) ;
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Climbing App")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              displayedImage,
              SizedBox(height: 20),
              ElevatedButton(onPressed: _captureImage, child: Text("camera")),
              SizedBox(height: 20),
              //ElevatedButton(onPressed: _uploadImage, child: Text("Upload Image")),
            ],
          ),
        ),
      ),
    );
  }
}
