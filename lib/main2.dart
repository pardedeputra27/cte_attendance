import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DetailAttendance extends StatefulWidget {
  final String nik;
  final String periode;
  const DetailAttendance({Key? key, required this.nik, required this.periode})
      : super(key: key);

  @override
  State<DetailAttendance> createState() => _DetailAttendanceState();
}

class _DetailAttendanceState extends State<DetailAttendance> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Your Detail ${widget.nik}'),
            leading: BackButton(
              color: Colors.black,
              onPressed: (() => Navigator.pop(context)),
            ),
          ),
          body: FutureBuilder(
            future: getAttendanceDataSource(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? SfDataGrid(
                      source: snapshot.data,
                      columns: getColumns(),
                      //frozenColumnsCount: 1,
                    )
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
          'Date',
          overflow: TextOverflow.clip,
          softWrap: true,
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName2',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'Presence',
          overflow: TextOverflow.clip,
          softWrap: true,
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName3',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'Time In',
          overflow: TextOverflow.clip,
          softWrap: true,
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName4',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'Time Out',
          overflow: TextOverflow.clip,
          softWrap: true,
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName4',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'Absent',
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
        //columnName itu tidak terlalu memperngaruhi Table
        DataGridCell(columnName: 'rowName1', value: dataGridRow.date),
        DataGridCell(columnName: 'rowName2', value: dataGridRow.dateIn),
        DataGridCell(columnName: 'rowName3', value: dataGridRow.timeIn),
        DataGridCell(columnName: 'rowName4', value: dataGridRow.timeOut),
        DataGridCell(columnName: 'rowName5', value: dataGridRow.absent),
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
        alignment: Alignment.center,
        child: Text(row.getCells()[1].value.toString(),
            overflow: TextOverflow.ellipsis),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[2].value.toString(),
            overflow: TextOverflow.ellipsis),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[3].value.toString(),
            overflow: TextOverflow.ellipsis),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[4].value.toString(),
            overflow: TextOverflow.ellipsis),
      ),
    ]);
  }
}

Future<List<Attendance>> generateAttendanceList() async {
  final response = await http.get(
    Uri.parse(
        'http://192.168.40.14/ci-restserver-master/Get_attendance?nik=2203725&periode=4'),
  );
  final decodedAttendance =
      json.decode(response.body)['data'].cast<Map<String, dynamic>>();
  List<Attendance> attendanceList = await decodedAttendance
      .map<Attendance>((json) => Attendance.fromJson(json))
      .toList();
  return attendanceList;
}

class Attendance {
  final String date;
  final String dateIn;
  final String timeIn;
  final String timeOut;
  final String absent;
  Attendance({
    required this.date,
    required this.dateIn,
    required this.timeIn,
    required this.timeOut,
    required this.absent,
  });
  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      date: json['date'],
      dateIn: json['date_in'],
      timeIn: json['time_in'],
      timeOut: json['time_out'],
      absent: json['absent'],
    );
  }
}
