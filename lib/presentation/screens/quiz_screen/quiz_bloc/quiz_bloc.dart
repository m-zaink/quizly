import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:quizly/domain/entities/quiz.dart';
import 'package:quizly/domain/entities/quiz_settings.dart';
import 'package:quizly/domain/repositories/quiz_repository.dart';
import 'package:quizly/utils/url_constructor/url_constructor.dart';
import './bloc.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  int currentQuizIndex = 0;
  List<String> userAnswers;
  final List<Quiz> quizzes = [];
  final QuizSettings quizSettings;
  final String sessionToken;
  final String url;

  QuizBloc({@required this.quizSettings, @required this.sessionToken})
      : url = URLConstructor.constructURL(
          settings: quizSettings,
          token: sessionToken,
        );

  @override
  QuizState get initialState => QuizLoadingState();

  @override
  Stream<QuizState> mapEventToState(
    QuizEvent event,
  ) async* {
    if (!kIsWeb) {
      Connectivity connectivity = Connectivity();
      ConnectivityResult connectivityResult =
          await connectivity.checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        yield QuizErrorState(
            'Uh oh. Looks like you aren\'t connected to the internet!');
        return;
      }
    }

    switch (event.runtimeType) {
      case LoadQuizzesEvent:
        currentQuizIndex = 0;
        quizzes.clear();
        yield QuizLoadingState();

        List<Quiz> quizzesFromRepo =
            await QuizRepository().fetchQuizzes(settings: quizSettings);

        if (quizzesFromRepo.isNotEmpty) {
          userAnswers = List.generate(quizzesFromRepo.length, (index) => '');
          quizzes.addAll(quizzesFromRepo);

          yield QuizActiveState(quiz: quizzes[currentQuizIndex]);
        } else {
          yield QuizErrorState('Sorry! Something went wrong...');
        }
        break;

      case NoteAnswerEvent:
        userAnswers[currentQuizIndex] = (event as NoteAnswerEvent).userAnswer;
        if (currentQuizIndex == quizzes.length - 1) {
          yield QuizCompleteState(
            totalScore: quizzes.length,
            userScore: userScore,
          );
        } else {
          yield QuizActiveState(quiz: quizzes[++currentQuizIndex]);
        }
        break;

      case PreviousQuestionEvent:
        if (currentQuizIndex > 0) {
          yield QuizActiveState(quiz: quizzes[--currentQuizIndex]);
        }
        break;
    }
  }

  int get userScore {
    int userScore = 0;
    for (int i = 0; i < quizzes.length; ++i)
      if (quizzes[i].rightAnswer == userAnswers[i]) ++userScore;
    return userScore;
  }
}
