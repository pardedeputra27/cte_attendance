import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

List<GridColumn> getColumnsAttendance() {
  return <GridColumn>[
    GridColumn(
      columnWidthMode: ColumnWidthMode.auto,
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
          'Meal',
          softWrap: true,
          style: TextStyle(color: Colors.green),
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName6',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'Trans',
          softWrap: true,
          style: TextStyle(color: Colors.green),
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName7',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'Hours',
          softWrap: true,
          style: TextStyle(color: Colors.green),
        ),
      ),
    ),
    GridColumn(
      columnName: 'columnName8',
      label: Container(
        alignment: Alignment.center,
        child: const Text(
          'Break',
          softWrap: true,
          style: TextStyle(color: Colors.green),
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
