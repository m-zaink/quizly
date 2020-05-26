import 'package:equatable/equatable.dart';
import 'package:quizly/domain/entities/quiz.dart';
import 'package:meta/meta.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizLoadingState extends QuizState {}

class ActiveQuizState extends QuizState {
  final Quiz quiz;

  ActiveQuizState({
    @required this.quiz,
  });

  @override
  List<Object> get props => [quiz.index];
}

class QuizCompleteState extends QuizState {
  final int totalScore, userScore;

  QuizCompleteState({
    @required this.totalScore,
    @required this.userScore,
  });

  @override
  List<Object> get props => [totalScore, userScore];
}

class QuizErrorState extends QuizState {
  final String error;

  QuizErrorState(this.error);

  @override
  List<Object> get props => [error];
}
