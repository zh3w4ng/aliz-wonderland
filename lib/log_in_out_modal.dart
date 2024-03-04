import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wonderland/app_state_provider.dart';
import 'package:wonderland/typography.dart';

class LogInOutModal extends StatefulWidget {
  const LogInOutModal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LogInOutModal();
}

class _LogInOutModal extends State<LogInOutModal> {
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  AppStateProvider? appStateProvider;

  void submitLogIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      appStateProvider!
          .logIn(email: username!, password: password!)
          .catchError((error) {
        if (error is FirebaseAuthException) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            error.message!,
            style: TypographyUtil.labelMedium(context),
          )));
        }
      });
    }
  }

  void submitLogOut(BuildContext context) {
    appStateProvider!.logOut().catchError((error) {
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

    return appStateProvider!.loggedIn()
        ? IconButton(
            onPressed: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                        title: Text('Log out',
                            style: TypographyUtil.titleLarge(context)),
                        actions: [
                          ElevatedButton(
                            onPressed: () => submitLogOut(context),
                            child: Text('OK',
                                style: TypographyUtil.labelMedium(context)),
                          ),
                          ElevatedButton(
                            onPressed: () => context.pop(),
                            child: Text('CANCEL',
                                style: TypographyUtil.labelMedium(context)),
                          )
                        ])),
            icon: const Icon(Icons.logout_outlined))
        : IconButton(
            onPressed: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                    title: Text('Log in',
                        style: TypographyUtil.titleLarge(context)),
                    actions: [
                      ElevatedButton(
                        onPressed: () => submitLogIn(context),
                        child: Text('OK',
                            style: TypographyUtil.labelMedium(context)),
                      ),
                      ElevatedButton(
                        onPressed: () => context.pop(),
                        child: Text('CANCEL',
                            style: TypographyUtil.labelMedium(context)),
                      )
                    ],
                    content: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextFormField(
                                  autofocus: true,
                                  onSaved: (value) => username = value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email address';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.person),
                                    labelStyle:
                                        TypographyUtil.titleMedium(context),
                                    labelText: 'Username',
                                    hintText: 'email address',
                                  )),
                              TextFormField(
                                  onSaved: (value) => password = value,
                                  onEditingComplete: () => submitLogIn(context),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.key),
                                    labelStyle:
                                        TypographyUtil.titleMedium(context),
                                    labelText: 'Password',
                                    hintText: 'password',
                                  )),
                            ])))),
            icon: const Icon(Icons.login_outlined));
  }
}
