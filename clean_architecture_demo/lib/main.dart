import 'package:clean_architecture_demo/app/di.dart';
import 'package:clean_architecture_demo/presentation/resources/theme_manager.dart';
import 'package:clean_architecture_demo/presentation/features/view_todo_cards/todo_cards.screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  await _initializeFirebase();
  await initAppModule();
  runApp(const MainApp());
}

Future<void> _initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: const TodoCardsScreen(),
      theme: getApplicationTheme(),
    );
  }
}
