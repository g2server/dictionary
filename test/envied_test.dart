import 'package:dictionary/shared/env/test_env.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('envied access test', () async {
    expect(TestEnv.supabaseUrl, 'foo');
  });
}
