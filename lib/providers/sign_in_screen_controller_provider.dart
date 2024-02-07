import 'package:dictionary/features/auth/domain/app_user.dart';
import 'package:dictionary/providers/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_screen_controller_provider.g.dart';

@riverpod
class SignInScreenController extends _$SignInScreenController {
  @override
  FutureOr<void> build() {}

  Future<void> signIn(AppUser user) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.signIn(user);
    state = const AsyncData(null);
  }
}
