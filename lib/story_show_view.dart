import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:wonderland/appflowy_editor.dart';
import 'package:wonderland/footer.dart';

class StoryShowView extends StatefulWidget {
  const StoryShowView({super.key, required this.docId});

  final String docId;

  @override
  State<StoryShowView> createState() => _StoryShowViewState();
}

class _StoryShowViewState extends State<StoryShowView> {
  final CollectionReference stories =
      FirebaseFirestore.instance.collection('stories');

  EditorState editorState = EditorState.blank(withInitialText: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: stories.doc(widget.docId).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            editorState =
                EditorState(document: Document.fromJson(snapshot.data!['doc']));
          }
          return ListView(
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 800,
                  child: AppFlowyEditor(
                      editorStyle: AppflowyEditorUtil.editorStyle(context),
                      editable: false,
                      editorState: editorState,
                      autoFocus: true,
                      characterShortcutEvents:
                          AppflowyEditorUtil.buildCharacterShortcutEvents,
                      commandShortcutEvents:
                          AppflowyEditorUtil.buildCommandShortcutEvents(),
                      blockComponentBuilders:
                          AppflowyEditorUtil.buildBlockComponentBuilders(
                              editorState))),
              const Divider(),
              const Footer(height: 24)
            ],
          );
        });
  }
}
