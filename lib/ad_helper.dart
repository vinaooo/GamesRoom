import 'dart:io';
import 'dart:core';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4860380403931913/4313648864';
    }
    throw UnsupportedError("Unsupported platform");
  }
}
