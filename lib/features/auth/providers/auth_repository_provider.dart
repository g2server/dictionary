import 'package:dictionary/features/auth/data/auth_repository.dart';
import 'package:dictionary/features/auth/data/fake_auth_repository.dart';
import 'package:dictionary/features/auth/data/supabase_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  // note: this is being eagerly initialized in main
  throw UnimplementedError();
}
