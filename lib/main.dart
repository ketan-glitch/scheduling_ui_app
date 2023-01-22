import 'package:flutter/material.dart';
import 'package:scheduling_ui_app/views/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0XFF0f036b),
      ),
      home: const SplashScreen(),
    );
  }
}
