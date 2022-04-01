import 'dart:convert';

import 'package:cosmos_utils/app_info_extractor.dart';
import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/migrate_app_versions_failure.dart';

class MigrateAppVersionsUseCase {
  MigrateAppVersionsUseCase(this._plainDataStore);

  final PlainDataStore _plainDataStore;

  // Kept it here for now, should be somewhere global or abstracted
  final String appVersionKey = 'app_version_key';

  Future<Either<MigrateAppVersionsFailure, Unit>> execute() async {
    final currentAppInfo = await getAppInfo();
    return _plainDataStore.readPlainText(key: appVersionKey).flatMap((appVersionInfo) async {
      if (appVersionInfo == null) {
        return _plainDataStore.savePlainText(
          key: appVersionKey,
          value: currentAppInfo.toJsonString(),
        );
      } else {
        if ((double.tryParse(AppInfo.fromJson(jsonDecode(appVersionInfo) as Map<String, dynamic>).version) ?? 0.0) <
            (double.tryParse(currentAppInfo.version) ?? 0.0)) {
          await _plainDataStore
              .readAllPlainText()
              .mapError((fail) => const MigrateAppVersionsFailure.unknown())
              .flatMap(
            (map) async {
              // TODO: Add migration
              return right(unit);
            },
          );

          return _plainDataStore.savePlainText(
            key: appVersionKey,
            value: currentAppInfo.toJsonString(),
          );
        }
      }

      return right(unit);
    }).mapError((fail) => const MigrateAppVersionsFailure.unknown());
  }
}
