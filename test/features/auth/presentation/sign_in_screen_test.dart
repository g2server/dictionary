import 'package:dictionary/app.dart';
import 'package:dictionary/features/auth/data/fake_auth_repository.dart';
import 'package:dictionary/features/auth/domain/app_user.dart';
import 'package:dictionary/features/auth/providers/auth_repository_provider.dart';
import 'package:dictionary/features/auth/providers/auth_sign_in_screen_controller_provider.dart';
import 'package:dictionary/features/dictionary/data/fake_dictionary_repository.dart';
import 'package:dictionary/features/dictionary/providers/dictionary_repository_provider.dart';
import 'package:dictionary/shared/logging/basic_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dictionary/features/auth/presentation/sign_in_screen.dart';

void main() {
  testWidgets(
    'sign in screen test to check for no user found',
    (tester) async {
      WidgetsFlutterBinding.ensureInitialized();

      var dictionaryRepo = FakeDictionaryRepository();
      await dictionaryRepo.init();

      var authRepo = FakeAuthRepository();
      await authRepo.init();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dictionaryRepositoryProvider.overrideWithValue(
              dictionaryRepo,
            ),
            authRepositoryProvider.overrideWithValue(
              authRepo,
            ),
          ],
          child: const MaterialApp(home: SignInScreen()),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(SignInScreen), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.textContaining('No user found'), findsNothing);

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
      expect(find.textContaining('No user found'), findsOneWidget);
    },
  );
}
