import 'package:flutter/material.dart';
import 'package:syntax_highlight/syntax_highlight.dart';
import 'package:google_fonts/google_fonts.dart';

class StoriesList extends StatefulWidget {
  const StoriesList({super.key});

  @override
  State<StoriesList> createState() => _StoriesListState();
}

class _StoriesListState extends State<StoriesList> {
  final String _code = '''class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Syntax Highlight Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      );
    }
  }''';
  Future<Column> loadHighlighters() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Highlighter.initialize(['dart', 'yaml', 'sql']);

    // Load the default light theme and create a highlighter.
    var lightTheme = await HighlighterTheme.loadLightTheme();
    var darkTheme = await HighlighterTheme.loadDarkTheme();

    Highlighter _dartLightHighlighter = Highlighter(
      language: 'dart',
      theme: lightTheme,
    );
    // Load the default dark theme and create a highlighter.
    Highlighter _dartDarkHighlighter = Highlighter(
      language: 'dart',
      theme: darkTheme,
    );

    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Text.rich(
              // Highlight the code.
              _dartLightHighlighter.highlight(_code),
              style: GoogleFonts.jetBrainsMono(
                fontSize: 14,
                height: 1.3,
              ),
            )),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.black,
          child: Text.rich(
            // Highlight the code.
            _dartDarkHighlighter.highlight(_code),
            style: GoogleFonts.jetBrainsMono(
              fontSize: 14,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  final ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    loadHighlighters();
    return FutureBuilder(
        future: loadHighlighters(),
        builder: (context, snapshot) => ListView(children: [
              ExpansionTile(
                controller: controller,
                title: const Text('ExpansionTile with explicit controller.'),
                children: <Widget>[
                  snapshot.data != null ? snapshot.data! : const Column(children: [])
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                  child: const Text('Expand/Collapse the Tile Above'),
                  onPressed: () {
                    if (controller.isExpanded) {
                      controller.collapse();
                    } else {
                      controller.expand();
                    }
                  })
            ]));
  }
}
