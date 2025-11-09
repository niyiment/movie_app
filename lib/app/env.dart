
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get fileName => '.env';
  static String get appEnv => dotenv.get('APP_ENV');
  static bool get enableDebugLog => dotenv.get('ENABLE_DEBUG_LOG', 
    fallback: 'true').toLowerCase() == 'true';

  static bool get isDevelopment => appEnv == 'development';

  static bool get isProduction => appEnv == 'production';

  static String get tdbmiApiKey => dotenv.get('TMDBI_API_KEY');
  

}