import 'package:dio/dio.dart';

enum HttpFailureType {
  Unknown,
  Unauthorized,
  Network,
  Api,
  ResponseParse,
}

class HttpFailure {
  const HttpFailure.unknown(this.path)
      : type = HttpFailureType.Unknown,
        code = null,
        message = '';

  const HttpFailure.unauthorized(this.path)
      : type = HttpFailureType.Unauthorized,
        code = 401,
        message = '';

  const HttpFailure.networkError(this.path)
      : type = HttpFailureType.Network,
        code = null,
        message = '';

  const HttpFailure.apiError(
    this.path,
    this.code,
    this.message,
  ) : type = HttpFailureType.Api;

  HttpFailure.responseParseError(
    this.path,
    Response response,
    Type expectedType,
  )   : type = HttpFailureType.ResponseParse,
        code = null,
        message =
            // ignore: avoid_dynamic_calls
            "ResponseParseError( cannot parse '${response.data?.runtimeType}' "
                "from '${response.requestOptions.method} $path'. expected: '$expectedType'\n"
                "'${response.data?.toString()} )'";

  final HttpFailureType type;
  final String path;
  final int? code;
  final String message;
}
