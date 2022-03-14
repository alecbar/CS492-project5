import 'package:cloud_firestore/cloud_firestore.dart';
import '../lib/modals/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  test("Verify post named constructor", () {
    var postData = {
      "url": "url",
      "items": 1,
      "date": Timestamp.now(),
      "lattitude": 100.00,
      "longitude": -100.00
    };

    final Post post = Post.fromMap(postData);

    expect(post.url, postData["url"]);
    expect(post.lattitude, 100.00);
    expect(post.longitude, 100.00);
    expect(post.shortDate, DateFormat.yMMMMd().format(DateTime.now()));
    expect(post.longDate, DateFormat.yMMMMEEEEd().format(DateTime.now()));
  });
}
