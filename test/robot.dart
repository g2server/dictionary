import 'dart:async';

import 'package:dictionary/features/auth/data/fake_auth_repository.dart';
import 'package:dictionary/features/auth/domain/app_user.dart';
import 'package:dictionary/features/auth/presentation/auth_screen.dart';
import 'package:dictionary/features/auth/presentation/sign_in_screen.dart';
import 'package:dictionary/features/auth/providers/auth_repository_bootstrap_provider.dart';
import 'package:dictionary/features/auth/providers/auth_sign_in_screen_controller_provider.dart';
import 'package:dictionary/features/dictionary/data/fake_dictionary_repository.dart';
import 'package:dictionary/features/dictionary/providers/dictionary_repository_bootstrap_provider.dart';
import 'package:dictionary/features/startup/app_startup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class Robot {
  Robot(this.tester);
  final WidgetTester tester;

  Future<void> pumpMyApp() async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dictionaryRepositoryBootstrapProvider.overrideWithValue(
            FakeDictionaryRepository(),
          ),
          authRepositoryBootstrapProvider.overrideWithValue(
            FakeAuthRepository(),
          )
        ],
        child: const AppStartup(
          child: AuthScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> tapSignInButton() async {
    final filledButton = find.byType(FilledButton);
    expect(filledButton, findsOneWidget);
    await tester.tap(filledButton);
    await tester.pumpAndSettle();
  }

  Future<void> unregisteredUserSignin() async {
    // https://stackoverflow.com/questions/54021267/test-breaks-when-using-future-delayed
    await tester.runAsync(
      () async {
        final context = tester.element(find.byType(SignInScreen));
        final ref = ProviderScope.containerOf(context);
        await ref.read(authSignInScreenControllerProvider.notifier).signIn(
            AppUser(email: 'no_user', password: 'no_user', uid: 'no_user'));
      },
    );
    await tester.pumpAndSettle();
  }

  void expectNoUserFound() {
    expect(find.textContaining('No user found'), findsOneWidget);
  }

  void expectToFindSignInForm() {
    expect(find.byType(SignInScreen), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.textContaining('No user found'), findsNothing);
  }

  void expectNotToFindSignInForm() {
    expect(find.byType(SignInScreen), findsNothing);
  }
}
