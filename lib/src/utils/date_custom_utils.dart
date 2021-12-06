import 'package:cloud_firestore/cloud_firestore.dart';

class DateCustomUtils {
  static Duration calcDateDifference(Timestamp t1, Timestamp t2) {
    DateTime dateTime1 = DateTime.parse(t1.toDate().toString());
    DateTime dateTime2 = DateTime.parse(t2.toDate().toString());
    return dateTime2.difference(dateTime1);
  }

  static String dateTimeToStringFormat(DateTime dateTime) {
    final int day = dateTime.day;
    final int month = dateTime.month;
    final int year = dateTime.year;
    final int hour = dateTime.hour;
    final int min = dateTime.minute;
    final int sec = dateTime.second;

    return "$day-$month-$year $hour:$min:$sec";
  }
}
