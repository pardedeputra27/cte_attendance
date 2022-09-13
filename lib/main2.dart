import 'controllers/attendance.dart';
import 'controllers/total.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

//Table
import 'table/column_attendance.dart';
import 'table/row_attendance.dart';

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
