import 'package:dictionary/features/auth/domain/app_user.dart';
import 'package:dictionary/features/auth/providers/auth_repository_provider.dart';
import 'package:dictionary/shared/notifier_mounted_mixin.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_sign_in_screen_controller_provider.g.dart';

@riverpod
class AuthSignInScreenController extends _$AuthSignInScreenController
    with NotifierMounted {
  @override
  AsyncValue<AuthSignInScreenControllerState> build() {
    ref.onDispose(setUnmounted);
    return const AsyncData(AuthSignInScreenControllerState.initial);
  }

  Future<void> signIn(AppUser user) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider).requireValue;

    try {
      var success = await authRepository.signIn(user);
      if (mounted) {
        if (success) {
          state =
              const AsyncData(AuthSignInScreenControllerState.signInSuccess);
        } else {
          state = const AsyncData(AuthSignInScreenControllerState.noUserFound);
        }
      }
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

enum AuthSignInScreenControllerState {
  initial,
  signInSuccess,
  noUserFound,
}
