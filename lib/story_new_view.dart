import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/appflowy_editor.dart';
import 'package:wonderland/publish_modal.dart';

class StoryNewView extends StatefulWidget {
  const StoryNewView({super.key});

  @override
  State<StoryNewView> createState() => _StoryNewViewState();
}

class _StoryNewViewState extends State<StoryNewView> {
  final editorState = EditorState.blank(withInitialText: true);
  late AppStateProvider appStateProvider;

  @override
  Widget build(BuildContext context) {
    appStateProvider = Provider.of<AppStateProvider>(context);

    if (!appStateProvider.appState.loggedIn()) {
      appStateProvider.goToNonStory(tab: 'home');
    }
    return ListView(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          IconButton(
              tooltip: 'Publish',
              onPressed: () => showDialog(
                  context: context,
                  builder: (_) => PublishModal(
                    username:  appStateProvider.appState.username(),
                    stories: FirebaseFirestore.instance.collection('stories'),
                      docId: null,
                      document: editorState.document,
                      title: '',
                      summary: '',
                      heroImageUrl: '')),
              icon: const Icon(Icons.publish)),
        ]),
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
  }
}
