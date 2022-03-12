import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: Placeholder(),
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
