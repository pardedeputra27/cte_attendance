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
            margin: const EdgeInsets.only(left: 5, right: 5, top: 7),
            elevation: 4,
            child: Table(
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: const Text(
                          'NIK',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.all(1),
                      child: Text(
                        ': ${snapshot.data!.nik}',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: const Text(
                        'Name',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Text(
                      ': ${snapshot.data!.name}',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: const Text(
                        'Job Position',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Text(': ${snapshot.data!.jabatan}',
                        style: const TextStyle(fontSize: 11)),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: const Text(
                        'Department',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Text(
                      ': ${snapshot.data!.department}',
                      style: const TextStyle(fontSize: 11),
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
