import 'package:dio/dio.dart';
import 'package:flutter_app/environment_config.dart';

class DioBuilder {
  DioBuilder(this._environmentConfig);

  final EnvironmentConfig _environmentConfig;

  Dio build() => Dio(
        BaseOptions(
          baseUrl: _environmentConfig.emerisBackendApiUrl,
        ),
      );
}
