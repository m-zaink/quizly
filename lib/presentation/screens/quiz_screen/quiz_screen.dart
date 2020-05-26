// **
// Created by Mohammed Sadiq on 25/05/20.
// **

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:super_hero/super_hero.dart';

import 'package:quizly/domain/entities/quiz.dart';
import 'package:quizly/domain/entities/quiz_settings.dart';
import 'package:quizly/domain/entities/session.dart';
import 'package:quizly/presentation/screens/quiz_screen/quiz_bloc/bloc.dart';
import 'package:quizly/presentation/screens/quiz_screen/reusable_components/quiz_card.dart';
import 'package:quizly/presentation/reusable_components/web_aware_body/web_aware_body.dart';

class QuizScreen extends StatelessWidget {
  final QuizSettings quizSettings;

  QuizScreen({@required this.quizSettings});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizBloc>(
      create: (_) => QuizBloc(
        quizSettings: quizSettings,
        sessionToken: Provider.of<Session>(context).token,
      )..add(
          LoadQuizzesEvent(),
        ),
      child: WillPopScope(
        onWillPop: () {
          onBackPressed(context);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: appBar,
          body: WebAwareBody(
            child: body,
          ),
        ),
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
            onPressed: () => onBackPressed(context),
          ),
        ),
      );

  void onBackPressed(BuildContext context) {
    QuizState state = BlocProvider.of<QuizBloc>(context).state;
    bool quizIsLoadingOrCompleted = [
      QuizLoadingState,
      QuizCompleteState,
      QuizErrorState
    ].contains(state.runtimeType);

    if (quizIsLoadingOrCompleted) {
      Navigator.pop(context);
    } else {
      bool isNotFirstQuestion = !(state.runtimeType == ActiveQuizState &&
          (state as ActiveQuizState).quiz.index == 0);

      if (isNotFirstQuestion) {
        BlocProvider.of<QuizBloc>(context).add(
          PreviousQuestionEvent(),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => aboutToQuitAlertDialog,
        );
      }
    }
  }

  Widget get aboutToQuitAlertDialog => Builder(
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          title: Text('You are about to quit!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Are you sure you want to do that?',
              ),
              SizedBox(
                height: 20.0,
              ),
              aboutToQuitAlertDialogOptions
            ],
          ),
        ),
      );

  Widget get aboutToQuitAlertDialogOptions => Builder(
        builder: (context) => Row(
          children: [
            Expanded(
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      );

  Widget get body => BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state.runtimeType == QuizLoadingState) {
            return progressIndicator;
          }

          if (state.runtimeType == ActiveQuizState) {
            Quiz quiz = (state as ActiveQuizState).quiz;
            return QuizCard(quiz: quiz);
          }

          if (state.runtimeType == QuizCompleteState) return quizCompleteCard;

          return somethingWentWrong;
        },
      );

  Widget get progressIndicator => Center(
        child: SpinKitWanderingCubes(
          color: Colors.orange,
        ),
      );

  Widget get quizCompleteCard => Builder(
        builder: (context) => Container(
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
                vertical: 30.0,
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
                  scoreDetails,
                  SizedBox(
                    height: 20.0,
                  ),
                  retryCTA,
                ],
              ),
            ),
          ),
        ),
      );

  Widget get scoreDetails => Builder(
        builder: (context) {
          QuizCompleteState state =
              BlocProvider.of<QuizBloc>(context).state as QuizCompleteState;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildScoreColumn(
                title: 'Your Score',
                score: state.userScore,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              Text(
                state.userScore == state.totalScore ? '🏆' : '🎉',
                style: TextStyle(fontSize: 80.0),
              ),
              _buildScoreColumn(
                title: 'Total Score',
                score: state.totalScore,
                crossAxisAlignment: CrossAxisAlignment.end,
              )
            ],
          );
        },
      );

  Widget _buildScoreColumn(
          {@required String title,
          @required int score,
          @required CrossAxisAlignment crossAxisAlignment}) =>
      Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            '${score}',
            style: TextStyle(
              fontSize: 58.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        ],
      );

  Widget get retryCTA => Builder(
        builder: (context) => FractionallySizedBox(
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
              BlocProvider.of<QuizBloc>(context).add(
                LoadQuizzesEvent(),
              );
            },
          ),
        ),
      );

  Widget get somethingWentWrong => Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            errorDetailsCard,
            letsGoBackCTA,
          ],
        ),
      );

  Widget get errorDetailsCard => Builder(
        builder: (context) => Card(
          color: Colors.indigo,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
//                  (BlocProvider.of<QuizBloc>(context)?.state as QuizErrorState)
//                          .error ??
                  'Sorry. Something went wrong...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                CircleAvatar(
                  minRadius: 20.0,
                  child: Image.asset(
                    'images/confused_boy.png',
                    height: 300.0,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
        ),
      );

  Widget get letsGoBackCTA => Builder(
        builder: (context) => FlatButton(
          splashColor: Colors.transparent,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.arrow_back,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Let\'s go back!',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          onPressed: () => Navigator.pop(context),
        ),
      );
}
