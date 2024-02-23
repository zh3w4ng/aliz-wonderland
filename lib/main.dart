import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:wonderland/theme.dart';
import 'package:wonderland/theme_mode_provider.dart';
import 'package:wonderland/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
     FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final ThemeModeProvider _themeModeProvider = ThemeModeProvider();

  @override
  Widget build(BuildContext context) {
    const String title = 'aliZ in Wonderland';
    return ChangeNotifierProvider(
        create: (context) => _themeModeProvider,
        builder: (context, _) {
          final themeModeProvider = Provider.of<ThemeModeProvider>(context);
          return MaterialApp(
            title: title,
            theme: ThemeData(
                colorScheme: MaterialTheme.lightScheme().toColorScheme()),
            darkTheme: ThemeData(
                colorScheme: MaterialTheme.darkScheme().toColorScheme()),
            themeMode: themeModeProvider.themeMode,
            home: HomePage(title: title, themeModeProvider: _themeModeProvider),
          );
        });
  }
}
