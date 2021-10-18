import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_quiz_firebase/data/dataproviders/data_retriever.dart';
import 'package:flutter_quiz_firebase/data/models/question.dart';
import 'package:flutter_quiz_firebase/data/models/questionary.dart';
import 'package:meta/meta.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  DataRetriever retriever = DataRetriever();

  QuizBloc(QuizState initialState) : super(initialState);

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    if (event is FetchQuestionEvent) {
      try {
        yield QuestionsLoading();
        var res = await retriever.getQuestionary(category: event.category);
        yield QuestionsLoaded(res);
      } catch (_) {
        yield QuestionsError();
      }
    }

    if (event is FetchCategoriesEvent) {
      try {
        yield CategoriesLoading();
        var res = await retriever.getCategories();
        yield CategoriesLoaded(res);
      } catch (_) {
        yield CategoriesError();
      }
    }

    if (event is AddQuestionEvent) {
      try {
        yield AddQuestionLoading();
        await retriever.addQuestion(
            category: event.category, question: event.question);
        yield AddQuestionsValidated();
      } catch (_) {
        yield AddQuestionError();
      }
    }
  }

  Future<List<String>> getCategories() {
    return retriever.getCategories();
  }

  Future<Questionary> getQuestionary(String category) {
    return retriever.getQuestionary(category: category);
  }
}
