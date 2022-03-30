import 'package:cosmos_utils/app_info_extractor.dart';
import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/migrate_app_versions_failure.dart';

class MigrateAppVersionsUseCase {
  MigrateAppVersionsUseCase(this._plainDataStore);

  final PlainDataStore _plainDataStore;

  final String appVersionKey = 'app_version_key';

  Future<Either<MigrateAppVersionsFailure, Unit>> execute() async {
    final currentAppInfo = await getAppInfo();
    return _plainDataStore.readPlainText(key: appVersionKey).flatMap((appVersionInfo) async {
      if (appVersionInfo == null) {
        return _plainDataStore.savePlainText(
          key: appVersionKey,
          value: currentAppInfo.toMap(),
        );
      } else {
        if (AppInfo.fromMap(appVersionInfo).version < currentAppInfo.version) {
          // TODO: Add migration of keys


          return _plainDataStore.savePlainText(
            key: appVersionKey,
            value: currentAppInfo.toMap(),
          );
        }
      }

      return right(unit);
    }).mapError((fail) => const MigrateAppVersionsFailure.unknown());
  }
}
