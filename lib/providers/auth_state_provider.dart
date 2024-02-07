import 'package:dictionary/features/auth/domain/app_user.dart';
import 'package:dictionary/providers/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final authStateProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.getStream();
});
