import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wonderland/name_card.dart';
import 'package:wonderland/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const String title = 'aliZWonderland';
    return MaterialApp(
      title: title,
      theme:
          ThemeData(colorScheme: MaterialTheme.lightScheme().toColorScheme()),
      darkTheme:
          ThemeData(colorScheme: MaterialTheme.darkScheme().toColorScheme()),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: const [SizedBox(width: 40)],
        leading: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: IconButton(
              icon: const Icon(Icons.menu),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
            )),
        // actions: [
        //   IconButton(
        //       icon: SvgPicture.asset('assets/icons/zw-logo.svg',
        //           colorFilter: ColorFilter.mode(
        //             Theme.of(context).colorScheme.primary,
        //             BlendMode.srcATop,
        //           )),
        //       onPressed: () {}),
        // ],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SvgPicture.asset('assets/icons/zw-logo.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcATop,
              )),
          const SizedBox(width: 8),
          Text(widget.title,
              style: TextStyle(
                  fontFamily: 'Bodoni 72 Smallcaps Book',
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary))
        ]),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[NameCard()],
          ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
