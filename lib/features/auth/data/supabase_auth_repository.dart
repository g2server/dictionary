import 'package:dictionary/features/auth/data/auth_repository.dart';
import 'package:dictionary/features/auth/domain/app_user.dart';
import 'package:dictionary/main.dart';
import 'package:dictionary/shared/env/prod_env.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepository extends AuthRepository {
  late SupabaseClient _supabaseClient;
  final _authState = BehaviorSubject<AppUser?>.seeded(null);

  @override
  BehaviorSubject<AppUser?> getStream() {
    return _authState;
  }

  @override
  AppUser? getUser() {
    return _authState.value;
  }

  @override
  Future<bool> signIn(AppUser user) async {
    var response = await _supabaseClient.auth.signInWithPassword(
      email: user.email,
      password: user.password!,
    );
    if (response.session == null) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
    return Future.value(null);
  }

  @override
  void dispose() async {
    await _supabaseClient.dispose();
    await _authState.close();
  }

  @override
  Future<void> init() async {
    _supabaseClient = (await Supabase.initialize(
            url: ProdEnv.supabaseUrl, anonKey: ProdEnv.supabaseUrlApiKey))
        .client;
    logger.i('supabase initialized');

    _supabaseClient.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.initialSession) {
        _authState.value = null;
      } else if (data.event == AuthChangeEvent.signedIn &&
          data.session != null) {
        _authState.value = AppUser(
          email: data.session?.user.email ?? '',
          uid: data.session?.user.id ?? '',
        );
      } else if (data.event == AuthChangeEvent.signedOut) {
        _authState.value = null;
      } else {
        logger.i('SupabaseRepository, onAuthStateChange, ${data.event}');
      }
    });
  }
}
