import 'package:flutter/material.dart';
import '../modals/post.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Post post = ModalRoute.of(context)?.settings.arguments as Post;

    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Text(
              post.longDate,
              style: TextStyle(fontSize: 22.0),
            )),
            SizedBox(
              height: 12.0,
            ),
            Image.network(
              post.url,
              height: 320,
            ),
            SizedBox(
              height: 12.0,
            ),
            Center(
                child: Text(
              "${post.itemsText} items",
              style: TextStyle(fontSize: 22.0),
            )),
          ],
        ),
      ),
    );
  }
}
