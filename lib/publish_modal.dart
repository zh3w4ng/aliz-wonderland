import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/typography.dart';

class PublishModal extends StatefulWidget {
  PublishModal(
      {Key? key,
      required this.username,
      required this.stories,
      required this.docId,
      required this.document,
      required this.title,
      required this.summary,
      required this.heroImageUrl})
      : super(key: key);

  final Document document;
  String username;
  String title;
  String summary;
  String heroImageUrl;
  String? docId;
  final CollectionReference stories;
  final formKey = GlobalKey<FormState>();

  @override
  State<StatefulWidget> createState() => _PublishModalState();
}

class _PublishModalState extends State<PublishModal> {
  late AppStateProvider appStateProvider;
  late String title;
  late String summary;
  late String url;
  bool publish = false;

  void publishStory(BuildContext context) {
    if (widget.docId != null) {
      publishOld(context);
    } else {
      publishNew(context);
    }
  }

  Future<void> publishNew(BuildContext context) async {
    if (widget.formKey.currentState!.validate()) {
      widget.formKey.currentState!.save();
      try {
        await widget.stories
            .add({
              'createdAt': DateTime.now(),
              'doc': widget.document.toJson(),
              'updatedBy': widget.username,
              'updatedAt': DateTime.now(),
              'published': publish,
              'title': title,
              'summary': summary,
              'heroImageUrl': url,
            })
            .then((value) => widget.docId = value.id)
            .then((_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'Published successfully.',
                  style: TypographyUtil.snackBarLabelMedium(context),
                ))))
            .then((_) => appStateProvider.goToStory(
                docId: widget.docId, editable: false));
      } on FirebaseException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            content: Text(
              error.message!,
              style: TypographyUtil.snackBarErrorLabelMedium(context),
            )));
      }
    }
  }

  void publishOld(BuildContext context) {
    if (widget.formKey.currentState!.validate()) {
      widget.formKey.currentState!.save();
      try {
        widget.stories
            .doc(widget.docId)
            .update({
              'doc': widget.document.toJson(),
              'updatedBy': widget.username,
              'updatedAt': DateTime.now(),
              'published': publish,
              'title': title,
              'summary': summary,
              'heroImageUrl': url,
            })
            .then((_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'Published successfully.',
                  style: TypographyUtil.snackBarLabelMedium(context),
                ))))
            .then((_) => appStateProvider.goToStory(
                docId: widget.docId, editable: false));
      } on FirebaseException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            content: Text(
              error.message!,
              style: TypographyUtil.snackBarErrorLabelMedium(context),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    appStateProvider = Provider.of<AppStateProvider>(context);

    return AlertDialog(
        title: Text(publish ? 'Publish' : 'Save as Draft',
            style: TypographyUtil.titleLarge(context)),
        actions: [
          ElevatedButton(
            onPressed: () => publishStory(context),
            child: Text('OK', style: TypographyUtil.labelMedium(context)),
          ),
          ElevatedButton(
            onPressed: () => context.pop(),
            child: Text('CANCEL', style: TypographyUtil.labelMedium(context)),
          )
        ],
        content: Form(
            key: widget.formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              TextFormField(
                  initialValue: widget.title,
                  onSaved: (value) => title = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.title),
                    labelStyle: TypographyUtil.titleMedium(context),
                    labelText: 'Title',
                    hintText: 'title',
                  )),
              TextFormField(
                  initialValue: widget.heroImageUrl,
                  onSaved: (value) => url = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the image url';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.link),
                    labelStyle: TypographyUtil.titleMedium(context),
                    labelText: 'Image URL',
                    hintText: 'image url',
                  )),
              TextFormField(
                  initialValue: widget.summary,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onSaved: (value) => summary = value!,
                  onEditingComplete: () => publishStory(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the summary';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.summarize),
                    labelStyle: TypographyUtil.titleMedium(context),
                    labelText: 'Summary',
                    hintText: 'summary',
                  )),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text('Mark as Published',
                        style: TypographyUtil.labelMedium(context)),
                    Switch.adaptive(
                        value: publish,
                        onChanged: (value) => setState(() => publish = value))
                  ]))
            ])));
  }
}
