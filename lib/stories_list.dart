import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class StoriesList extends StatefulWidget {
  const StoriesList({super.key});

  @override
  State<StoriesList> createState() => _StoriesListState();
}

class _StoriesListState extends State<StoriesList> {
  final QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
