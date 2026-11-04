import 'package:flutter/foundation.dart';

import '../constants/enums.dart';

DeviceType getDeviceType() {
  if (kIsWeb) return DeviceType.web;
  return switch (defaultTargetPlatform) {
    TargetPlatform.android => DeviceType.android,
    TargetPlatform.iOS => DeviceType.ios,
    TargetPlatform.fuchsia => DeviceType.fuchsia,
    TargetPlatform.windows => DeviceType.windows,
    TargetPlatform.macOS => DeviceType.mac,
    TargetPlatform.linux => DeviceType.linux,
  };
}
