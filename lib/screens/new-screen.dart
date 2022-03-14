import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewScreen extends StatefulWidget {
  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  void storeImage(String imagePath) async {
    File imageFile = File(imagePath);

    // Do we need to generate a random ID

    // Storage ref with name of file
    Reference storageReference =
        FirebaseStorage.instance.ref().child('example.jpg');

    UploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask;
    final url = await storageReference.getDownloadURL();

    print(url);

    // Get URL and then store JSON document with URL
  }

  @override
  Widget build(BuildContext context) {
    String imagePath =
        ModalRoute.of(context)?.settings.arguments.toString() as String;

    File imageFile = File(imagePath);

    return Scaffold(
      appBar: AppBar(title: Text('New Post')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 22,
          ),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Image.file(
              imageFile,
              height: 320,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Number of items',
              ),
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: TextButton(
                onPressed: () {
                  storeImage(imagePath);
                },
                child: Text(
                  'Upload',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(backgroundColor: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
