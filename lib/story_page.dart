import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final QuillController _controller = QuillController.basic();
  
  
  CollectionReference stories = FirebaseFirestore.instance.collection('stories');
  


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                final story = <String, dynamic>{
                  "title": "test",
                  "summary": "this is a test",
                  "doc": _controller.document.toDelta().toJson()
                };

                stories.add(story);
              });
            },
            icon: const Icon(Icons.save)),
        QuillToolbar.simple(
          configurations: QuillSimpleToolbarConfigurations(
            controller: _controller,
            embedButtons: FlutterQuillEmbeds.toolbarButtons(),
          ),
        ),
        Expanded(
            child: QuillEditor.basic(
          configurations: QuillEditorConfigurations(
            controller: _controller,
            embedBuilders: FlutterQuillEmbeds.editorWebBuilders(),
          ),
        )),
      ],
    );
  }
}
