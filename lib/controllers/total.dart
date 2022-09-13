import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Total {
  final int totalMeal;
  final int totalTransport;
  final String totalHours;
  final String totalBreak;

  Total({
    required this.totalMeal,
    required this.totalTransport,
    required this.totalHours,
    required this.totalBreak,
  });

  factory Total.fromJson(Map<String, dynamic> json) {
    return Total(
        totalMeal: json['total_meal'],
        totalTransport: json['total_transport'],
        totalHours: json['total_hours'],
        totalBreak: json['total_break']);
  }
}

Future<Total> fetchTotal(nik, periode) async {
  String apiUrl =
      'http://192.168.40.14/ci-restserver-flutter/Get_attendance?nik=$nik&periode=$periode';
  final apiResult = await http.get(Uri.parse(apiUrl));
  final jsonObject = jsonDecode(apiResult.body)['total'];
  //print(jsonObject);
  return Total.fromJson(jsonObject[0]);
}
