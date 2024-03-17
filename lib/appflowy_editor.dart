import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/appflowy_code_block.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppflowyEditorUtil {
  static List<CommandShortcutEvent> buildCommandShortcutEvents() => [
        ...codeBlockCommandEvents,
        ...standardCommandShortcutEvents,
      ];

  static Map<String, BlockComponentBuilder> buildBlockComponentBuilders(
      EditorState editorState) {
    final customBlockComponentBuilderMap = {
      CodeBlockKeys.type: CodeBlockComponentBuilder(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 36,
        ),
        editorState: editorState,
      ),
    };
    final builders = {
      ...standardBlockComponentBuilderMap,
      ...customBlockComponentBuilderMap,
    };

    return builders;
  }

  static List<CharacterShortcutEvent> get buildCharacterShortcutEvents => [
        // code block
        ...codeBlockCharacterEvents,

        // customize the slash menu command
        customSlashCommand([...standardSelectionMenuItems, codeBlockItem]),

        ...standardCharacterShortcutEvents
          ..removeWhere(
            (element) => element == slashCommand,
          ), // remove the default slash command.
      ];

  static EditorStyle editorStyle(BuildContext context) {
    return EditorStyle(
      padding: const EdgeInsets.all(0),
      cursorColor: Colors.green,
      dragHandleColor: Colors.green,
      selectionColor: Colors.green,
      textStyleConfiguration: TextStyleConfiguration(
        text: TextStyle(
            fontSize: 16.0, color: Theme.of(context).colorScheme.primary),
      ),
      textSpanDecorator: (context, node, index, text, textSpan, textSpanAfter) {
        final attributes = text.attributes;
        final href = attributes?[AppFlowyRichTextKeys.href];
        if (href != null) {
          return TextSpan(
              text: text.text,
              style: textSpan.style,
              recognizer: TapGestureRecognizer()
                ..onTap = () => launchUrlString(text.text));
        }
        return textSpan;
      },
    );
  }
}
