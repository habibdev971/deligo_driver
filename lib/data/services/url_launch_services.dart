import 'package:deligo_driver/core/utils/helpers.dart';
import 'package:url_launcher/url_launcher.dart';


class UrlLaunchServices{

  static void launchDialer(String? phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      showNotification(message: 'Could not open dialer');
      // throw 'Could not open dialer';
    }
  }

  static Future<void> launchUrls(String? url) async {
    if (url == null) return;
    final Uri uri = Uri.parse(url);

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        showNotification(message: 'Could not open URL');
      }
    } catch (e) {
      showNotification(message: 'Error: $e');
    }
  }

}