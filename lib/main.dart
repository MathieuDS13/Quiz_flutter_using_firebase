import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_firebase/presentation/themes/theme_notifier.dart';
import 'package:provider/provider.dart';

import 'business_logic/blocs/quiz_bloc.dart';
import 'presentation/pages/quiz_home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(),
    child: BlocProvider(
      create: (context) => QuizBloc(QuizInitial()),
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
        title: 'Flutter Demo',
        theme: theme.getTheme(),
        home: const QuizHomePage(),
      ),
    );
  }
}
