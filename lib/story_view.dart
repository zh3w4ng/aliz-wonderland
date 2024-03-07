import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/appflowy_editor.dart';
import 'package:wonderland/typography.dart';

class StoryView extends StatefulWidget {
  StoryView({super.key, this.docId});

  String? docId;

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  CollectionReference stories =
      FirebaseFirestore.instance.collection('stories');

  EditorState editorState = EditorState.blank(withInitialText: true);

  @override
  Widget build(BuildContext context) {
    final appStateProvider = Provider.of<AppStateProvider>(context);

    return FutureBuilder(
        future: stories.doc(widget.docId).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            editorState =
                EditorState(document: Document.fromJson(snapshot.data!['doc']));
          }
          return ListView(
            children: [
              appStateProvider.appState.loggedIn()
                  ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      IconButton(
                          tooltip: 'Save as draft',
                          onPressed: () => stories
                                  .doc(widget.docId)
                                  .update({
                                'doc': editorState.document.toJson(),
                                'updatedBy':
                                    appStateProvider.appState.username(),
                              }),
                          icon: const Icon(Icons.save)),
                      IconButton(
                          tooltip: 'Publish',
                          onPressed: () => stories
                                  .doc(widget.docId)
                                  .update({
                                'doc': editorState.document.toJson(),
                                'updatedBy':
                                    appStateProvider.appState.username(),
                                'published': true,
                              }),
                          icon: const Icon(Icons.publish)),
                    ])
                  : const SizedBox(),
              SizedBox(
                  width: double.infinity,
                  height: 800,
                  child: AppFlowyEditor(
                      editable: appStateProvider.appState.loggedIn() && appStateProvider.appState.editable,
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
        });
  }
}
