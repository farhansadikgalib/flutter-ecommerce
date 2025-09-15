import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String webURL, bool launchModeExternal) async {
  final url = Uri.parse(webURL);
  if (!await launchUrl(url, mode: launchModeExternal?LaunchMode.externalApplication :LaunchMode
      .inAppWebView)) {
    throw Exception('Could not launch $url');
  }
}
