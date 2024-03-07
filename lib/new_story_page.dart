import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/appflowy_editor.dart';
import 'package:wonderland/typography.dart';

class NewStoryPage extends StatefulWidget {
  const NewStoryPage({super.key});

  @override
  State<NewStoryPage> createState() => _NewStoryPageState();
}

class _NewStoryPageState extends State<NewStoryPage> {
  final stories = FirebaseFirestore.instance.collection('stories');
  final _formKey = GlobalKey<FormState>();
  final editorState = EditorState.blank(withInitialText: true);
  String? docId;
  String? title;
  String? summary;
  String? url;
  AppStateProvider? appStateProvider;

  void submitPublish(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (docId != null) {
        stories
            .doc(docId)
            .update({
              'doc': editorState.document.toJson(),
              'updatedAt': DateTime.now(),
              'updatedBy': appStateProvider!.appState.username(),
              'published': true,
              'title': title,
              'summary': summary,
              'heroImageUrl': url,
            })
            .then((_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'Published successfully.',
                  style: TypographyUtil.labelMedium(context),
                ))))
            .then((_) => context.go('/'))
            .catchError((error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                error.message!,
                style: TypographyUtil.labelMedium(context),
              )));
            });
      } else {
        stories
            .add({
              'doc': editorState.document.toJson(),
              'updatedBy': appStateProvider!.appState.username(),
              'createdAt': DateTime.now(),
              'updatedAt': DateTime.now(),
              'published': true,
              'title': title,
              'summary': summary,
              'heroImageUrl': url,
            })
            .then((value) => setState(() => docId = value.id))
            .then((_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'Published successfully.',
                  style: TypographyUtil.labelMedium(context),
                ))))
            .then((_) => context.go('/'))
            .catchError((error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                error.message!,
                style: TypographyUtil.labelMedium(context),
              )));
            });
      }
    }
  }

  Widget buildListView({required BuildContext context}) {
    return ListView(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          IconButton(
              tooltip: 'Save as draft',
              onPressed: docId != null
                  ? () => stories.doc(docId).update({
                        'doc': editorState.document.toJson(),
                        'updatedAt': DateTime.now(),
                        'updatedBy': appStateProvider!.appState.username(),
                        'published': false
                      })
                  : () => stories.add({
                        'title': title,
                        'updatedBy': appStateProvider!.appState.username(),
                        'createdAt': DateTime.now(),
                        'updatedAt': DateTime.now(),
                        'summary': summary,
                        'published': false,
                        'doc': editorState.document.toJson()
                      }).then((value) => setState(() => docId = value.id)),
              icon: const Icon(Icons.save)),
          IconButton(
              tooltip: 'Publish',
              onPressed: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                      title: Text('Publish',
                          style: TypographyUtil.titleLarge(context)),
                      actions: [
                        ElevatedButton(
                          onPressed: () => submitPublish(context),
                          child: Text('OK',
                              style: TypographyUtil.labelMedium(context)),
                        ),
                        ElevatedButton(
                          onPressed: () => context.pop(),
                          child: Text('CANCEL',
                              style: TypographyUtil.labelMedium(context)),
                        )
                      ],
                      content: Form(
                          key: _formKey,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextFormField(
                                    onSaved: (value) => title = value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the title';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.title),
                                      labelStyle:
                                          TypographyUtil.titleMedium(context),
                                      labelText: 'Title',
                                      hintText: 'title',
                                    )),
                                TextFormField(
                                    onSaved: (value) => url = value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the image url';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.link),
                                      labelStyle:
                                          TypographyUtil.titleMedium(context),
                                      labelText: 'Image URL',
                                      hintText: 'image url',
                                    )),
                                TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    onSaved: (value) => summary = value,
                                    onEditingComplete: () =>
                                        submitPublish(context),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the summary';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.summarize),
                                      labelStyle:
                                          TypographyUtil.titleMedium(context),
                                      labelText: 'Summary',
                                      hintText: 'summary',
                                    )),
                              ])))),
              icon: const Icon(Icons.publish)),
        ]),
        SizedBox(
            width: double.infinity,
            height: 800,
            child: AppFlowyEditor(
                editable: appStateProvider!.appState.loggedIn(),
                editorState: editorState,
                autoFocus: true,
                characterShortcutEvents:
                    AppflowyEditorUtil.buildCharacterShortcutEvents,
                commandShortcutEvents:
                    AppflowyEditorUtil.buildCommandShortcutEvents(),
                blockComponentBuilders:
                    AppflowyEditorUtil.buildBlockComponentBuilders(
                        editorState)))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    appStateProvider = Provider.of<AppStateProvider>(context);

    if (!appStateProvider!.appState.loggedIn()) {
      context.go('/');
    }
    return Scaffold(
        appBar: AppBar(
          title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            IconButton(
                onPressed: () => context.go('/'),
                icon: SvgPicture.asset('assets/icons/zw-logo.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcATop,
                    ))),
            const SizedBox(width: 8),
            Text(appStateProvider!.appState.title,
                style: TypographyUtil.titleLarge(context))
          ]),
        ),
        body: buildListView(context: context));
  }
}
