import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/appflowy_editor.dart';
import 'package:wonderland/publish_modal.dart';

class StoryEditView extends StatefulWidget {
  const StoryEditView({super.key, required this.docId});

  final String docId;

  @override
  State<StoryEditView> createState() => _StoryEditViewState();
}

class _StoryEditViewState extends State<StoryEditView> {
  final CollectionReference stories =
      FirebaseFirestore.instance.collection('stories');
  late AppStateProvider appStateProvider;
  EditorState editorState = EditorState.blank(withInitialText: true);

  @override
  Widget build(BuildContext context) {
    appStateProvider = Provider.of<AppStateProvider>(context);
    late String title;
    late String summary;
    late String url;

    return FutureBuilder(
        future: stories.doc(widget.docId).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            title = snapshot.data!['title'];
            summary = snapshot.data!['summary'];
            url = snapshot.data!['heroImageUrl'];
            editorState =
                EditorState(document: Document.fromJson(snapshot.data!['doc']));
          }
          return ListView(
            children: [
              appStateProvider.appState.loggedIn()
                  ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      IconButton(
                          tooltip: 'Publish',
                          onPressed: () => showDialog(
                              context: context,
                              builder: (_) => PublishModal(
                                    docId: widget.docId,
                                    document: editorState.document,
                                    title: title,
                                    summary: summary,
                                    heroImageUrl: url,
                                  )),
                          icon: const Icon(Icons.publish))
                    ])
                  : const SizedBox(),
              SizedBox(
                  width: double.infinity,
                  height: 800,
                  child: AppFlowyEditor(
                      editorStyle: AppflowyEditorUtil.editorStyle(context),
                      editable: appStateProvider.appState.loggedIn(),
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
