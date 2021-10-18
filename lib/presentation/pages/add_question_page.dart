import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_firebase/business_logic/blocs/quiz_bloc.dart';
import 'package:flutter_quiz_firebase/data/models/question.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddQuestionState();
}

class AddQuestionState extends State<AddQuestionPage> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  bool answer = true;
  String dropdownValue = "biology";
  List<String>? categories;
  Future<List<String>>? future;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    future = BlocProvider.of<QuizBloc>(context).getCategories();
    return FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget toShow;
          if (snapshot.hasData) {
            categories = snapshot.data;
            toShow = getBody();
          } else if (snapshot.hasError) {
            toShow = Column(
              children: [
                Expanded(
                  child: const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ),
              ],
            );
          } else {
            toShow = Column(
              children: [
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting data...'),
                ),
              ],
            );
          }
          return Expanded(
            child: Center(
              child: toShow,
            ),
          );
        }); //TODO;
  }

  Widget getBody() {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Question Editor"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: const Text("Create your own question :",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold)),
              ),
              Form(
                key: _formKey,
                child: Column(children: [
                  const Text("Enter your question :",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: categories!
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const Text("Enter your question :",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        maxLength: 250,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your question !';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const Text("What is the answer ? :",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text("True",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          onChanged: (bool? value) {
                            setState(() {
                              answer = true;
                              print(answer);
                            });
                          },
                          value: answer,
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text("False",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          value: !answer,
                          onChanged: (bool? value) {
                            setState(() {
                              answer = false;
                              print(answer);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_controller.text != null &&
                          _controller.text.isNotEmpty) {
                        BlocProvider.of<QuizBloc>(context, listen: false).add(
                            AddQuestionEvent(
                                Question.name(_controller.text, answer),
                                dropdownValue));
                        //TODO modifier la catégorie
                        //validForm(Question.name(_controller.text, answer), "biology",
                        //context);
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Submitting question')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  /**
      Widget getForm(BuildContext context) {
      return
      }
   **/

  void validForm(Question question, String category, BuildContext context) {
    BlocProvider.of<QuizBloc>(context, listen: false)
        .add(AddQuestionEvent(question, category));
    //TODO envoyer la question dans la base de données
    //TODO effacer toute la sélection si la question a bien été rajoutée
  }

  setCategories() async {
    categories = await BlocProvider.of<QuizBloc>(context).getCategories();
  }

//TODO ajouter la sélection de catégorie avec un
}
