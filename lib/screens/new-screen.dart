import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewScreen extends StatefulWidget {
  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    String imagePath =
        ModalRoute.of(context)?.settings.arguments.toString() as String;

    print(imagePath);

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
            child: Image.file(imageFile),
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
                onPressed: () {},
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
