import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ListScreen extends StatefulWidget {
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  var posts = [];

  PickedFile? image;
  final picker = ImagePicker();
  File? imageFile;

  void getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = PickedFile(pickedFile.path);

      print(image!.path);
      //imageFile = File(image!.path);
      Navigator.pushNamed(context, '/new', arguments: image!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Wasteagram - #"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getImage();
          },
          child: const Icon(Icons.camera_alt),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: posts.length > 0
            ? PostList()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              ));
  }
}

class PostList extends StatelessWidget {
  var posts = [
    {"date": "Thursday, Mar 10, 2022", "count": 1}
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: posts
          .map((post) => ListTile(
                title: Text(post["date"].toString()),
                trailing: Text(post["count"].toString()),
                onTap: () {
                  Navigator.pushNamed(context, '/details', arguments: {});
                },
              ))
          .toList(),
    );
  }
}
