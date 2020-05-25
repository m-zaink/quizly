// **
// Created by Mohammed Sadiq on 25/05/20.
// **

import 'package:quizly/models/quiz_settings.dart';

class URLConstructor {
  static String constructURL(QuizSettings settings) {
    String url =
        'https://opentdb.com/api.php?amount=${settings.numberOfQuestions}';
    if (settings.category != Category.any) {
      url += '&category=${settings.category.index + 10}';
    }

    if (settings.questionType != QuestionType.any) {
      url += '&type=';
      if (settings.questionType == QuestionType.multipleChoice)
        url += 'multiple';
      if (settings.questionType == QuestionType.trueOfFalse) url += 'boolean';
    }

    if (settings.difficulty != Difficulty.any) {
      url += '&difficulty=';
      if (settings.difficulty == Difficulty.easy) url += 'easy';
      if (settings.difficulty == Difficulty.medium) url += 'medium';
      if (settings.difficulty == Difficulty.hard) url += 'hard';
    }

    return url;
  }
}
