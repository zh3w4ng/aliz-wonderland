import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wonderland/experience_cards.dart';
import 'package:wonderland/name_card.dart';
import 'package:wonderland/companies_swiper.dart';
import 'package:wonderland/stories_list.dart';
import 'package:wonderland/tools_word_cloud.dart';
import 'package:wonderland/theme_mode_provider.dart';
import 'package:wonderland/typography.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key, required this.title, required this.themeModeProvider})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final ThemeModeProvider themeModeProvider;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _navigationRailVisible = false;
  int _selectedIndex = 1;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;

  Widget _selectDestination() {
    switch (_selectedIndex) {
      case 1:
        return ExperienceCards();
      case 2:
        return const StoriesList();
      default:
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: const <Widget>[
            SizedBox(height: 8),
            NameCard(),
            SizedBox(height: 8),
            CompaniesSwiper(),
            ToolsWordCloud(),
            SizedBox(height: 16)
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [SizedBox(width: 40)],
        leading: IconButton(
          icon: _navigationRailVisible
              ? const Icon(Icons.menu_open)
              : const Icon(Icons.menu),
          color: Theme.of(context).colorScheme.primary,
          onPressed: () {
            setState(() {
              _navigationRailVisible = !_navigationRailVisible;
            });
          },
        ),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SvgPicture.asset('assets/icons/zw-logo.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcATop,
              )),
          const SizedBox(width: 8),
          Text(widget.title, style: TypographyUtil.titleLarge(context))
        ]),
      ),
      body: Row(children: <Widget>[
        AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: Visibility(
                visible: _navigationRailVisible,
                child: NavigationRail(
                  selectedIndex: _selectedIndex,
                  groupAlignment: groupAlignment,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: labelType,
                  leading: showLeading
                      ? FloatingActionButton(
                          elevation: 0,
                          onPressed: () {
                            // Add your onPressed code here!
                          },
                          child: const Icon(Icons.add),
                        )
                      : const SizedBox(),
                  trailing: showTrailing
                      ? IconButton(
                          onPressed: () {
                            // Add your onPressed code here!
                          },
                          icon: const Icon(Icons.more_horiz_rounded),
                        )
                      : const SizedBox(),
                  destinations: <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: const Icon(Icons.cottage_outlined),
                      selectedIcon: const Icon(Icons.cottage),
                      label: Text('home', style: TypographyUtil.keywordsList(context)),
                    ),
                    NavigationRailDestination(
                      icon: const Icon(Icons.hiking_outlined),
                      selectedIcon: const Icon(Icons.hiking),
                      label: Text('experience', style: TypographyUtil.keywordsList(context)),
                    ),
                    NavigationRailDestination(
                      icon: const Icon(Icons.auto_stories_outlined),
                      selectedIcon: const Icon(Icons.auto_stories),
                      label: Text('stories', style: TypographyUtil.keywordsList(context)),
                    ),
                  ],
                ))),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: _selectDestination()))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.themeModeProvider.toggleThemeMode(
              Theme.of(context).brightness == Brightness.light);
        },
        tooltip: Theme.of(context).brightness == Brightness.dark
            ? 'Light Mode'
            : 'Dark Mode',
        child: Theme.of(context).brightness == Brightness.dark
            ? const Icon(Icons.light_mode)
            : const Icon(Icons.dark_mode),
      ),
    );
  }
}
