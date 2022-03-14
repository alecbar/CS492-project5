import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class PostData {
  late String url;
  late String date;
  late int items;
}

class NewScreen extends StatefulWidget {
  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final post = PostData();
  bool loading = false;
  late String imagePath;

  Future storeImage(String imagePath) async {
    // Load image file
    File imageFile = File(imagePath);

    // Storage ref with name of file
    Reference storageReference =
        FirebaseStorage.instance.ref().child("${DateTime.now()}.jpg");

    // Upload image
    UploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask;
    final url = await storageReference.getDownloadURL();

    return url;
  }

  void savePost(PostData post) async {
    FirebaseFirestore.instance
        .collection('posts')
        .add({'items': post.items, 'url': post.url, 'date': post.date});
  }

  @override
  Widget build(BuildContext context) {
    String imagePath =
        ModalRoute.of(context)?.settings.arguments.toString() as String;

    File imageFile = File(imagePath);
    int numItems = 0;

    return Scaffold(
      appBar: AppBar(title: Text('New Post')),
      body: loading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Center(child: CircularProgressIndicator())],
            )
          : Column(
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
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        post.items = int.parse(value);
                        setState(() {
                          numItems = int.parse(value);
                        });
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ]),
                ),
                SizedBox(
                  height: 22,
                ),
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: TextButton(
                      onPressed: () async {
                        // Update loading state
                        setState(() {
                          loading = true;
                        });

                        final url = await storeImage(imagePath);

                        // Create post object
                        post.url = url;
                        post.date = DateTime.now().toString();

                        // Pass post to save post
                        savePost(post);

                        Navigator.pushNamed(context, "/");
                      },
                      child: Text(
                        'Upload',
                        style: TextStyle(color: Colors.white),
                      ),
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.blue)),
                ),
              ],
            ),
    );
  }
}
