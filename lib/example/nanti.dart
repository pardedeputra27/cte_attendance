import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Citra Tubindo Engineering';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // primarySwatch: Colors.cyan,
          ),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text(appTitle)],
          ),
        ),
        body: const MyForm(),
      ),
    );
  }
}

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
      'label': 'Januari',
    },
    {
      'value': 2,
      'label': 'February',
    },
    {
      'value': 3,
      'label': 'Maret',
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
                  children: <Widget>[
                    Image.asset('assets/icons/cte.ico', width: 45, height: 45),
                    const Text(
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
                controller: nikController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
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
                type: SelectFormFieldType.dropdown, // or can be dialog
                icon: const Icon(Icons.date_range),
                labelText: 'Please select periode',
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
                    if (key!.validate()) {
                      // print(nikController.text);
                      // print(periodeController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SecondRoute()));
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.lightGreen)),
                  icon: const Icon(Icons.add_to_home_screen),
                  label: const Text('SUBMIT'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Attendance Detail'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            ' My Code in Here \n Go back!',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
