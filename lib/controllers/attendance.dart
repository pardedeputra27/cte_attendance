import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Attendance>> generateAttendanceList(nik, periode) async {
  final response = await http.get(
    Uri.parse(
        'http://192.168.40.14/ci-restserver-flutter/Get_attendance?nik=$nik&periode=$periode'),
  );
  final decodedAttendance =
      json.decode(response.body)['data'].cast<Map<String, dynamic>>();
  List<Attendance> attendanceList = await decodedAttendance
      .map<Attendance>((json) => Attendance.fromJson(json))
      .toList();
  return attendanceList;
}

class Attendance {
  final String date;
  final String dateIn;
  final String timeIn;
  final String timeOut;
  final String meal;
  final String transport;
  final String hours;
  final String istirahat;
  final String absent;

  Attendance({
    required this.date,
    required this.dateIn,
    required this.timeIn,
    required this.timeOut,
    required this.meal,
    required this.transport,
    required this.hours,
    required this.istirahat,
    required this.absent,
  });
  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      date: json['date'],
      dateIn: json['date_in'],
      timeIn: json['time_in'],
      timeOut: json['time_out'],
      meal: json['meal'],
      transport: json['transport'],
      hours: json['hours'],
      istirahat: json['break'],
      absent: json['absent'],
    );
  }
}
