import 'package:dictionary/app.dart';
import 'package:dictionary/shared/logging/pretty_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//var logger = BasicLogger();
var logger = PrettyLogger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await logger.init();
  logger.i('logger initialized');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
