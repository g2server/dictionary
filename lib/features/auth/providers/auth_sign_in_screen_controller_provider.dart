import 'package:dictionary/features/auth/domain/app_user.dart';
import 'package:dictionary/features/auth/providers/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_sign_in_screen_controller_provider.g.dart';

@riverpod
class AuthSignInScreenController extends _$AuthSignInScreenController {
  @override
  AsyncValue<bool?> build() {
    return const AsyncData(null);
  }

  Future<void> signIn(AppUser user) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    await Future.delayed(const Duration(seconds: 1));
    state = await AsyncValue.guard<bool>(() {
      return authRepository.signIn(user);
    });
  }
}
