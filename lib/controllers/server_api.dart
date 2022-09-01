import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Attendance {
  final bool error;
  final String message;
  const Attendance({
    required this.error,
    required this.message,
  });

  factory Attendance.fromJson(Map<String, dynamic> data) {
    return Attendance(
      error: data['error'],
      message: data['message'],
    );
  }
}

class APIAttendance extends StatefulWidget {
  final String nik;
  final String periode;
  const APIAttendance({Key? key, required this.nik, required this.periode})
      : super(key: key);
  @override
  State<APIAttendance> createState() => _APIAttendanceState();
}

class _APIAttendanceState extends State<APIAttendance> {
  late Future<Attendance> futureAttendance;

  @override
  void initState() {
    super.initState();
    futureAttendance = fetchAttendance(widget.nik, widget.periode);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        FutureBuilder<Attendance>(
          future: futureAttendance,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.message);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
        Text(widget.nik),
      ],
    );
  }
}

Future<Attendance> fetchAttendance(nik, periode) async {
  final response = await http.get(
    Uri.parse(
        'http://127.0.0.1/ci-restserver-master/Get_attendance?nik=$nik&periode=$periode'),
  );

  if (response.statusCode == 200) {
    print(response.body);
    return Attendance.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    throw Exception('Failed to load Employee Attendance');
  }
}
