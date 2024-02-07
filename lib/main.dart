import 'dart:async';

import 'package:dictionary/app.dart';
import 'package:dictionary/features/auth/data/fake_auth_repository.dart';
import 'package:dictionary/features/auth/data/supabase_auth_repository.dart';
import 'package:dictionary/features/auth/providers/auth_repository_provider.dart';
import 'package:dictionary/features/dictionary/data/dictionaryapi/dictionaryapi_repository.dart';
import 'package:dictionary/features/dictionary/data/mock_dictionary_repository.dart';
import 'package:dictionary/features/dictionary/providers/dictionary_repository_provider.dart';
import 'package:dictionary/shared/logging/pretty_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//var logger = BasicLogger();
var logger = PrettyLogger();

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // TODO. consider moving async app init logic out of main and into a "app startup" widget
    // so errors can be retried.
    // see https://codewithandrea.com/articles/robust-app-initialization-riverpod/
    await logger.init();
    logger.i('logger initialized');

    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      logger.e('FlutterError.onError: ${details.exceptionAsString()}');
    };

    //var dictionaryRepository = MockDictionaryRepository();
    var dictionaryRepository = DictionaryApiRepository();
    await dictionaryRepository.init();

    //final auth = SupabaseRepository();
    final auth = FakeAuthRepository();
    await auth.init();

    runApp(
      ProviderScope(
        overrides: [
          dictionaryRepositoryProvider.overrideWithValue(dictionaryRepository),
          authRepositoryProvider.overrideWith(
            (ref) {
              ref.onDispose(() => auth.dispose());
              return auth;
            },
          )
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stackTrace) {
    logger.e('runZonedGuarded: ${error.toString()}');
  });
}
