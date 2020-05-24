import 'package:flutter/material.dart';
import 'package:quizly/screens/home_screen/home_screen.dart';

void main() => runApp(QuizlyApp());

class QuizlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: HomeScreen(),
    );
  }

  ThemeData get theme => ThemeData(
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(),
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
