import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/typography.dart';

class LogOutModal extends StatelessWidget {
  LogOutModal({Key? key}) : super(key: key);

  late AppStateProvider appStateProvider;

  Future<void> submitLogOut(BuildContext context) async {
    try {
      await appStateProvider
          .logOut()
          .then((_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                'Logged out successfully.',
                style: TypographyUtil.snackBarLabelMedium(context),
              ))));
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          content: Text(
            error.message!,
            style: TypographyUtil.snackBarErrorLabelMedium(context),
          )));
    }
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
