import 'package:dictionary/features/auth/domain/app_user.dart';
import 'package:rxdart/subjects.dart';

abstract class AuthRepository {
  /// Signs out the current user.
  ///
  /// Returns a [Future] that completes when the sign out process is finished.
  Future<void> signOut();

  /// Signs in the specified [user] and returns a [Future] that completes with a [bool] value indicating whether the sign-in was successful.
  ///
  /// The [user] parameter represents the user to be signed in.
  ///
  /// Example usage:
  /// ```dart
  /// AppUser user = AppUser();
  /// bool success = await signIn(user);
  /// ```
  Future<bool> signIn(AppUser user);

  /// Returns a [BehaviorSubject] that emits the current [AppUser] and subsequent updates.
  ///
  /// The [BehaviorSubject] can be used to listen to changes in the authenticated user's state.
  ///
  /// Returns:
  /// - [BehaviorSubject<AppUser?>]: A [BehaviorSubject] that emits the current [AppUser] and subsequent updates.
  BehaviorSubject<AppUser?> getStream();

  /// Retrieves the currently authenticated user.
  ///
  /// Returns the [AppUser] object representing the currently authenticated user,
  /// or null if no user is authenticated.
  AppUser? getUser();

  /// Disposes of any resources used by the [AuthRepository].
  void dispose();

  /// Initializes the authentication repository.
  /// This method should be called before using any other methods in the repository.
  /// It sets up the necessary configurations and resources for authentication.
  /// Throws an exception if initialization fails.
  Future<void> init();
}
