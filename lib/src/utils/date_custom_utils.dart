import 'package:cloud_firestore/cloud_firestore.dart';

class DateCustomUtils {
  static Duration calcDateDifference(Timestamp t1, Timestamp t2) {
    DateTime dateTime1 = DateTime.parse(t1.toDate().toString());
    DateTime dateTime2 = DateTime.parse(t2.toDate().toString());
    return dateTime2.difference(dateTime1);
  }
}
