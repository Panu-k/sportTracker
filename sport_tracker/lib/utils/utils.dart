import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

class Utils {
  static Time_Calculator(TimeRange timeRange) {
    String _time;
    int startTime = timeRange.startTime.hour * 60 + timeRange.startTime.minute;
    int endTime = timeRange.endTime.hour * 60 + timeRange.endTime.minute;
    int min = endTime - startTime;
    double divine = min / 60;
    int hours = divine.round();
    int minutes = min % 60;
    if (hours > 0)
      return _time = "$hours t, $minutes min";
    else {
      return _time = "$minutes min";
    }
  }

  static Future<bool> leavePage(BuildContext context) async {
    final shouldPop = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to leave without saving?'),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('No')),
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Yes'))
              ],
            ));

    return shouldPop ?? false;
  }
}
