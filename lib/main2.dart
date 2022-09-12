import 'package:cte_attendance/total.dart';
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
  late Future<Total> futureTotal;

  @override
  void initState() {
    super.initState();
    futureTotal = fetchTotal(widget.nik, widget.periode);
  }

  Future<AttendanceDataGridSource> getAttendanceDataSource() async {
    var attendanceList =
        await generateAttendanceList(widget.nik, widget.periode);
    return AttendanceDataGridSource(attendanceList);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('Your Detail ${widget.nik}'),
            ],
          ),
          leading: BackButton(
            color: Colors.black,
            onPressed: (() => Navigator.pop(context)),
          ),
        ),
        body: FutureBuilder(
          future: getAttendanceDataSource(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return SfDataGrid(
                source: snapshot.data,
                columns: getColumnsAttendance(),
                footerFrozenRowsCount: 1,
                footer: Container(
                  margin: const EdgeInsets.only(top: 9.0),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      FutureBuilder<Total>(
                        future: futureTotal,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text('Total Meal : '),
                                Text(snapshot.data!.totalMeal.toString()),
                                const Text('Total transport : '),
                                Text(snapshot.data!.totalTransport.toString()),
                                const Text('totalhours : '),
                                Text(snapshot.data!.totalHours),
                                const Text('Total Break : '),
                                Text(snapshot.data!.totalBreak),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          //return const CircularProgressIndicator();
                          return const Center(
                              child: Text('Please wait count total'));
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'Citra Tubindo Engineering',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                columnWidthMode: ColumnWidthMode.fill,
                //frozenColumnsCount: 1,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const Center(
                  child: Text('Please wait......',
                      style: TextStyle(fontSize: 25)));
            }
          },
        ),
      ),
    );
  }
}

List<GridColumn> getColumnsAttendance() {
  return <GridColumn>[
    GridColumn(
      columnName: 'columnName1',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'Date',
          softWrap: true,
          style: TextStyle(color: Colors.red),
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName2',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'Presence',
          softWrap: true,
          style: TextStyle(color: Colors.green),
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName3',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'Time In',
          softWrap: true,
          style: TextStyle(color: Colors.green),
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName4',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'Time Out',
          softWrap: true,
          style: TextStyle(color: Colors.green),
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName4',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'Information',
          softWrap: true,
          style: TextStyle(color: Colors.blueGrey),
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
        height: 3,
        alignment: Alignment.center,
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        height: 3,
        alignment: Alignment.center,
        child: Text(row.getCells()[1].value.toString(),
            overflow: TextOverflow.ellipsis),
      ),
      Container(
        height: 3,
        alignment: Alignment.center,
        child: Text(row.getCells()[2].value.toString(),
            overflow: TextOverflow.ellipsis),
      ),
      Container(
        height: 3,
        alignment: Alignment.center,
        child: Text(row.getCells()[3].value.toString(),
            overflow: TextOverflow.ellipsis),
      ),
      Container(
        height: 3,
        alignment: Alignment.center,
        child: Text(row.getCells()[4].value.toString(),
            overflow: TextOverflow.ellipsis),
      ),
    ]);
  }
}

Future<List<Attendance>> generateAttendanceList(nik, periode) async {
  final response = await http.get(
    Uri.parse(
        'http://192.168.40.14/ci-restserver-flutter/Get_attendance?nik=$nik&periode=$periode'),
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
