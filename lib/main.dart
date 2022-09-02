import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Employee> employees = <Employee>[];

  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    employees = getEmployees();
    employeeDataSource = EmployeeDataSource(employees: employees);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter DataGrid'),
        ),
        body: SfDataGrid(
          source: employeeDataSource,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'id',
                label: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'ID',
                  ),
                ),
                columnWidthMode: ColumnWidthMode.auto),
            GridColumn(
                columnName: 'name',
                label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text('Name'))),
            GridColumn(
                columnName: 'designation',
                width: 120,
                label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text('Designation'))),
            GridColumn(
                columnName: 'salary',
                label: Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.centerRight,
                    child: const Text('Salary'))),
          ],
        ),
      ),
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    _employees = employees
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
            ]))
        .toList();
  }

  List<DataGridRow> _employees = [];

  @override
  List<DataGridRow> get rows => _employees;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'id' ||
                dataGridCell.columnName == 'salary')
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}

List<Employee> getEmployees() {
  return [
    Employee(10001, 'James', 'Project Lead', 20000),
    Employee(10002, 'Kathryn', 'Manager', 30000),
    Employee(10003, 'Lara', 'Developer', 15000),
    Employee(10004, 'Michael', 'Designer', 15000),
    Employee(10005, 'Martin', 'Developer', 15000),
    Employee(10006, 'Newberry', 'Developer', 15000),
    Employee(10007, 'Balnc', 'Developer', 15000),
    Employee(10008, 'Perry', 'Developer', 15000),
    Employee(10009, 'Gable', 'Developer', 15000),
    Employee(10010, 'Grimes', 'Developer', 15000)
  ];
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  final int id;
  final String name;
  final String designation;
  final int salary;
}
