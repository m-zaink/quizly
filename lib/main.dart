import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizly/presentation/screens/home_screen/home_screen.dart';
import 'package:uuid/uuid.dart';

import 'domain/entities/session.dart';

void main() => runApp(QuizlyApp());

class QuizlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Session>(
      create: (context) => Session(token: Uuid().v1()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: HomeScreen(),
      ),
    );
  }

  ThemeData get theme => ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(),
        ),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
      );
}
