import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:quizly/models/quiz.dart';
import 'package:quizly/models/quiz_settings.dart';
import 'package:quizly/repositories/quiz_repository/quiz_repository.dart';
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
  QuizState get initialState => LoadingQuizState();

  @override
  Stream<QuizState> mapEventToState(
    QuizEvent event,
  ) async* {
    if (event.runtimeType == LoadQuizzesEvent) {
      yield LoadingQuizState();
      List<Quiz> quizzesFromRepo =
          await QuizRepository().fetchQuizzes(settings: quizSettings);
      if (quizzesFromRepo.isNotEmpty) {
        userAnswers = List.generate(quizzesFromRepo.length, (index) => '');
        quizzes.addAll(quizzesFromRepo);
        yield ActiveQuizState(quiz: quizzes[currentQuizIndex]);
      } else {
        yield QuizErrorState('Something went wrong!');
      }
    }

    if (event.runtimeType == NoteAnswerEvent) {
      userAnswers[currentQuizIndex] = (event as NoteAnswerEvent).userAnswer;
      if (currentQuizIndex == quizzes.length - 1) {
        yield QuizCompleteState(
          totalScore: quizzes.length,
          userScore: userScore,
        );
      } else {
        yield ActiveQuizState(quiz: quizzes[++currentQuizIndex]);
      }
    }

    if (event.runtimeType == PreviousQuestionEvent && currentQuizIndex > 0) {
      yield ActiveQuizState(quiz: quizzes[--currentQuizIndex]);
    }
  }

  int get userScore {
    int userScore = 0;
    for (int i = 0; i < quizzes.length; ++i)
      if (quizzes[i].rightAnswer == userAnswers[i]) ++userScore;
    return userScore;
  }
}
