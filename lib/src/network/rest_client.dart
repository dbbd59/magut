import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:magut/src/auth/token_utils.dart';
import 'package:magut/src/network/caching/caching_strategy.dart';
import 'package:magut/src/network/caching/network_cache.dart';

const kDotEnvEndpointString = 'ENDPOINT';

class RestClient {
  RestClient({
    required this.httpClient,
    this.onTokenExpired,
  });

  final http.Client httpClient;
  final Function? onTokenExpired;

  Future<http.Response> get({
    required String api,
    String? endpoint,
    bool authenticated = true,
    CachingStrategy? cachingStrategy,
    Map<String, String>? queryParameters,
  }) async {
    final e = _getEndpoint(endpoint);
    final headers = await _getHeaders(authenticated);
    final uri = _encodeUri('$e$api', queryParameters);

    late http.Response res;

    if (cachingStrategy == null) {
      res = await httpClient.get(
        uri,
        headers: headers,
      );
    } else {
      res = await NetworkCache().getOrUpdate(
        cacheKey: api,
        networkRequest: () => httpClient.get(
          uri,
          headers: headers,
        ),
        cachingStrategy: cachingStrategy,
      );
    }

    return res;
  }

  Future<http.Response> post({
    required String api,
    Map<String, dynamic>? body,
    String? endpoint,
    bool authenticated = true,
    Map<String, String>? queryParameters,
  }) async {
    final e = _getEndpoint(endpoint);
    final headers = await _getHeaders(authenticated);
    final uri = _encodeUri('$e$api', queryParameters);

    return httpClient.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
  }

  Future<http.Response> put({
    required String api,
    required Map<String, dynamic>? body,
    String? endpoint,
    bool authenticated = true,
    Map<String, String>? queryParameters,
  }) async {
    final e = _getEndpoint(endpoint);
    final headers = await _getHeaders(authenticated);
    final uri = _encodeUri('$e$api', queryParameters);

    return httpClient.put(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
  }

  Future<Map<String, String>> _getHeaders(bool authenticated) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (authenticated) {
      final tokens = await TokensUtils.getTokens(
        onTokenExpired: onTokenExpired,
      );
      if (tokens != null) {
        headers['Authorization'] = 'Bearer ${tokens.accessToken}';
      }
    }
    return headers;
  }

  String? _getEndpoint(String? endpoint) {
    final e = endpoint ?? dotenv.env[kDotEnvEndpointString];
    return e;
  }

  Uri _encodeUri(String url, Map<String, String>? queryParameters) {
    final uri = Uri.parse(url);

    final allQueryParams = Map<String, String>.from(uri.queryParameters);
    if (queryParameters != null) {
      allQueryParams.addAll(queryParameters);
    }

    return uri.replace(queryParameters: allQueryParams);
  }
}
