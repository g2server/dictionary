import 'package:dictionary/features/auth/data/auth_repository.dart';
import 'package:dictionary/features/auth/domain/app_user.dart';
import 'package:dictionary/features/auth/providers/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

@riverpod
Stream<AppUser?> authState(AuthStateRef ref) {
  final AuthRepository authRepository =
      ref.watch(authRepositoryProvider).requireValue;
  return authRepository.getStream();
}
