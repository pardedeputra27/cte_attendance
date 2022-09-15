import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

import '../main2.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, dynamic>> _selectPeriode = [
    {
      'value': 1,
      'label': 'January',
    },
    {
      'value': 2,
      'label': 'February',
    },
    {
      'value': 3,
      'label': 'March',
    },
    {
      'value': 4,
      'label': 'April',
    },
    {
      'value': 5,
      'label': 'May',
    },
    {
      'value': 6,
      'label': 'June',
    },
    {
      'value': 7,
      'label': 'July',
    },
    {
      'value': 8,
      'label': 'August',
    },
    {
      'value': 9,
      'label': 'September',
    },
    {
      'value': 10,
      'label': 'Oktober',
    },
    {
      'value': 11,
      'label': 'November',
    },
    {
      'value': 12,
      'label': 'December',
    },
    {
      'value': -1,
      'label': 'January (Last Year)',
    },
    {
      'value': -2,
      'label': 'February (Last Year)',
    },
    {
      'value': -3,
      'label': 'March (Last Year)',
    },
    {
      'value': -4,
      'label': 'April (Last Year)',
    },
    {
      'value': -5,
      'label': 'May (Last Year)',
    },
    {
      'value': -6,
      'label': 'June (Last Year)',
    },
    {
      'value': -7,
      'label': 'July (Last Year)',
    },
    {
      'value': -8,
      'label': 'August (Last Year)',
    },
    {
      'value': -9,
      'label': 'September (Last Year)',
    },
    {
      'value': -10,
      'label': 'Oktober (Last Year)',
    },
    {
      'value': -11,
      'label': 'November (Last Year)',
    },
    {
      'value': -12,
      'label': 'December(Last Year)',
    },
  ];
  TextEditingController nikController = TextEditingController();
  TextEditingController periodeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nikController.dispose();
    periodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.account_circle_rounded,
                      color: Colors.cyan,
                    ),
                    Text(
                      'CTE Employee Attendance ',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              TextFormField(
                maxLength: 10,
                controller: nikController,
                style: const TextStyle(fontFamily: 'oohBaby', letterSpacing: 2),
                decoration: const InputDecoration(
                  icon: Icon(Icons.person, color: Colors.blue),
                  hintText: 'Enter Your NIK....',
                  labelText: 'NIK',
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIK cannot be empty';
                  }
                  return null;
                },
              ),
              SelectFormField(
                controller: periodeController,
                style: const TextStyle(fontFamily: 'oohBaby', letterSpacing: 2),
                enableSearch: true,
                dialogCancelBtn: 'Close',
                dialogTitle: 'Select Period',
                type: SelectFormFieldType.dialog, // or can be dialog
                icon: const Icon(
                  Icons.date_range,
                  color: Colors.blue,
                ),
                labelText: '---Select Period---',
                items: _selectPeriode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please selected one';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton.icon(
                  onPressed: () {
                    final key = _formKey.currentState;
                    final nikValue = nikController.text;
                    final periodeValue = periodeController.text;
                    if (key!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailAttendance(
                            nik: nikValue,
                            periode: periodeValue,
                          ),
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.lightGreen)),
                  icon: const Icon(
                    Icons.add_to_home_screen,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
