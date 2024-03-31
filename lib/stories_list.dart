import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/typography.dart';
// import 'package:wonderland/footer.dart';

class StoriesList extends StatefulWidget {
  const StoriesList({
    Key? key,
    required this.stories,
  }) : super(key: key);

  final CollectionReference stories;
  @override
  State<StoriesList> createState() => _StoriesListState();
}

class _StoriesListState extends State<StoriesList> {
  late AppStateProvider appStateProvider;

  IconButton _buildShareIconButton(
      {required BuildContext context, required String id}) {
    return IconButton(
        key: const Key('iconbutton-share'),
        icon: const Icon(Icons.share),
        onPressed: () {
          Clipboard.setData(ClipboardData(
                  text: "https://aliz-in-wonderland.com/#/story/$id"))
              .then((_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "Story URL is copied to clipboard successfully.",
                    style: TypographyUtil.snackBarLabelMedium(context),
                  ))));
        });
  }

  PopupMenuButton<String> _buildPopMenuButton(
      {required BuildContext context, required String id, required Map node}) {
    dynamic toEncodable(dynamic item) {
      if (item is Timestamp) {
        return item.toDate().toIso8601String();
      }
      return item;
    }

    return PopupMenuButton(
      key: const Key('popup-menu-button'),
      icon: const Icon(Icons.more_horiz),
      onSelected: (value) {
        switch (value) {
          case 'edit':
            appStateProvider.goToStory(docId: id, editable: true);
          case 'export':
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                    content: SelectableText(
                        json.encode(node, toEncodable: toEncodable),
                        style: TypographyUtil.keywordsList(context))));
          case 'delete':
            widget.stories.doc(id).delete().then((_) =>
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Story is deleted successfully.",
                        style: TypographyUtil.snackBarLabelMedium(context)))));
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
            key: Key('popup-edit'),
            value: 'edit',
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Icon(Icons.edit), Text('edit')])),
        const PopupMenuItem(
            key: Key('popup-export'),
            value: 'export',
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Icon(Icons.download), Text('export')])),
        const PopupMenuItem(
            key: Key('popup-delete'),
            value: 'delete',
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Icon(Icons.delete), Text('delete')]))
      ],
    );
  }

  ListTile _buildListTile(
      {required BuildContext context,
      required double height,
      required Map node,
      required String id}) {
    final String title = node['title'];
    final Timestamp ts = node['updatedAt'];
    final String summary = node['summary'];
    final String url = node['heroImageUrl'];
    if (appStateProvider.appState.loggedIn()) {
      return ListTile(
          leading: url.isNotEmpty
              ? SizedBox(width: 80, child: Image.network(url))
              : const SizedBox(width: 80),
          trailing: _buildPopMenuButton(context: context, id: id, node: node),
          // trailing: _buildShareIconButton(context: context, id: id),
          title: InkWell(
              onTap: () =>
                  appStateProvider.goToStory(docId: id, editable: false),
              child: Text(node['published'] ? title : '$title [Draft]',
                  style: TypographyUtil.keywordsTitle(context))),
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
                "updated at ${DateFormat.yMMMd('en_US').add_jm().format(ts.toDate())}",
                style: TypographyUtil.labelSmall(context)),
            Text(summary, style: TypographyUtil.keywordsList(context)),
          ]));
    } else {
      return ListTile(
          leading: url.isNotEmpty
              ? SizedBox(width: 80, child: Image.network(url))
              : const SizedBox(width: 80),
          trailing: _buildShareIconButton(context: context, id: id),
          title: InkWell(
              onTap: () =>
                  appStateProvider.goToStory(docId: id, editable: false),
              child: Text(title, style: TypographyUtil.keywordsTitle(context))),
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
                "updated at ${DateFormat.yMMMd('en_US').add_jm().format(ts.toDate())}",
                style: TypographyUtil.labelSmall(context)),
            Text(summary, style: TypographyUtil.keywordsList(context)),
          ]));
    }
  }

  Widget _builStory(
      {required BuildContext context,
      required String id,
      required Map<String, dynamic> node,
      required bool lastOne}) {
    return lastOne
        ? Column(children: [
            _buildListTile(
              context: context,
              height: 32,
              node: node,
              id: id,
            ),
            // add the two lines below back when there're more stories.
            // const Divider(height: 8),
            // const Footer(height: 24)
          ])
        : _buildListTile(
            context: context,
            height: 32,
            node: node,
            id: id,
          );
  }

  @override
  Widget build(BuildContext context) {
    appStateProvider = Provider.of<AppStateProvider>(context);
    late final Future<List> page;
    if (appStateProvider.appState.loggedIn()) {
      page = widget.stories
          .orderBy('updatedAt', descending: true)
          .limit(10)
          .get()
          .then((querySnapshot) => querySnapshot.docs
              .map((doc) => {'id': doc.id, 'node': doc.data()})
              .toList());
    } else {
      page = widget.stories
          .orderBy('updatedAt', descending: true)
          .limit(10)
          .get()
          .then((querySnapshot) => querySnapshot.docs
              .map((doc) => {'id': doc.id, 'node': doc.data()})
              .toList());
    }

    return FutureBuilder(
        future: page,
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final entry = snapshot.data![index];
                  return _builStory(
                      context: context,
                      id: entry['id'],
                      node: entry['node'],
                      lastOne: index == snapshot.data!.length - 1);
                },
                separatorBuilder: (context, index) {
                  return const Divider(height: 8);
                },
              )
            : const SizedBox());
  }
}
