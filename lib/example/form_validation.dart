import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Citra Tubindo Engineering';
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.red,
          iconTheme: const IconThemeData(color: Colors.blue)),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text(appTitle)),
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
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter Your NIK :',
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
              TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.date_range), labelText: 'Start Date'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Date cannot be empty';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    icon: const Icon(Icons.edit_note),
                    label: const Text('SUBMIT')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
