import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dotenv access test', () async {
    await dotenv.load(fileName: "mock_env.env");
    var secretApiKey = dotenv.env['SOME_SECRET_API_KEY'];
    expect(secretApiKey, 'foo');
  });
}
