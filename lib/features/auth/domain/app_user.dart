class AppUser {
  AppUser({
    required this.uid,
    required this.email,
    this.password,
  });
  final String uid;
  final String email;
  String? password;
}
