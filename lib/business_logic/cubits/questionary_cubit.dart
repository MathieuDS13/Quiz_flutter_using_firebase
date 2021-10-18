import 'package:bloc/bloc.dart';
import 'package:flutter_quiz_firebase/data/models/questionary.dart';
import 'package:meta/meta.dart';

part 'questionary_state.dart';

class QuestionaryCubit extends Cubit<QuestionaryState> {
  Questionary questionary;

  QuestionaryCubit(this.questionary) : super(QuestionaryInitial(questionary.getQuestionText()));

  void verifyQuestion(bool selectedAnswer) {
    bool goodAnswer = questionary.getCorrectAnswer();
    if (goodAnswer == selectedAnswer) {
      emit( const QuestionaryGoodAnswer());
      questionary.getNextQuestion();
      emit(QuestionaryChangeQuestion(questionary.getQuestionText()));
    } else {
      emit(QuestionaryBadAnswer(questionary.getQuestionText()));
    }
  }
}
