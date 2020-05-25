import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quizly/models/quiz.dart';

abstract class QuizEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadQuizzesEvent extends QuizEvent {}

class NoteAnswerEvent extends QuizEvent {
  final String userAnswer;

  NoteAnswerEvent({
    @required this.userAnswer,
  });
}

class PreviousQuestionEvent extends QuizEvent {}
