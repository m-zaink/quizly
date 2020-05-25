// **
// Created by Mohammed Sadiq on 25/05/20.
// **

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly/models/quiz_settings.dart';
import 'package:quizly/reusable_components/web_aware_body/web_aware_body.dart';
import 'package:quizly/screens/quiz_screen/quiz_bloc/bloc.dart';

class QuizScreen extends StatelessWidget {
  final QuizSettings quizSettings;

  QuizScreen({@required this.quizSettings});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizBloc>(
      create: (context) => QuizBloc(quizSettings),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
        ),
        body: WebAwareBody(
          child: Center(
            child: Text('Question Screen'),
          ),
        ),
      ),
    );
  }
}
