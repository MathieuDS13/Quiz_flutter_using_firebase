import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quiz_firebase/data/models/question.dart';
import 'package:flutter_quiz_firebase/data/models/questionary.dart';

class DataRetriever {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  DataRetriever(){
  }

  Future<List<String>> getCategories() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await instance.collection("quiz_set").get();
    var data = snapshot.docs.map((e) => e.id).toList();
    return data;
  }

  Future<Questionary> getQuestionary({required String category}) async {
    category = category.toLowerCase().trim();
    var snapshot = await instance
        .collection("quiz_set")
        .doc(category)
        .collection("questions")
        .get();
    var data = snapshot.docs
        .map((e) => Question.name(e.get("body"), e.get("answer")))
        .toList();
    return Questionary.fromList(data, category);
  }

  Future<void> addQuestion({
    required String category,
    required Question question,
  }) async {
    DocumentReference documentReferencer = instance
        .collection("quiz_set")
        .doc(category)
        .collection('questions')
        .doc();

    Map<String, dynamic> data = <String, dynamic>{
      "body": question.body,
      "answer": question.answer,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Question added to database"))
        .catchError((e) => print(e));
  }
}
