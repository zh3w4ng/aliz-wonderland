import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/typography.dart';

class ImportModal extends StatelessWidget {
  ImportModal({Key? key}) : super(key: key);

  late final AppStateProvider appStateProvider;

  void submitLogOut(BuildContext context) {
    appStateProvider.logOut().catchError((error) {
      if (error is FirebaseAuthException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          error.message!,
          style: TypographyUtil.labelMedium(context),
        )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    appStateProvider = Provider.of<AppStateProvider>(context);

    return AlertDialog(
        title: Text('Log out', style: TypographyUtil.titleLarge(context)),
        actions: [
          ElevatedButton(
            onPressed: () => submitLogOut(context),
            child: Text('OK', style: TypographyUtil.labelMedium(context)),
          ),
          ElevatedButton(
            onPressed: () => context.pop(),
            child: Text('CANCEL', style: TypographyUtil.labelMedium(context)),
          )
        ]);
  }
}
