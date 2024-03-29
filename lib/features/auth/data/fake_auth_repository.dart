import 'package:dictionary/features/auth/data/auth_repository.dart';
import 'package:dictionary/features/auth/domain/app_user.dart';
import 'package:dictionary/main.dart';
import 'package:dictionary/shared/constants.dart';
import 'package:rxdart/subjects.dart';

class FakeAuthRepository extends AuthRepository {
  final _authState = BehaviorSubject<AppUser?>.seeded(null);

  @override
  Future<void> signOut() async {
    logger.i('FakeAuthRepository, signOut()');

    _authState.value = null;
  }

  @override
  Future<bool> signIn(AppUser user) async {
    logger.i('FakeAuthRepository, signIn()');
    //await Future.delayed(const Duration(milliseconds: 500));
    if (user.email == kAnonAppUserEmail &&
        user.password == kAnonAppUserPassword) {
      _authState.value = user;
      return true;
    } else {
      return false;
    }
  }

  @override
  BehaviorSubject<AppUser?> getStream() {
    logger.i('FakeAuthRepository, getStream()');
    return _authState;
  }

  @override
  AppUser? getUser() {
    return _authState.value;
  }

  @override
  void dispose() async {
    await _authState.close();
  }

  @override
  Future<void> init() {
    return Future.value(null);
  }
}
