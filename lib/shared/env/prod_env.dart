import 'package:envied/envied.dart';

part 'prod_env.g.dart';

@Envied(path: 'env/prod.env')
abstract class ProdEnv {
  @EnviedField(varName: 'SUPABASE_URL')
  static const String supabaseUrl = _ProdEnv.supabaseUrl;
  @EnviedField(varName: 'SUPABASE_URL_API_KEY')
  static const String supabaseUrlApiKey = _ProdEnv.supabaseUrlApiKey;
}
