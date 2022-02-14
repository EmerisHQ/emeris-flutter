import 'package:dio/dio.dart';

enum HttpFailureType {
  Unknown,
  Unauthorized,
  Network,
  Api,
  ResponseParse,
}

class HttpFailure {
  const HttpFailure.unknown(
    this.path, [
    this.cause,
  ])  : type = HttpFailureType.Unknown,
        code = null,
        message = '';

  const HttpFailure.unauthorized(
    this.path, [
    this.cause,
  ])  : type = HttpFailureType.Unauthorized,
        code = 401,
        message = '';

  const HttpFailure.networkError(
    this.path, [
    this.cause,
  ])  : type = HttpFailureType.Network,
        code = null,
        message = '';

  const HttpFailure.apiError(
    this.path,
    this.code,
    this.message, [
    this.cause,
  ]) : type = HttpFailureType.Api;

  HttpFailure.responseParseError(
    this.path,
    Response response,
    Type expectedType, [
    this.cause,
  ])  : type = HttpFailureType.ResponseParse,
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
  final dynamic cause;

  @override
  String toString() {
    return 'HttpFailure{type: $type, path: $path, code: $code\nmessage: $message\ncause: $cause}';
  }
}
