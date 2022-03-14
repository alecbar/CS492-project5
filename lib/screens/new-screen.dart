import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class PostData {
  late String url;
  late Timestamp date;
  late int items;
  double? longitude;
  double? lattitude;
}

class NewScreen extends StatefulWidget {
  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final post = PostData();
  bool loading = false;
  late String imagePath;

  LocationData? locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    post.longitude = locationData?.longitude;
    post.lattitude = locationData?.latitude;
    setState(() {});
  }

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
    FirebaseFirestore.instance.collection('posts').add({
      'items': post.items,
      'url': post.url,
      'date': post.date,
      'longitude': post.longitude,
      'lattitude': post.lattitude
    });
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
                    height: 220,
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
                        post.date = Timestamp.now();

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
