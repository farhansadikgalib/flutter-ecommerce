import 'package:flutter_dotenv/flutter_dotenv.dart';
class AppConfig {
  static String get currentVersion => dotenv.get('CURRENT_VERSION', fallback: '');
  static bool get https => dotenv.get('HTTPS', fallback: 'true') == 'true';
  static String get publicFolder => dotenv.get('PUBLIC_FOLDER', fallback: 'public');
  static String get protocol => https ? "https://" : "http://";
  static String get domainPath => dotenv.get('DOMAIN_PATH', fallback: '');
  static String get apiEndPath => dotenv.get('API_END_PATH', fallback: '');
  static String get rawBaseUrl => "$protocol$domainPath";
  static String get basePath => "$rawBaseUrl/$apiEndPath";
  static String get imageBasePath => dotenv.get('IMAGE_BASE_PATH', fallback: '');
  static String get releaseDate => dotenv.get('RELEASE_DATE', fallback: '');
}