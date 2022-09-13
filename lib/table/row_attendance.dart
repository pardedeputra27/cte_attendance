import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../controllers/attendance.dart';

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
