import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Employee {
  final String nik;
  final String name;
  final String department;
  final String jabatan;
  Employee({
    required this.nik,
    required this.name,
    required this.department,
    required this.jabatan,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      nik: json['nik'],
      name: json['name'],
      department: json['department'],
      jabatan: json['jabatan'],
    );
  }
}

Future<Employee> fetchEmployee(nik, periode) async {
  String apiUrl =
      'http://192.168.40.14/ci-restserver-flutter/Get_attendance?nik=$nik&periode=$periode';
  final apiResult = await http.get(Uri.parse(apiUrl));
  final jsonObject = jsonDecode(apiResult.body)['data'];
  return Employee.fromJson(jsonObject[0]);
}
