import 'package:envied/envied.dart';

part 'test_env.g.dart';

@Envied(path: 'env/test.env')
abstract class TestEnv {
  @EnviedField(varName: 'SUPABASE_URL', obfuscate: true)
  static String supabaseUrl = _TestEnv.supabaseUrl;
  @EnviedField(varName: 'SUPABASE_URL_API_KEY', obfuscate: true)
  static String supabaseUrlApiKey = _TestEnv.supabaseUrlApiKey;
}
