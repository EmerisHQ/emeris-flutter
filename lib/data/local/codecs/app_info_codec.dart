import 'package:cosmos_utils/app_info_extractor.dart';
import 'package:flutter_app/domain/stores/local_storage.dart';

class AppInfoCodec implements LocalStorageCodec<AppInfo> {
  static const key = 'app_info';

  @override
  AppInfo? decode(String? encoded) => encoded == null ? null : decodeJsonString(encoded, AppInfo.fromJson);

  @override
  String encode(AppInfo object) => object.toJsonString();
}
