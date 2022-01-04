import 'package:cloud_firestore/cloud_firestore.dart';

class DateCustomUtils {
  static Duration calcDateDifference(Timestamp t1, Timestamp t2) {
    DateTime dateTime1 = DateTime.parse(t1.toDate().toString());
    DateTime dateTime2 = DateTime.parse(t2.toDate().toString());
    return dateTime2.difference(dateTime1);
  }

  static String dateTimeToStringFormat(DateTime dateTime,
      {bool onlyDate = false, bool onlyTime = false}) {
    final int day = dateTime.day;
    final int month = dateTime.month;
    final int year = dateTime.year;
    final int hour = dateTime.hour;
    final int min = dateTime.minute;
    final int sec = dateTime.second;
    final String date = "$day-$month-$year";
    final String time = "$hour:$min:$sec";
    if (onlyDate) return date;
    if (onlyTime) return time;
    return "$date $time";
  }
}
