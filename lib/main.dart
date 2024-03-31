import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:wonderland/app_state.dart';
import 'package:wonderland/theme.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/home_page.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
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
  final AppStateProvider _appStateProvider = AppStateProvider(auth: FirebaseAuth.instance, appState: AppState());

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => _appStateProvider,
        builder: (context, _) {
          final appStateProvider = Provider.of<AppStateProvider>(context);
          return MaterialApp.router(
            title: appStateProvider.appState.title,
            theme: ThemeData(
                colorScheme: MaterialTheme.lightScheme().toColorScheme()),
            darkTheme: ThemeData(
                colorScheme: MaterialTheme.darkScheme().toColorScheme()),
            themeMode: appStateProvider.appState.themeMode,
            routerConfig: GoRouter(initialLocation: '/', routes: [
              GoRoute(
                  path: '/',
                  builder: (context, routerState) => const HomePage()),
              GoRoute(
                  path: '/story/:id',
                  builder: (context, routerState) =>
                      HomePage(docId: routerState.pathParameters['id'])),
            ]),
          );
        });
  }
}
