import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SecondRoute extends StatefulWidget {
  final String nik;
  final String periode;
  const SecondRoute({Key? key, required this.nik, required this.periode})
      : super(key: key);

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: FutureBuilder(
        future: getAttendanceDataSource(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? SfDataGrid(source: snapshot.data, columns: getColumns())
              : const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                  ),
                );
        },
      )),
    );
  }
}

Future<AttendanceDataGridSource> getAttendanceDataSource() async {
  var attendanceList = await generateAttendanceList();
  return AttendanceDataGridSource(attendanceList);
}

List<GridColumn> getColumns() {
  return <GridColumn>[
    GridColumn(
      columnName: 'columnName1',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'Order',
          overflow: TextOverflow.clip,
          softWrap: true,
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName2',
      label: Container(
        alignment: Alignment.centerLeft,
        child: const Text(
          'Costumer',
          overflow: TextOverflow.clip,
          softWrap: true,
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName3',
      label: Container(
        alignment: Alignment.centerLeft,
        child: const Text(
          'Employee',
          overflow: TextOverflow.clip,
          softWrap: true,
        ),
      ),
    )
  ];
}

class AttendanceDataGridSource extends DataGridSource {
  late List<DataGridRow> dataGridRows;
  late List<Attendance> attendanceList;
  AttendanceDataGridSource(this.attendanceList) {
    buildDatagridRow();
  }
  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDatagridRow() {
    dataGridRows = attendanceList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'orderid', value: dataGridRow.orderID),
        DataGridCell(columnName: 'costumerid', value: dataGridRow.constumerID),
        DataGridCell(columnName: 'employeeid', value: dataGridRow.employeeID),
      ]);
    }).toList(growable: false);
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[0].value.toString(),
            overflow: TextOverflow.ellipsis),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(row.getCells()[1].value.toString(),
            overflow: TextOverflow.ellipsis),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(row.getCells()[2].value.toString(),
            overflow: TextOverflow.ellipsis),
      ),
    ]);
  }
}

Future<List<Attendance>> generateAttendanceList() async {
  final response = await http.get(
    Uri.parse(
        'https://ej2services.syncfusion.com/production/web-services/api/orders'),
  );
  final decodedAttendance =
      json.decode(response.body).cast<Map<String, dynamic>>();
  List<Attendance> attendanceList = await decodedAttendance
      .map<Attendance>((json) => Attendance.fromJson(json))
      .toList();
  return attendanceList;
}

class Attendance {
  final String orderID;
  final String constumerID;
  final String employeeID;
  Attendance({
    required this.orderID,
    required this.constumerID,
    required this.employeeID,
  });
  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      orderID: json['ShipName'],
      constumerID: json['CustomerID'],
      employeeID: json['ShipCity'],
    );
  }
}
