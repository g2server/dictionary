import 'dart:async';
import 'package:dictionary/features/auth/data/fake_auth_repository.dart';
import 'package:dictionary/features/auth/presentation/auth_screen.dart';
import 'package:dictionary/features/auth/providers/auth_repository_bootstrap_provider.dart';
import 'package:dictionary/features/dictionary/data/dictionaryapi/dictionaryapi_repository.dart';
import 'package:dictionary/features/dictionary/providers/dictionary_repository_bootstrap_provider.dart';
import 'package:dictionary/features/startup/app_startup.dart';
import 'package:dictionary/shared/logging/app_logger.dart';
import 'package:dictionary/shared/logging/basic_logger.dart';
import 'package:dictionary/shared/logging/pretty_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AppLogger logger = BasicLogger();

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await logger.init();
    logger.i('logger initialized');

    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      logger.e('FlutterError.onError: ${details.exceptionAsString()}');
    };

    runApp(
      ProviderScope(
        overrides: [
          dictionaryRepositoryBootstrapProvider.overrideWithValue(
            DictionaryApiRepository(),
          ),
          authRepositoryBootstrapProvider.overrideWithValue(
            FakeAuthRepository(),
          ),
        ],
        child: const AppStartup(
          child: AuthScreen(),
        ),
      ),
    );
  }, (error, stackTrace) {
    logger.e('runZonedGuarded: ${error.toString()}');
  });
}
