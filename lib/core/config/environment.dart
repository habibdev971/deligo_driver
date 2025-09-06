import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvironmentType { dev, prod }

class Environment {
  static const String dev = 'development';
  static const String prod = 'production';
  static final String _baseUrl = dotenv.env['API_BASE_URL']!;

  static const EnvironmentType currentEnvironment = EnvironmentType.dev;

  static String? _overrideApiUrl;

  /// Allows runtime override of the API base URL
  static void setApiUrlOverride(String url) {
    _overrideApiUrl = url;
  }

  static String get apiUrl {
    if (_overrideApiUrl != null) return _overrideApiUrl!;
    switch (currentEnvironment) {
      case EnvironmentType.dev:
        return '$_baseUrl/api/';
      case EnvironmentType.prod:
        return '$_baseUrl/api/';
    }
  }

  static String get baseUrl {
    if (_overrideApiUrl != null) return _overrideApiUrl!;
    switch (currentEnvironment) {
      case EnvironmentType.dev:
        return _baseUrl;
      case EnvironmentType.prod:
        return _baseUrl;
    }
  }

}