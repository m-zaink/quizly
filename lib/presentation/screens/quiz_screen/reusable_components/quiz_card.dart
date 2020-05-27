// **
// Created by Mohammed Sadiq on 25/05/20.
// **

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizly/domain/entities/quiz.dart';
import 'package:quizly/presentation/reusable_components/web_aware_body/web_aware_body.dart';
import 'package:quizly/presentation/screens/quiz_screen/quiz_bloc/bloc.dart';

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
        child: child,
      ),
    );
  }

  Widget get child => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          bubbleIcon,
          Card(
            elevation: 3.0,
            child: Container(
              constraints: BoxConstraints(
                minHeight: 500.0,
                maxHeight: 500.0,
              ),
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  quizDetails,
                  question,
                  options,
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          )
        ],
      );

  Widget get bubbleIcon => Icon(
        Icons.bubble_chart,
        color: Colors.orange,
        size: 120.0,
      );

  Widget get quizDetails => Row(
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
              quiz.difficulty.toFirstLetterCapitalized(),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      );

  Widget get question => Expanded(
        child: Center(
          child: Text(
            quiz.question,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 20,
            textAlign: TextAlign.center,
          ),
        ),
      );

  Widget get options => Column(
        children: [
          for (String text in quiz.options) ...[
            _buildOptionButton(title: text),
            SizedBox(height: 20.0),
          ],
        ],
      );

  Widget _buildOptionButton({
    @required String title,
  }) =>
      Builder(
        builder: (context) => OutlineButton(
          key: Key(title),
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

extension on String {
  String toFirstLetterCapitalized() {
    return this.isEmpty
        ? this
        : this[0].toUpperCase() + (this.length > 1 ? this.substring(1) : '');
  }
}
