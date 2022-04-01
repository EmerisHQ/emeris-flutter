import 'package:cosmos_utils/app_info_extractor.dart';
import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/migrate_app_versions_failure.dart';
import 'package:flutter_app/domain/stores/local_storage.dart';

class MigrateAppVersionsUseCase {
  MigrateAppVersionsUseCase(
    this._localStorage,
    this._appInfoProvider,
    this.migrationSteps,
  );

  final AppInfoProvider _appInfoProvider;
  final LocalStorage _localStorage;
  final List<MigrationStep> migrationSteps;

  // Kept it here for now, should be somewhere global or abstracted
  final String appVersionKey = 'app_version_key';

  Future<Either<MigrateAppVersionsFailure, Unit>> execute() async {
    final currentAppInfo = await getAppInfo();
    final appInfoResult = await _getSavedAppInfo();
    if (appInfoResult.isLeft()) {
      return appInfoResult.map((_) => unit);
    }
    final appInfo = appInfoResult.getOrElse(() => currentAppInfo.copyWith(buildNumber: '0'));

    // get only migrations that are applicable to the previously-saved buildNumber versions.
    final migrations = migrationSteps //
        .where((it) => it.shouldMigrate(appInfo.buildNumberInt));

    return Stream.fromIterable(migrations)
        // after each migration, lets increment the build number so that we don't run the same migration ever again
        .asyncMap((event) => event.migrate().flatMap((a) => _saveAppInfo(
              appInfo,
              newBuildNumber: event.fromBuildNumber,
            )))
        // apply migrations sequentially and stop on the first error occurrence
        .firstWhere(
          (element) => element.isLeft(),
          orElse: () => right(unit),
        )
        .flatMap((_) async => _saveAppInfo(currentAppInfo));
  }

  Future<Either<dynamic, Unit>> _saveAppInfo(AppInfo appInfo, {required int newBuildNumber}) {
    return _localStorage
        .save(
          AppInfoCodec.key,
          AppInfoCodec(),
          appInfo.copyWith(
            buildNumber: newBuildNumber.toString(),
          ),
        )
        .mapError((fail) => const MigrateAppVersionsFailure.unknown());
  }

  Future<Either<MigrateAppVersionsFailure, AppInfo?>> _getSavedAppInfo() {
    return _localStorage
        .read(AppInfoCodec.key, AppInfoCodec())
        .mapError((fail) => const MigrateAppVersionsFailure.unknown());
  }
}

abstract class MigrationStep {
  const MigrationStep({
    required this.fromBuildNumber,
  });

  /// from which build number should this migration take place, for example:
  /// if previous app version was 1, and [fromBuildNumber] is 2. then this migration WILL run
  /// if previous app version was 2, and [fromBuildNumber] is 2. then this migration WILL NOT run
  final int fromBuildNumber;

  bool shouldMigrate(int buildNumber) {
    return fromBuildNumber >= buildNumber;
  }

  Future<Either<MigrateAppVersionsFailure, Unit>> migrate();
}
