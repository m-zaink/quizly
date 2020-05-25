import 'package:equatable/equatable.dart';

abstract class QuizState extends Equatable {
  const QuizState();
}

class InitialQuizState extends QuizState {
  @override
  List<Object> get props => [];
}
