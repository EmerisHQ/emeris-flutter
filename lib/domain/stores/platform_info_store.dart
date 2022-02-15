import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_app/domain/entities/operating_system.dart';

class PlatformInfoStore {
  OperatingSystem get operatingSystem {
    if (Platform.isIOS) {
      return OperatingSystem.iOS;
    } else if (Platform.isAndroid) {
      return OperatingSystem.Android;
    } else if (Platform.isMacOS) {
      return OperatingSystem.MacOS;
    } else if (Platform.isWindows) {
      return OperatingSystem.Windows;
    } else if (Platform.isLinux) {
      return OperatingSystem.Linux;
    } else if (kIsWeb) {
      return OperatingSystem.Web;
    } else {
      return OperatingSystem.Other;
    }
  }
}
