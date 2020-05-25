// **
// Created by Mohammed Sadiq on 25/05/20.
// **
import 'package:meta/meta.dart';
import 'package:quizly/models/quiz_settings.dart';

class Quiz {
  final int index;
  final String question;
  final String rightAnswer;
  final List<String> wrongAnswers;
  final Difficulty difficulty;
  final Category category;
  final QuestionType questionType;

  Quiz({
    @required this.index,
    @required this.question,
    @required this.rightAnswer,
    @required this.wrongAnswers,
    @required this.category,
    @required this.difficulty,
    @required this.questionType,
  });

  List<String> get options {
    List<String> options = [rightAnswer, ...wrongAnswers];
    options.shuffle();
    return options;
  }
}
