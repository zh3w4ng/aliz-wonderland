import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/appflowy_editor.dart';
import 'package:wonderland/publish_modal.dart';
import 'package:wonderland/footer.dart';
import 'package:wonderland/typography.dart';

class StoryEditView extends StatefulWidget {
  const StoryEditView({super.key, required this.docId, required this.stories});

  final String docId;
  final CollectionReference stories;

  @override
  State<StoryEditView> createState() => _StoryEditViewState();
}

class _StoryEditViewState extends State<StoryEditView> {
  late AppStateProvider appStateProvider;
  EditorState editorState = EditorState.blank(withInitialText: true);

  @override
  Widget build(BuildContext context) {
    appStateProvider = Provider.of<AppStateProvider>(context);
    String? title = null;
    String? summary = null;
    String? url = null;
    String? ts = null;

    return FutureBuilder(
        future: widget.stories.doc(widget.docId).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            title = snapshot.data!['title'];
            summary = snapshot.data!['summary'];
            ts =
                "Aliz | updated at ${DateFormat.yMMMd('en_US').add_jm().format(snapshot.data!['updatedAt'].toDate())}";

            url = snapshot.data!['heroImageUrl'];
            editorState =
                EditorState(document: Document.fromJson(snapshot.data!['doc']));
          }
          return Padding(
              padding: MediaQuery.of(context).size.width > 600
                  ? const EdgeInsets.symmetric(horizontal: 100)
                  : const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  appStateProvider.appState.loggedIn()
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                              IconButton(
                                  key: const Key('iconbutton-publish'),
                                  tooltip: 'Publish',
                                  onPressed: () => showDialog(
                                      context: context,
                                      builder: (_) => PublishModal(
                                            stories: widget.stories,
                                            username: appStateProvider.appState
                                                .username(),
                                            docId: widget.docId,
                                            document: editorState.document,
                                            title: title!,
                                            summary: summary!,
                                            heroImageUrl: url!,
                                          )),
                                  icon: const Icon(Icons.publish))
                            ])
                      : const SizedBox(),
                  Wrap(children: [
                    Text(title ?? '',
                        style: TypographyUtil.storyHeadlineMediumBold(context))
                  ]),
                  Row(children: [
                    Text(ts ?? '', style: TypographyUtil.labelSmall(context)),
                    const Spacer(),
                    IconButton(
                        key: const Key('iconbutton-share'),
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                                  text:
                                      "https://aliz-in-wonderland/#/story/${widget.docId}"))
                              .then((_) => ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    "Story URL is copied to clipboard successfully.",
                                    style: TypographyUtil.snackBarLabelMedium(
                                        context),
                                  ))));
                        })
                  ]),
                  url != null && url!.isNotEmpty
                      ? SizedBox(
                          height: 250, child: Image(image: NetworkImage(url!)))
                      : const SizedBox(),
                  SizedBox(
                      height: 500,
                      child: AppFlowyEditor(
                          editorStyle: AppflowyEditorUtil.editorStyle(context),
                          editable: appStateProvider.appState.loggedIn() &&
                              appStateProvider.appState.editable,
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
              ));
        });
  }
}
