import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_firebase/business_logic/blocs/quiz_bloc.dart';
import 'package:flutter_quiz_firebase/presentation/pages/category_selection_page.dart';

import 'add_question_page.dart';

class QuizHomePage extends StatelessWidget {
  const QuizHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizBloc>(
      create: (BuildContext context) => QuizBloc(QuizInitial()),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Firebased Quiz"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [ButtonAddQuestion(), ButtonGoToCategory()],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonGoToCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
              300, 50), // double.infinity is the width and 30 is the height
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<QuizBloc>(context),
                      child: CategorySelectionPage())));
        },
        child: Text("Categories",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class ButtonAddQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
              300, 50), // double.infinity is the width and 30 is the height
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<QuizBloc>(context),
                      child: AddQuestionPage())));
        },
        child: Text("Create Question",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
