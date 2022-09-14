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
      department: json['department_label'],
      jabatan: json['position_label'],
    );
  }
}

Future<Employee> fetchEmployee(nik) async {
  String apiUrl =
      'http://192.168.40.14/ci-restserver-flutter/Get_employee?nik=$nik';
  final apiResult = await http.get(Uri.parse(apiUrl));
  final jsonObject = jsonDecode(apiResult.body);
  return Employee.fromJson(jsonObject[0]);
}
