import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/typography.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final QuillController _controller = QuillController.basic();

  CollectionReference stories =
      FirebaseFirestore.instance.collection('stories');

  @override
  Widget build(BuildContext context) {
    final appStateProvider = Provider.of<AppStateProvider>(context);

    

    final id = GoRouterState.of(context).pathParameters['id'];

    stories.doc(id).get().then((snapshot) {
      Map record = snapshot.data()! as Map;
      _controller.document = Document.fromJson(record['doc']);
    });
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
        body: Column(
          children: [
            appStateProvider.loggedIn()
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        // final story = <String, dynamic>{
                        //   "title": "test",
                        //   "summary": "this is a test",
                        //   "doc":
                        // };

                        stories.doc(id).update(
                            {"doc": _controller.document.toDelta().toJson()});
                      });
                    },
                    icon: const Icon(Icons.save))
                : const SizedBox.shrink(),
            QuillToolbar.simple(
              configurations: QuillSimpleToolbarConfigurations(
                controller: _controller,
                embedButtons: FlutterQuillEmbeds.toolbarButtons(),
              ),
            ),
            Expanded(
                child: QuillEditor.basic(
              configurations: QuillEditorConfigurations(
                readOnly: !appStateProvider.loggedIn(),
                controller: _controller,
                embedBuilders: FlutterQuillEmbeds.editorWebBuilders(),
              ),
            )),
          ],
        ));
  }
}
