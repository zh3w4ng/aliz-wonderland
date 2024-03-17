import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:wonderland/appflowy_editor.dart';
import 'package:wonderland/footer.dart';
import 'package:wonderland/typography.dart';

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
  String? title = null;
  String? ts = null;
  String? url = null;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: stories.doc(widget.docId).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            editorState =
                EditorState(document: Document.fromJson(snapshot.data!['doc']));
            title = snapshot.data!['title'];
            url = snapshot.data!['heroImageUrl'];
            ts =
                "Aliz | updated at ${DateFormat.yMMMd('en_US').add_jm().format(snapshot.data!['updatedAt'].toDate())}";
          }
          return Padding(
              padding: MediaQuery.of(context).size.width > 600
                  ? const EdgeInsets.symmetric(horizontal: 100)
                  : const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  Wrap(children: [
                    Text(title ?? '',
                        style: TypographyUtil.storyHeadlineMediumBold(context))
                  ]),
                  Row(children: [
                    Text(ts ?? '', style: TypographyUtil.labelSmall(context)),
                    const Spacer(),
                    IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                                  text:
                                      "https://aliz-in-wonderland.com/#/story/${widget.docId}"))
                              .then((_) => ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    "Story URL is copied to clipboard successfully.",
                                    style: TypographyUtil.snackBarLabelMedium(context),
                                  ))));
                        })
                  ]),
                  url != null
                      ? SizedBox(
                          height: 250, child: Image(image: NetworkImage(url!)))
                      : const SizedBox(),
                  SizedBox(
                      // width: double.infinity,
                      // height: 800,
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
              ));
        });
  }
}
