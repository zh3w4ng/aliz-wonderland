import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/appflowy_code_block.dart';
import 'package:flutter/material.dart';

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
}
