class AppConfig {
  static const currentVersion = '1.0.0';
  static const bool https = true;
  static const String publicFolder = "public";
  static const String protocol = https ? "https://" : "http://";
  static const String rawBaseUrl = "$protocol$domainPath";
  static const String basePath = "$rawBaseUrl/$apiEndPath";
  static const domainPath = "api.prabashibd.com/";
  static const String apiEndPath = "api/v1/";

  static const imageBasePath = "https://api.prabashibd.com/uploads/";
  static const releaseDate = '050125';

}
