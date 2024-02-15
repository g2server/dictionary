import 'package:dictionary/features/auth/providers/auth_repository_provider.dart';
import 'package:dictionary/features/dictionary/providers/dictionary_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_startup_controller_provider.g.dart';

@riverpod
class AppStartupController extends _$AppStartupController {
  @override
  Future<void> build() async {
    // approach:
    // https://codewithandrea.com/articles/robust-app-initialization-riverpod/
    ref.onDispose(() {
      ref.invalidate(dictionaryRepositoryProvider);
      ref.invalidate(authRepositoryProvider);
    });
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    await ref.watch(dictionaryRepositoryProvider.future);
    await ref.watch(authRepositoryProvider.future);
  }
}
