import 'package:dictionary/features/auth/data/auth_repository.dart';
import 'package:dictionary/features/auth/data/fake_auth_repository.dart';
import 'package:dictionary/features/auth/providers/auth_repository_bootstrap_provider.dart';
import 'package:dictionary/features/dictionary/data/fake_dictionary_repository.dart';
import 'package:dictionary/features/dictionary/providers/dictionary_repository_bootstrap_provider.dart';
import 'package:dictionary/features/startup/app_startup.dart';
import 'package:dictionary/features/startup/providers/app_startup_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  testWidgets(
    'app startup child build test',
    (tester) async {
      WidgetsFlutterBinding.ensureInitialized();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dictionaryRepositoryBootstrapProvider.overrideWithValue(
              FakeDictionaryRepository(),
            ),
            authRepositoryBootstrapProvider.overrideWithValue(
              FakeAuthRepository(),
            ),
          ],
          child: const AppStartup(
            child: Text('AppStartup OK'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.textContaining('AppStartup OK'), findsOneWidget);
    },
  );

  testWidgets(
    'app startup appStartupControllerProvider exception test',
    (tester) async {
      WidgetsFlutterBinding.ensureInitialized();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dictionaryRepositoryBootstrapProvider.overrideWithValue(
              FakeDictionaryRepository(),
            ),
            authRepositoryBootstrapProvider.overrideWithValue(
              FakeAuthRepository(),
            ),
            appStartupControllerProvider.overrideWith(
              () {
                throw Exception('appStartupControllerProvider error');
              },
            ),
          ],
          child: const AppStartup(
            child: Text('AppStartup OK'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.textContaining('appStartupControllerProvider error'),
          findsOneWidget);
    },
  );

  testWidgets(
    'app startup mockAuthRepository.init() exception test',
    (tester) async {
      WidgetsFlutterBinding.ensureInitialized();
      var mockAuthRepository = MockAuthRepository();

      when(() {
        mockAuthRepository.init();
      }).thenThrow(Exception('mockAuthRepository error'));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dictionaryRepositoryBootstrapProvider.overrideWithValue(
              FakeDictionaryRepository(),
            ),
            authRepositoryBootstrapProvider.overrideWithValue(
              mockAuthRepository,
            ),
          ],
          child: const AppStartup(
            child: Text('AppStartup OK'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.textContaining('mockAuthRepository error'), findsOneWidget);
    },
  );

  testWidgets(
    'appStartupController loading test',
    (tester) async {
      WidgetsFlutterBinding.ensureInitialized();

      WidgetsFlutterBinding.ensureInitialized();
      var appStartupController = AppStartupController();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dictionaryRepositoryBootstrapProvider.overrideWithValue(
              FakeDictionaryRepository(),
            ),
            authRepositoryBootstrapProvider.overrideWithValue(
              FakeAuthRepository(),
            ),
            appStartupControllerProvider.overrideWith(() {
              return appStartupController;
            })
          ],
          child: const AppStartup(
            child: Text('AppStartup OK'),
          ),
        ),
      );

      await tester.pump();
      expect(appStartupController.state, const AsyncLoading<void>());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
      expect(appStartupController.state, const AsyncData<void>(null));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    },
  );
}
