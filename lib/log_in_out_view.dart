import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderland/app_state_provider.dart';

class LogInOutView extends StatelessWidget {
  const LogInOutView({super.key});

  @override
  Widget build(BuildContext context) {
              final appStateProvider = Provider.of<AppStateProvider>(context);

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        appStateProvider.loggedIn()
            ? Text(
                "Are you sure, ${appStateProvider.username()}?",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
              )
            : Text(
                'Please log in',
                style: Theme.of(context).textTheme.displaySmall,
              ),
        appStateProvider.loggedIn()
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    appStateProvider.logOut();
                  },
                  child: const Text('Log Out'),
                ))
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    appStateProvider.logIn('zh3w4ng@gmail.com', 'testtest');
                  },
                  child: const Text('Log In'),
                ))
      ],
    ));
  }
}
