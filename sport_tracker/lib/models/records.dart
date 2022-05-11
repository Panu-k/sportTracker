import 'dart:ffi';

class Records {
  int idRecords;
  String Sport;
  String time;
  String date;
  String? infotext;
  String? distance;

  Records(this.idRecords, this.Sport, this.time, this.date, this.infotext,
      this.distance);
}
