import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ExamApp());
}
class ExamApp extends StatelessWidget {
  const ExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Распоред за испити',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ExamListScreen(),
    );
  }
}
