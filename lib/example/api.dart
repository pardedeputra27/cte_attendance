import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Attendance> fetchAttendance() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/2'));

  if (response.statusCode == 200) {
    return Attendance.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    throw Exception('Failed to load album');
  }
}

class Attendance {
  final int userId;
  final int id;
  final String title;

  const Attendance({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Attendance.fromJson(Map<String, dynamic> data) {
    return Attendance(
      userId: data['userId'],
      id: data['id'],
      title: data['title'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Attendance> futureAttendance;

  @override
  void initState() {
    super.initState();
    futureAttendance = fetchAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Attendance'),
        ),
        body: Center(
          child: FutureBuilder<Attendance>(
            future: futureAttendance,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
