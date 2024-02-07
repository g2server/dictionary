import 'package:dictionary/features/auth/data/auth_repository.dart';
import 'package:dictionary/features/auth/domain/app_user.dart';
import 'package:dictionary/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepository extends AuthRepository {
  final _supabase = Supabase.instance.client;
  final _authState = BehaviorSubject<AppUser?>.seeded(null);

  SupabaseAuthRepository() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
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
    var response = await _supabase.auth.signInWithPassword(
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
    await _supabase.auth.signOut();
    //_authState.value = null;
    return Future.value(null);
  }

  @override
  void dispose() async {
    await _authState.close();
  }

  @override
  Future<void> init() async {
    await dotenv.load(fileName: "secrets.env");
    var superbaseUrl = dotenv.env['SUPABASE_URL'];
    var superbaseApiKey = dotenv.env['SUPABASE_URL_API_KEY'];
    await Supabase.initialize(url: superbaseUrl!, anonKey: superbaseApiKey!);
    logger.i('supabase initialized');
  }
}
