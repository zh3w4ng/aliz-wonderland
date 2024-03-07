import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/typography.dart';

class StoriesList extends StatefulWidget {
  const StoriesList({super.key});

  @override
  State<StoriesList> createState() => _StoriesListState();
}

class _StoriesListState extends State<StoriesList> {
  CollectionReference stories =
      FirebaseFirestore.instance.collection('stories');

  AppStateProvider? appStateProvider;

  Widget _buildSubtitle(
      {required BuildContext context,
      required String time,
      required String summary}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(time, style: TypographyUtil.keywordsList(context)),
      Text(summary, style: TypographyUtil.keywordsList(context)),
    ]);
  }

  InkWell _buildTitle(BuildContext context, String title, String id) {
    return InkWell(
        onTap: () => appStateProvider!.goToStory(docId: id, editable: false),
        child: Text(title, style: TypographyUtil.keywordsTitle(context)));
  }

  ListTile _buildListTile(
      {required BuildContext context,
      required double height,
      required String title,
      required Timestamp ts,
      required String id,
      required String url,
      required String summary}) {
    return ListTile(
        leading: Image(image: NetworkImage(url)),
        trailing: appStateProvider!.appState.loggedIn()
            ? IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  appStateProvider!.goToStory(docId: id, editable: true);
                })
            : IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                          text: "https://aliz-in-wonderland/#/story/$id"))
                      .then((_) =>
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            "Story URL is copied to clipboard successfully.",
                            style: TypographyUtil.labelMedium(context),
                          ))));
                }),
        title: _buildTitle(context, title, id),
        subtitle: _buildSubtitle(
            context: context,
            time:
                "updated at ${DateFormat.yMMMd('en_US').add_jm().format(ts.toDate())}",
            summary: summary));
  }

  Widget _builCard(BuildContext context, String id, Map<String, dynamic> node) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildListTile(
              context: context,
              height: 32,
              title: node['title'],
              summary: node['summary'],
              ts: node['updatedAt'],
              id: id,
              url: node['heroImageUrl']),
          const SizedBox(
            height: 8,
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final page = stories
        .orderBy('updatedAt', descending: true)
        .limit(10)
        .get()
        .then((querySnapshot) => querySnapshot.docs
            .map((doc) => {'id': doc.id, 'node': doc.data()})
            .toList());
    appStateProvider = Provider.of<AppStateProvider>(context);

    return FutureBuilder(
        future: page,
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final entry = snapshot.data![index];
                  return _builCard(context, entry['id'] as String,
                      entry['node'] as Map<String, dynamic>);
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              )
            : const SizedBox());
  }
}
