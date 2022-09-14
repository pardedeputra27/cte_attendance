import 'package:flutter/material.dart';
import 'widget/form.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              Image.asset(
                'assets/icons/cte.ico',
                width: 45,
                height: 45,
                color: Colors.blue,
              ),
              const Spacer(flex: 1),
              const Text(
                'Citra Tubindo Engineering',
                style: TextStyle(
                    fontFamily: 'BlackParade',
                    letterSpacing: 3,
                    fontSize: 25,
                    color: Colors.white),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
        body: const MyForm(),
      ),
    );
  }
}
