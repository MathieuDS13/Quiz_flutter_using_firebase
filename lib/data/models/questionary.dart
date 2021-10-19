import 'question.dart';

class Questionary {
  List<Question>? questions;
  String? category;
  int current = 0;

  Questionary.fromList(this.questions, this.category){
    questions!.shuffle();
  }

  Questionary() {
    questions = <Question>[];
    category = "N/A";
  }

  void addQuestion(Question question) {
    questions!.add(question);
  }

  bool getCorrectAnswer() {
    return questions![current].answer;
  }

  void getNextQuestion() {
    if (current < questions!.length - 1) {
      current++;
    } else {
      current = 0;
    }
  }

  String getQuestionText() {
    return questions![current].body;
  }
}
