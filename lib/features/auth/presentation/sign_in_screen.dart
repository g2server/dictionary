import 'package:dictionary/features/auth/domain/app_user.dart';
import 'package:dictionary/providers/auth_repository_provider.dart';
import 'package:dictionary/providers/sign_in_screen_controller_provider.dart';
import 'package:dictionary/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInScreenControllerProvider);

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
              FilledButton(
                onPressed: state.isLoading
                    ? null
                    : () async {
                        await ref.read(authRepositoryProvider).signIn(
                            const AppUser(
                                uid: kAnonAppUserUid,
                                email: kAnonAppUserEmail));
                      },
                child: state.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Sign in anonymously'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
