import 'package:envied/envied.dart';

part 'env.g.dart';

/// Required Environment
/// Available env params:
/// - `prod` for production
/// - `dev` for development
/// - `staging` for testing
const isDev = true;

@Envied(path: isDev ? '.env.dev' : '.env.production')
abstract class Env {
  @EnviedField(obfuscate: true, varName: 'SHOW_DEBUG_INFO')
  static bool showDebugInfo = _Env.showDebugInfo;

  @EnviedField(obfuscate: true, varName: 'API_ENDPOINT')
  static String apiEndpoint = _Env.apiEndpoint;

  @EnviedField(obfuscate: true, varName: 'STORAGE_USER_KEY')
  static String storageUserKey = _Env.storageUserKey;
}
