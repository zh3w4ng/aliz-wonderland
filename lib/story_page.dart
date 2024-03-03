import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/appflowy_editor.dart';
import 'package:wonderland/typography.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {

  CollectionReference stories =
      FirebaseFirestore.instance.collection('stories');

  EditorState editorState = EditorState.blank(withInitialText: true);

  late final Map<String, BlockComponentBuilder> blockComponentBuilders;


  @override
  Widget build(BuildContext context) {
    final appStateProvider = Provider.of<AppStateProvider>(context);

    final id = GoRouterState.of(context).pathParameters['id'];
    Future record = stories.doc(id).get();

    return Scaffold(
        appBar: AppBar(
          title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            IconButton(
                onPressed: () {
                  context.go('/');
                },
                icon: SvgPicture.asset('assets/icons/zw-logo.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcATop,
                    ))),
            const SizedBox(width: 8),
            Text(appStateProvider.title,
                style: TypographyUtil.titleLarge(context))
          ]),
        ),
        body: FutureBuilder(
            future: record,
            builder: (context, snapshot) {
              final editorState = snapshot.hasData
                  ? EditorState(
                      document: Document.fromJson(snapshot.data['doc']))
                  : EditorState.blank();

              return Column(
                children: [
                  appStateProvider.loggedIn()
                      ? IconButton(
                          onPressed: () {
                            // final story = <String, dynamic>{
                            //   "title": "test",
                            //   "summary": "this is a test",
                            //   "doc": editorState.document.toJson()
                            // };

                            stories
                                .doc(id)
                                .update({'doc': editorState.document.toJson()});
                          },
                          icon: const Icon(Icons.save))
                      : const SizedBox.shrink(),
                  SizedBox(
                      width: double.infinity,
                      height: 800,
                      child: AppFlowyEditor(
                          editorState: editorState,
                          autoFocus: true,
                          characterShortcutEvents: AppflowyEditorUtil.buildCharacterShortcutEvents,
                          commandShortcutEvents:
                              AppflowyEditorUtil.buildCommandShortcutEvents(),
                          blockComponentBuilders:
                              AppflowyEditorUtil.buildBlockComponentBuilders(
                                  editorState)))
                ],
              );
            }));
  }
}
