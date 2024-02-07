import 'package:dictionary/features/auth/presentation/sign_in_screen.dart';
import 'package:dictionary/features/auth/providers/auth_state_provider.dart';
import 'package:dictionary/features/dictionary/presentation/dictionary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (user) {
        if (user == null) {
          return const SignInScreen();
        } else {
          return const DictionaryScreen();
        }
      },
      error: (error, stackTrace) {
        return Center(
          child: Text('Error: $error'),
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
