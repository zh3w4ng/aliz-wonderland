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
      required this.docId,
      required this.document,
      required this.title,
      required this.summary,
      required this.heroImageUrl})
      : super(key: key);

  final Document document;
  String title;
  String summary;
  String heroImageUrl;
  String? docId;
  final formKey = GlobalKey<FormState>();
  final stories = FirebaseFirestore.instance.collection('stories');

  @override
  State<StatefulWidget> createState() => _PublishModalState();
}

class _PublishModalState extends State<PublishModal> {
  late AppStateProvider appStateProvider;
  late String title;
  late String summary;
  late String url;
  bool publish = false;

  void submitPublish(BuildContext context) {
    if (widget.formKey.currentState!.validate()) {
      widget.formKey.currentState!.save();

      if (widget.docId != null) {
        widget.stories
            .doc(widget.docId)
            .update({
              'doc': widget.document.toJson(),
              'updatedBy': appStateProvider.appState.username(),
              'updatedAt': DateTime.now(),
              'published': publish,
              'title': title,
              'summary': summary,
              'heroImageUrl': url,
            })
            .then((_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'Published successfully.',
                  style: TypographyUtil.labelMedium(context),
                ))))
            .then((_) => appStateProvider
                .goToStory(docId: widget.docId, editable: false));
      } else {
        widget.stories
            .add({
              'createdAt': DateTime.now(),
              'doc': widget.document.toJson(),
              'updatedBy': appStateProvider.appState.username(),
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
                  style: TypographyUtil.labelMedium(context),
                ))))
            .then((_) => appStateProvider
                .goToStory(docId: widget.docId, editable: false));
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
            onPressed: () => submitPublish(context),
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
                  onEditingComplete: () => submitPublish(context),
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
