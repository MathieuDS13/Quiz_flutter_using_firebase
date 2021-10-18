part of 'questionary_cubit.dart';

@immutable
abstract class QuestionaryState {
  const QuestionaryState();
}

class QuestionaryInitial extends QuestionaryState {
  final String questionText;

  const QuestionaryInitial(this.questionText);
}

class QuestionaryChangeQuestion extends QuestionaryState {
  final String newQuestionText;

  const QuestionaryChangeQuestion(this.newQuestionText);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionaryChangeQuestion &&
          runtimeType == other.runtimeType &&
          newQuestionText == other.newQuestionText;

  @override
  int get hashCode => newQuestionText.hashCode;
}

class QuestionaryVerifyQuestion extends QuestionaryState {
  const QuestionaryVerifyQuestion();
}

class QuestionaryGoodAnswer extends QuestionaryState {
  const QuestionaryGoodAnswer();
}

class QuestionaryBadAnswer extends QuestionaryState {
  final String questionShow;

  const QuestionaryBadAnswer(this.questionShow);
}
