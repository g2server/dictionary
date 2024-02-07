import 'dart:async';

import 'package:dictionary/app.dart';
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

    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  }, (error, stackTrace) {
    logger.e('runZonedGuarded: ${error.toString()}');
  });
}
