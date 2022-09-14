import 'package:flutter/material.dart';
import '../controllers/employee.dart';

class DataEmployee extends StatelessWidget {
  const DataEmployee({Key? key, required this.futureEmployee})
      : super(key: key);

  final Future<Employee> futureEmployee;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Employee>(
      future: futureEmployee,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Card(
            margin: const EdgeInsets.only(left: 50, right: 50, top: 5),
            elevation: 4,
            child: Table(
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.all(1),
                        padding: const EdgeInsets.all(1),
                        child: const Text(
                          'NIK',
                          style: TextStyle(color: Colors.blue),
                        )),
                    Container(
                      margin: const EdgeInsets.all(1),
                      padding: const EdgeInsets.all(1),
                      child: Text(': ${snapshot.data!.nik}'),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(1),
                      padding: const EdgeInsets.all(1),
                      child: const Text(
                        'Name',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.all(2),
                      child: Text(': ${snapshot.data!.name}',
                          style: const TextStyle(color: Colors.purple)),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.all(2),
                      child: const Text(
                        'Job',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.all(2),
                        child: Text(': ${snapshot.data!.jabatan}')),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.all(2),
                      child: const Text(
                        'Department',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.all(2),
                      child: Text(': ${snapshot.data!.department}'),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(child: Text('Please wait..'));
      },
    );
  }
}
