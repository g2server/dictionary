import 'package:dictionary/features/auth/domain/app_user.dart';
import 'package:rxdart/subjects.dart';

abstract class AuthRepository {
  Future<void> signOut();

  Future<void> signIn(AppUser user);

  BehaviorSubject<AppUser?> getStream();

  AppUser? getUser();
}
