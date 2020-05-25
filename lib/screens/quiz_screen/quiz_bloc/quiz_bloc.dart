import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:quizly/models/quiz.dart';
import 'package:quizly/models/quiz_settings.dart';
import 'package:quizly/utils/url_constructor/url_constructor.dart';
import './bloc.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final List<Quiz> quizzes = [];
  final QuizSettings quizSettings;
  final String url;

  QuizBloc(this.quizSettings) : url = URLConstructor.constructURL(quizSettings);

  @override
  QuizState get initialState => InitialQuizState();

  @override
  Stream<QuizState> mapEventToState(
    QuizEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
