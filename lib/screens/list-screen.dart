import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  var posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Wasteagram - #"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.camera_alt),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: PostList());
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
              ))
          .toList(),
    );
  }
}
