// **
// Created by Mohammed Sadiq on 25/05/20.
// **

import 'package:meta/meta.dart';

import 'package:quizly/models/quiz.dart';
import 'package:quizly/models/quiz_settings.dart';
import 'package:quizly/utils/url_constructor/url_constructor.dart';

abstract class QuizRepository {
  Future<Quiz> fetchQuizzes({@required QuizSettings settings});
}

class QuizRepositoryImpl implements QuizRepository {
  @override
  Future<Quiz> fetchQuizzes({QuizSettings settings}) async {
    String url = URLConstructor.constructURL(settings);

    try {
      // TODO: Make HTTP calls here
    } catch (e) {}
  }
}
