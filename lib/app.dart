import 'package:flutter/material.dart';
import 'package:latexunit/views/app_home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latex Unit',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: AppHome(),
    );
  }
}