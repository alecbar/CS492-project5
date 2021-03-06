import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Post {
  late String url;
  late int items;
  late Timestamp date;
  late double lattitude;
  late double longitude;

  Post(this.url, this.items, this.date, this.lattitude, this.longitude);

  Post.fromMap(Map<String, dynamic> data) {
    url = data["url"];
    items = data["items"];
    date = data["date"];
    lattitude = data["lattitude"];
    longitude = data["longitude"];
  }

  String get itemsText {
    return items.toString();
  }

  // February 21, 2022
  String get shortDate {
    return DateFormat.yMMMMd().format(date.toDate());
  }

  // Monday, February 21, 2022
  String get longDate {
    return DateFormat.yMMMMEEEEd().format(date.toDate());
  }
}
