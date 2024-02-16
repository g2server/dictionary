import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test/robots/auth_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
    'sign in screen test to check for no user found',
    (tester) async {
      WidgetsFlutterBinding.ensureInitialized();

      final r = AuthRobot(tester);
      await r.pumpAccountScreen();
      r.expectToFindSignInForm();

      await r.unregisteredUserSignin();
      r.expectNoUserFound();
    },
  );

  testWidgets(
    'sign in screen test to sign in with a registered user',
    (tester) async {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

      final r = AuthRobot(tester);
      await r.pumpAccountScreen();
      r.expectToFindSignInForm();

      await r.tapSignInButton();
      r.expectNotToFindSignInForm();
    },
  );
}
