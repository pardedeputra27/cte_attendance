import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Attendance {
  final String nik;
  final String name;
  const Attendance({
    required this.nik,
    required this.name,
  });

  factory Attendance.fromJson(Map<String, dynamic> data) {
    return Attendance(
      nik: data['error'],
      name: data['message'],
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
      children: <Widget>[
        FutureBuilder<Attendance>(
          future: futureAttendance,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data!.name),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
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
    final finalResponse = jsonDecode(response.body);
    //print(finalResponse);

    return Attendance.fromJson(finalResponse);
  } else {
    // If the server did not return a 200 OK response,
    throw Exception('Failed to load Employee Attendance');
  }
}
