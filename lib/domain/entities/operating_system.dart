enum OperatingSystem {
  Android,
  iOS,
  MacOS,
  Windows,
  Linux,
  Web,
  Other,
}

extension OperatingSystemExt on OperatingSystem {
  bool get isIcloudAvailable => this == OperatingSystem.iOS || this == OperatingSystem.MacOS;
}
