import 'dart:io' show Platform;

/// Where the JAMIA backend is.
/// The iPhone simulator reaches this Mac as "localhost";
/// the Android emulator reaches it as "10.0.2.2".
class ApiConfig {
  static const int _port = 8095;

  static String get baseUrl {
    final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
    return 'http://$host:$_port';
  }
}
