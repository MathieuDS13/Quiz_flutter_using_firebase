part of 'quiz_bloc.dart';

@immutable
abstract class QuizEvent {}

class FetchQuestionEvent extends QuizEvent{
  final String category;

  FetchQuestionEvent(this.category);
}

class FetchCategoriesEvent extends QuizEvent{}

class AddQuestionEvent extends QuizEvent {
  final Question question;
  final String category;
  AddQuestionEvent(this.question, this.category);
}
