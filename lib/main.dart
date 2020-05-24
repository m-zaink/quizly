import 'package:flutter/material.dart';

void main() => runApp(QuizlyApp());

class QuizlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quizly'),
        ),
        body: Center(
          child: Text('Quizly'),
        ),
      ),
    );
  }
}
