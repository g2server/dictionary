import 'package:dictionary/features/auth/domain/app_user.dart';
import 'package:dictionary/features/auth/providers/auth_sign_in_screen_controller_provider.dart';
import 'package:dictionary/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: kAnonAppUserEmail,
                enabled: false,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              Consumer(builder: (context, ref, child) {
                final state = ref.watch(authSignInScreenControllerProvider);
                return state.when(data: (data) {
                  return Column(
                    children: [
                      FilledButton(
                        onPressed: () async {
                          ref
                              .read(authSignInScreenControllerProvider.notifier)
                              .signIn(
                                AppUser(
                                  uid: kAnonAppUserUid,
                                  email: kAnonAppUserEmail,
                                  password: kAnonAppUserPassword,
                                ),
                              );
                        },
                        child: const Text('Sign in anonymously'),
                      ),
                      Visibility(
                          visible: !(data ?? true),
                          child: const Text('No user found')),
                    ],
                  );
                }, error: (error, stackTrace) {
                  return Text('Error: $error');
                }, loading: () {
                  return const CircularProgressIndicator();
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
