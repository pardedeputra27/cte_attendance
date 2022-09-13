import 'controllers/attendance.dart';
import 'controllers/total.dart';
import 'package:flutter/material.dart';
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
                columnWidthMode: ColumnWidthMode.none,
                //frozenColumnsCount: 1,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                footerFrozenRowsCount: 1,
                footer: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        alignment: Alignment.centerLeft,
                        child: FutureBuilder<Total>(
                          future: futureTotal,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Total :'),
                                  const Spacer(flex: 1),
                                  Text(
                                      'Meal : ${snapshot.data!.totalMeal.toString()} Transport : ${snapshot.data!.totalTransport.toString()} hours : ${snapshot.data!.totalHours} break : ${snapshot.data!.totalBreak}'),
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
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        alignment: Alignment.bottomRight,
                        child: const Text(
                          'Citra Tubindo Engineering',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                              color: Colors.blueGrey),
                        ),
                      ),
                    ],
                  ),
                ),
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
      columnName: 'columnName5',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'meal',
          softWrap: true,
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName6',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'transport',
          softWrap: true,
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName7',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'hours',
          softWrap: true,
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName8',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'break',
          softWrap: true,
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName8',
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
        DataGridCell(columnName: 'rowName5', value: dataGridRow.meal),
        DataGridCell(columnName: 'rowName6', value: dataGridRow.transport),
        DataGridCell(columnName: 'rowName7', value: dataGridRow.hours),
        DataGridCell(columnName: 'rowName8', value: dataGridRow.istirahat),
        DataGridCell(columnName: 'rowName9', value: dataGridRow.absent),
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
      Container(
        height: 3,
        alignment: Alignment.center,
        child: Text(row.getCells()[5].value.toString(),
            overflow: TextOverflow.ellipsis),
      ),
      Container(
        height: 3,
        alignment: Alignment.center,
        child: Text(row.getCells()[6].value.toString(),
            overflow: TextOverflow.ellipsis),
      ),
      Container(
        height: 3,
        alignment: Alignment.center,
        child: Text(row.getCells()[7].value.toString(),
            overflow: TextOverflow.ellipsis),
      ),
      Container(
        height: 3,
        alignment: Alignment.center,
        child: Text(row.getCells()[8].value.toString(),
            overflow: TextOverflow.ellipsis),
      ),
    ]);
  }
}
