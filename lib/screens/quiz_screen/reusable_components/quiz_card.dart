// **
// Created by Mohammed Sadiq on 25/05/20.
// **

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly/models/quiz.dart';
import 'package:quizly/models/quiz_settings.dart';
import 'package:quizly/reusable_components/web_aware_body/web_aware_body.dart';
import 'package:quizly/screens/quiz_screen/quiz_bloc/bloc.dart';

class QuizCard extends StatelessWidget {
  final Quiz quiz;

  const QuizCard({
    Key key,
    @required this.quiz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebAwareBody(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: content,
      ),
    );
  }

  Widget get content => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          bubbleIcon,
          Card(
            elevation: 3.0,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          quiz.category,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${quiz.index + 1}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          quiz.difficulty,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    quiz.question,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 20,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  for (String text in quiz.options) ...[
                    _buildOptionButton(title: text),
                    SizedBox(height: 20.0),
                  ],
                ],
              ),
            ),
          ),
        ],
      );

  Widget get bubbleIcon => Icon(
        Icons.bubble_chart,
        color: Colors.orange,
        size: 120.0,
      );

  Widget _buildOptionButton({
    @required String title,
  }) =>
      Builder(
        builder: (context) => OutlineButton(
          highlightedBorderColor: Colors.orange,
          splashColor: Colors.orange[100],
          hoverColor: Colors.white,
          child: ListTile(
            contentPadding: EdgeInsets.all(0.0),
            leading: Icon(
              Icons.fiber_manual_record,
              color: Colors.orange,
            ),
            title: Text(title),
          ),
          onPressed: () {
            BlocProvider.of<QuizBloc>(context).add(
              NoteAnswerEvent(
                userAnswer: title,
              ),
            );
          },
        ),
      );
}
