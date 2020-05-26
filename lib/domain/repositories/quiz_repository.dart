// **
// Created by Mohammed Sadiq on 25/05/20.
// **

import 'package:meta/meta.dart';

import 'package:quizly/domain/entities/quiz.dart';
import 'package:quizly/domain/entities/quiz_settings.dart';
import 'package:quizly/data/repositories/quiz_repository_impl.dart';

abstract class QuizRepository {
  factory QuizRepository() {
    return QuizRepositoryImpl();
  }

  Future<List<Quiz>> fetchQuizzes({@required QuizSettings settings});
}
