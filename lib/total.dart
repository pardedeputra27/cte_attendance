import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<Total>> generateTotalList(nik, peride) async {
  final response = await http.get(Uri.parse(
      'http://192.168.40.14/ci-restserver-flutter/Get_attendance?nik=$nik&periode=$peride'));
  final decodedTotal =
      json.decode(response.body)['data'].cast<Map<String, dynamic>>();
  List<Total> totalList =
      await decodedTotal.map<Total>((json) => Total.fromJson(json)).toList();
  return totalList;
}

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
        totalMeal: json['totalMeal'],
        totalTransport: json['totalTransport'],
        totalHours: json['totalHours'],
        totalBreak: json['totalBreak']);
  }
}
