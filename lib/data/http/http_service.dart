// ignore_for_file: avoid_returning_this

import 'dart:convert';

import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/data/http/http_failure.dart';

class HttpService {
  const HttpService(this._dio);

  final Dio _dio;

  RequestBuilder get(String path) => RequestBuilder(_dio, path, method: 'GET');

  RequestBuilder post(String path) => RequestBuilder(_dio, path, method: 'POST');

  RequestBuilder put(String path) => RequestBuilder(_dio, path, method: 'PUT');

  RequestBuilder delete(String path) => RequestBuilder(_dio, path, method: 'DELETE');
}

class RequestBuilder {
  RequestBuilder(
    this._dio,
    this.path, {
    required this.method,
  });

  final Dio _dio;
  final String path;
  final String method;
  final Map<String, List<dynamic>> _queryParams = {};
  final Map<String, List<dynamic>> _headers = {};
  dynamic _body;
  String? _responseSubKey;

  RequestBuilder body(dynamic value) {
    _body = value;
    return this;
  }

  RequestBuilder responseSubKey(String value) {
    _responseSubKey = value;
    return this;
  }

  RequestBuilder queryParam(
    String key,
    dynamic value, {
    bool override = true,
  }) {
    if (override) {
      _queryParams[key] = [];
    } else {
      _queryParams[key] ??= [];
    }
    _queryParams[key]?.add(value);
    return this;
  }

  RequestBuilder header(
    String key,
    dynamic value, {
    bool override = true,
  }) {
    if (override) {
      _headers[key] = [];
    } else {
      _headers[key] ??= [];
    }
    _headers[key]?.add(value);
    return this;
  }

  Future<Either<HttpFailure, Response<T>>> _execute<T>() async {
    final body = await _encodeBody();
    try {
      return right(
        await _dio.request<T>(
          path,
          data: body,
          queryParameters: _flattenMap(_queryParams),
          options: Options(
            method: method,
            headers: _flattenMap(_headers),
          ),
        ),
      );
    } catch (e, stack) {
      logError(e, stack);
      if (isNetworkError(e)) {
        return left(HttpFailure.networkError(path, e));
      } else if (e is DioError) {
        if (e.response?.statusCode == 401) {
          final failure = HttpFailure.unauthorized(path, e);
          return left(failure);
        } else {
          final apiFailure = HttpFailure.apiError(
            path,
            e.response?.statusCode,
            e.response?.statusMessage ?? '',
            e,
          );
          return left(apiFailure);
        }
      }
      logError(e, stack);
    }
    return left(HttpFailure.unknown(path));
  }

  Future<Either<HttpFailure, List<T>>> executeList<T>(
    T Function(Map<String, dynamic> json) itemMapper,
  ) async =>
      _execute().flatMap((response) async {
        final data = _getData(response) ?? [];
        if (data is! List) {
          return left(HttpFailure.responseParseError(path, response, typeOf<List>()));
        }
        return right(data.map((e) => itemMapper(e as Map<String, dynamic>)).toList());
      });

  Future<Either<HttpFailure, List<T>>> executeListPrimitive<T>() async => //
      _execute().flatMap((response) async {
        final data = _getData(response);
        if (data is! List) {
          return left(HttpFailure.responseParseError(path, response, typeOf<List>()));
        }
        return right(data.cast());
      });

  Future<Either<HttpFailure, T>> execute<T>(
    T Function(Map<String, dynamic> json) mapper,
  ) async =>
      _execute().flatMap((response) async {
        final data = _getData(response);
        if (data is! Map<String, dynamic>) {
          return left(HttpFailure.responseParseError(path, response, typeOf<Map<String, dynamic>>()));
        }
        return right(mapper(data));
      });

  Future<Either<HttpFailure, T>> executePrimitive<T>() async => _execute().flatMap(
        (response) async {
          final data = _getData(response);
          if (data is! T) {
            return left(HttpFailure.responseParseError(path, response, typeOf<T>()));
          }
          return right(data);
        },
      );

  Future<Either<HttpFailure, Unit>> executeUnit() async => (await _execute<dynamic>()).map((r) => unit);

  Future<dynamic> _encodeBody() async {
    if (_body == null) {
      return null;
    } else if (_body is String) {
      return _body.toString();
    } else if (_body is Map<String, dynamic>) {
      return compute(jsonEncode, _body);
    } else if (_body is List) {
      return compute(jsonEncode, _body);
    } else if (_body is FormData) {
      return _body;
    } else {
      // ignore: avoid_dynamic_calls
      return compute(jsonEncode, _body.toJson() as Map<String, dynamic>);
    }
  }

  Map<String, dynamic> _flattenMap(Map<String, List<dynamic>> map) {
    final result = {...map}..removeWhere((key, value) => value.isEmpty);
    return result.map((key, value) {
      if (value.length == 1) {
        return MapEntry(key, value[0]);
      } else {
        return MapEntry(key, value);
      }
    });
  }

  dynamic _getData(Response response) {
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return _responseSubKey == null ? data : data[_responseSubKey];
    } else {
      return response.data;
    }
  }
}

bool isNetworkError(dynamic error) => error is DioError && error.type != DioErrorType.response;

Type typeOf<T>() => T;
