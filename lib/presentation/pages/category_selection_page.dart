import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_firebase/business_logic/blocs/quiz_bloc.dart';
import 'package:flutter_quiz_firebase/presentation/pages/questionary_page.dart';

class CategorySelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<List<String>> future =
        BlocProvider.of<QuizBloc>(context).retriever.getCategories();
    return FutureBuilder<List<String>>(
        future: future, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = snapshot.data!
                .map((e) => getWidgetFromName(e, context))
                .toList();
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting data...'),
              )
            ];
          }
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ));
        });
  }

  Widget getWidgetFromName(String category, BuildContext context) {
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
                        child: QuestionaryPage(category: category))));
          },
          child: Text(category,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold)),
        ));
  }
}
//CarouselSlider(items: BlocProvider.of<QuizBloc>(context).add(FetchCategoriesEvent()), options: options);
