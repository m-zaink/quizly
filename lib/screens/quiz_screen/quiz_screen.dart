// **
// Created by Mohammed Sadiq on 25/05/20.
// **

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:quizly/models/quiz_settings.dart';
import 'package:quizly/models/session.dart';
import 'package:quizly/screens/quiz_screen/quiz_bloc/bloc.dart';
import 'package:quizly/screens/quiz_screen/reusable_components/quiz_card.dart';
import 'package:super_hero/super_hero.dart';

class QuizScreen extends StatelessWidget {
  final QuizSettings quizSettings;

  QuizScreen({@required this.quizSettings});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizBloc>(
      create: (_) => QuizBloc(
        quizSettings: quizSettings,
        sessionToken: Provider.of<Session>(context).token,
      )..add(LoadQuizzesEvent()),
      child: Scaffold(
        appBar: appBar,
        body: body,
      ),
    );
  }

  Widget get appBar => AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) => IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            onPressed: () {
              if ([LoadingQuizState, QuizCompleteState]
                  .contains(state.runtimeType)) {
                Navigator.pop(context);
              } else {
                bool isFirstQuestion = state.runtimeType == ActiveQuizState &&
                    (state as ActiveQuizState).quiz.index == 0;
                !isFirstQuestion
                    ? BlocProvider.of<QuizBloc>(context).add(
                        PreviousQuestionEvent(),
                      )
                    : showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('You are about to quit'),
                          content: Text(
                            'Are you sure you want to quit this quiz?',
                          ),
                          actions: <Widget>[
                            OutlineButton(
                              child: Text('Yes'),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                            RaisedButton(
                              child: Text('No'),
                              onPressed: () {
                                BlocProvider.of<QuizBloc>(context)
                                    .add(PreviousQuestionEvent());
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      );
              }
            },
          ),
        ),
      );

  Widget get body => BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state.runtimeType == LoadingQuizState) {
            return progressIndicator;
          }

          if (state.runtimeType == ActiveQuizState) {
            return QuizCard(
              quiz: (state as ActiveQuizState).quiz,
            );
          }

          if (state.runtimeType == QuizCompleteState)
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 60.0,
              ),
              child: Card(
                color: Colors.orange,
                elevation: 10.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        SuperHero.random(),
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Score',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                '${(state as QuizCompleteState).userScore}',
                                style: TextStyle(
                                  fontSize: 58.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Text(
                            (state as QuizCompleteState).userScore ==
                                    (state as QuizCompleteState).totalScore
                                ? '🏆'
                                : '🎉',
                            style: TextStyle(fontSize: 80.0),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Total Score',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                '${(state as QuizCompleteState).totalScore}',
                                style: TextStyle(
                                  fontSize: 58.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.98,
                        child: FlatButton(
                          color: Colors.white,
                          textColor: Colors.orange,
                          hoverColor: Colors.orange[200],
                          padding: EdgeInsets.symmetric(
                            vertical: 15.0,
                          ),
                          child: Text('Retry'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

          return Center(
            child: Text('Something went wrong!'),
          );
        },
      );

  Widget get progressIndicator => Center(
        child: SpinKitWanderingCubes(
          color: Colors.orange,
        ),
      );
}
