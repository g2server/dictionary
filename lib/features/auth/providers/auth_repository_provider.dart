import 'package:dictionary/features/auth/data/auth_repository.dart';
import 'package:dictionary/features/auth/providers/auth_repository_bootstrap_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@riverpod
Future<AuthRepository> authRepository(AuthRepositoryRef ref) async {
  var provider = ref.watch(authRepositoryBootstrapProvider);
  await provider.init();
  ref.onDispose(() {
    provider.dispose();
  });
  return provider;
}
