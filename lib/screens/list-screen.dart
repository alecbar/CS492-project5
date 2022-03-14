import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../modals/post.dart';

class ListScreen extends StatefulWidget {
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
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
          title: Text("Wasteagram"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getImage();
          },
          child: const Icon(Icons.camera_alt),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: PostList());
  }
}

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.docs != null &&
              snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var postDoc = snapshot.data!.docs[index];

                  var postData = {
                    "date": postDoc["date"],
                    "items": postDoc["items"],
                    "url": postDoc["url"],
                    "lattitude": postDoc["lattitude"],
                    "longitude": postDoc["longitude"],
                  };

                  Post post = Post.fromMap(postData);

                  return ListTile(
                    title: Text(post.longDate),
                    trailing: Text(post.itemsText),
                    onTap: () {
                      Navigator.pushNamed(context, '/details', arguments: post);
                    },
                  );
                });
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            );
          }
        });
  }
}

class PostListOld extends StatelessWidget {
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
