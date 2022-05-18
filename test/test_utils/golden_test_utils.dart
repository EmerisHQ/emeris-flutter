import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:cosmos_ui_components/cosmos_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:meta/meta.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'golden_test_device_scenario.dart';
import 'test_utils.dart';

final testDevices = [
  Device.phone.copyWith(name: 'small phone'),
  Device.iphone11.copyWith(name: 'iPhone 11'),
];

final testThemes = {
  'light': const CosmosThemeData(),
  'dark': cosmosDarkThemeData,
};

@isTest
Future<void> screenshotTest(
  String description, {
  required Widget Function(CosmosThemeData themeData) pageBuilder,
  bool skip = false,
  void Function()? setUp,
  List<String> tags = const ['golden'],
  List<Device>? devices,
  Map<String, CosmosThemeData>? themes,
  Duration timeout = const Duration(seconds: 5),
}) async {
  setUp?.call();
  return goldenTest(
    description,
    fileName: description,
    builder: () => GoldenTestGroup(
      children: (devices ?? testDevices) //
          .expand(
            (device) => (themes ?? testThemes).entries.map(
                  (entry) => ScreenshotTestVariant(
                    device: device,
                    theme: entry.value,
                    themeName: entry.key,
                  ),
                ),
          )
          .map(
            (variant) => DefaultAssetBundle(
              bundle: TestAssetBundle(),
              child: GoldenTestDeviceScenario(
                device: variant.device,
                builder: () => pageBuilder(variant.theme),
                suffix: variant.themeName,
              ),
            ),
          )
          .toList(),
    ),
    tags: tags,
    skip: skip,
    pumpBeforeTest: (tester) => mockNetworkImages(() => precacheImages(tester)).timeout(timeout),
    pumpWidget: (tester, widget) => mockNetworkImages(() => tester.pumpWidget(widget)).timeout(timeout),
  ).timeout(timeout);
}

Future<void> prepareAppForUnitTests() async {
  strings = AppLocalizationsEn();
  await configureDependenciesForTests();
}

class ScreenshotTestVariant {
  ScreenshotTestVariant({
    required this.device,
    required this.theme,
    required this.themeName,
  });

  final Device device;
  final CosmosThemeData theme;
  final String themeName;
}
