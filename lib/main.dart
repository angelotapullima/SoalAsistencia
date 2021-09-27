import 'package:flutter/material.dart';
import 'package:soal/pages/ajustes.dart';
import 'package:soal/pages/asistencia.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SOAL - PROONIX',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Asistencia(),
        initialRoute: 'home',
        routes: {
          '/home': (BuildContext context) => Asistencia(),
          '/ajustes': (BuildContext context) => Ajustes(),
        });
  }
}
