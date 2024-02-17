import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../robot.dart';

void main() {
  testWidgets(
    'sign in screen test to check for no user found',
    (tester) async {
      WidgetsFlutterBinding.ensureInitialized();

      final r = Robot(tester);
      await r.pumpMyApp();
      r.expectToFindSignInForm();

      await r.unregisteredUserSignin();
      r.expectNoUserFound();
    },
  );

  testWidgets(
    'sign in screen test to sign in with a registered user',
    (tester) async {
      WidgetsFlutterBinding.ensureInitialized();

      final r = Robot(tester);
      await r.pumpMyApp();
      r.expectToFindSignInForm();

      await r.tapSignInButton();
      r.expectNotToFindSignInForm();
    },
  );
}
