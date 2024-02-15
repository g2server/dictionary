import 'package:envied/envied.dart';

part 'test_env.g.dart';

@Envied(path: 'env/test.env')
abstract class TestEnv {
  @EnviedField(varName: 'SUPABASE_URL')
  static const String supabaseUrl = _TestEnv.supabaseUrl;
  @EnviedField(varName: 'SUPABASE_URL_API_KEY')
  static const String supabaseUrlApiKey = _TestEnv.supabaseUrlApiKey;
}
