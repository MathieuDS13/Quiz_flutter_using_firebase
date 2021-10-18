part of 'quiz_bloc.dart';

@immutable
abstract class QuizState {}

class QuizInitial extends QuizState {}

class CategoriesEmpty extends QuizState{}
class CategoriesLoading extends QuizState{}
class CategoriesLoaded extends QuizState {
  final List<String> categories;
  CategoriesLoaded(this.categories);
}
class CategoriesError extends QuizState{}

class QuestionsEmpty extends QuizState{}
class QuestionsLoading extends QuizState{}
class QuestionsLoaded extends QuizState {
  final Questionary questionary;
  QuestionsLoaded(this.questionary);
}
class QuestionsError extends QuizState{}


class AddQuestionError extends QuizState{}
class AddQuestionLoading extends QuizState{}
class AddQuestionsValidated extends QuizState {}
