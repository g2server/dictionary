import 'package:envied/envied.dart';

part 'prod_env.g.dart';

@Envied(path: 'env/prod.env')
abstract class ProdEnv {
  @EnviedField(varName: 'SUPABASE_URL', obfuscate: true)
  static String supabaseUrl = _ProdEnv.supabaseUrl;
  @EnviedField(varName: 'SUPABASE_URL_API_KEY', obfuscate: true)
  static String supabaseUrlApiKey = _ProdEnv.supabaseUrlApiKey;
}
