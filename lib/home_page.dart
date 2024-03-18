import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wonderland/app_state.dart';
import 'package:wonderland/experience_cards.dart';
import 'package:wonderland/log_in_modal.dart';
import 'package:wonderland/log_out_modal.dart';
import 'package:wonderland/name_card.dart';
import 'package:wonderland/companies_swiper.dart';
import 'package:wonderland/story_new_view.dart';
import 'package:wonderland/stories_list.dart';
import 'package:wonderland/story_edit_view.dart';
import 'package:wonderland/story_show_view.dart';
import 'package:wonderland/tools_word_cloud.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/typography.dart';
import 'package:wonderland/footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.docId}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? docId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _navigationRailVisible = false;
  final NavigationRailLabelType labelType = NavigationRailLabelType.all;
  final double groupAlignment = -1.0;
  final stories = FirebaseFirestore.instance.collection('stories');
  late AppStateProvider appStateProvider;
  final analytics = FirebaseAnalytics.instance;

  Widget _selectNavigationIndex(AppState appState) {
    switch (appState.navigationIndex) {
      case null:
        if (appState.docId == null) {
          return const StoryNewView();
        } else if (appState.editable) {
          return StoryEditView(docId: appState.docId!);
        } else {
          analytics.logScreenView(screenName: 'Story Show');
          analytics
              .logViewItem(parameters: {'id': appState.docId});
          return StoryShowView(docId: appState.docId!);
        }
      case 2:
        analytics.logScreenView(screenName: 'Story List');
        analytics.logViewItemList();
        return const StoriesList();
      case 1:
        analytics.logScreenView(screenName: 'Experience');
        return const ExperienceCards();
      default:
        analytics.logScreenView(screenName: 'Home');
        return ListView(
            physics: const BouncingScrollPhysics(),
            children: const <Widget>[
              SizedBox(height: 8),
              NameCard(),
              SizedBox(height: 8),
              CompaniesSwiper(),
              ToolsWordCloud(),
              SizedBox(height: 8),
              Footer(height: 32)
            ]);
    }
  }

  Widget _buildPopMenuButton(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_horiz),
      onSelected: (value) {
        switch (value) {
          case 'login':
            showDialog(context: context, builder: (_) => LogInModal());
          case 'logout':
            showDialog(context: context, builder: (_) => LogOutModal());
          case 'import':
            FilePicker.platform.pickFiles().then((result) {
              if (result != null) {
                final Map node = json
                    .decode(utf8.decode(result.files.single.bytes!.toList()));
                stories.add({
                  'doc': node['doc'],
                  'creadedAt': DateTime.now(),
                  'updatedAt': DateTime.now(),
                  'updatedBy': appStateProvider.appState.username(),
                  'published': true,
                  'title': node['title'],
                  'summary': node['summary'],
                  'heroImageUrl': node['heroImageUrl'],
                }).then(
                    (_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          'Imported successfully.',
                          style: TypographyUtil.snackBarLabelMedium(context),
                        ))));
              }
            });
        }
      },
      itemBuilder: (context) => appStateProvider.appState.loggedIn()
          ? [
              const PopupMenuItem(
                  value: 'logout',
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Icon(Icons.logout), Text('logout')])),
              const PopupMenuItem(
                  value: 'import',
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Icon(Icons.upload), Text('import')])),
            ]
          : [
              const PopupMenuItem(
                  value: 'login',
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Icon(Icons.login), Text('login')]))
            ],
    );
  }

  List<NavigationRailDestination> _buildNavigatioinRailDestinations(
      BuildContext context) {
    return <NavigationRailDestination>[
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    appStateProvider = Provider.of<AppStateProvider>(context);
    if (MediaQuery.of(context).size.width > 600) {
      _navigationRailVisible = true;
    }
    if (widget.docId != null) {
      appStateProvider.goToStory(docId: widget.docId, editable: false);
    }
    return Scaffold(
      appBar: AppBar(
        leading: appStateProvider.appState.navigationIndex != null
            ? (MediaQuery.of(context).size.width > 600
                ? const SizedBox()
                : IconButton(
                    icon: _navigationRailVisible
                        ? const Icon(Icons.menu_open)
                        : const Icon(Icons.menu),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () => setState(() =>
                        _navigationRailVisible = !_navigationRailVisible)))
            : IconButton(
                onPressed: () => appStateProvider.goToNonStory(tab: 'stories'),
                icon: const Icon(Icons.arrow_back)),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          IconButton(
              onPressed: () => appStateProvider.goToNonStory(tab: 'home'),
              icon: SvgPicture.asset('assets/icons/zw-logo.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcATop,
                  ))),
          const SizedBox(width: 8),
          Text(appStateProvider.appState.title,
              style: TypographyUtil.titleLarge(context))
        ]),
      ),
      body: Row(children: <Widget>[
        AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: Visibility(
                visible: _navigationRailVisible,
                child: NavigationRail(
                    selectedIndex: appStateProvider.appState.navigationIndex,
                    groupAlignment: groupAlignment,
                    onDestinationSelected: (int index) =>
                        appStateProvider.navigate(index: index),
                    labelType: labelType,
                    leading: appStateProvider.appState.loggedIn()
                        ? FloatingActionButton(
                            elevation: 0,
                            onPressed: () => appStateProvider.goToStory(
                                docId: null, editable: true),
                            child: const Icon(Icons.add),
                          )
                        : const SizedBox(),
                    trailing: _buildPopMenuButton(context),
                    destinations: _buildNavigatioinRailDestinations(context)))),
        Expanded(
            child: Padding(
                padding: MediaQuery.of(context).size.width > 600
                    ? const EdgeInsets.symmetric(horizontal: 40)
                    : const EdgeInsets.symmetric(horizontal: 20),
                child: _selectNavigationIndex(appStateProvider.appState))),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appStateProvider.toggleThemeMode(
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
