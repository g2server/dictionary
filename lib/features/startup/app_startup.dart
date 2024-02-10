import 'package:dictionary/features/startup/providers/app_startup_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This widget is responsible for eagerly initializing async riverpod providers.
/// and any other async logic that needs to be executed before the app is ready.
///
/// https://codewithandrea.com/articles/robust-app-initialization-riverpod/
class AppStartup extends ConsumerWidget {
  const AppStartup({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupControllerProvider);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: appStartupState.when(
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            data: (data) {
              return child;
            },
            error: (error, stackTrace) {
              return Center(
                child: TextButton(
                  onPressed: () {
                    ref.invalidate(appStartupControllerProvider);
                  },
                  child: Text('Retry (error: $error)'),
                ),
              );
            },
          ),
        ));
  }
}
