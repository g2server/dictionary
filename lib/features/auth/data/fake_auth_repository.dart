import 'package:dictionary/features/auth/data/auth_repository.dart';
import 'package:dictionary/features/auth/domain/app_user.dart';
import 'package:rxdart/subjects.dart';

class FakeAuthRepository extends AuthRepository {
  final _authState = BehaviorSubject<AppUser?>.seeded(null);

  @override
  Future<void> signOut() async {
    _authState.value = null;
  }

  @override
  Future<void> signIn(AppUser user) async {
    //await Future.delayed(const Duration(seconds: 1));
    _authState.value = user;
  }

  @override
  BehaviorSubject<AppUser?> getStream() {
    return _authState;
  }

  @override
  AppUser? getUser() {
    return _authState.value;
  }

  void dispose() => _authState.close();
}
