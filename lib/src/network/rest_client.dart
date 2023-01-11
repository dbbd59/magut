import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:magut/src/auth/token_utils.dart';

const kDotEnvEndpointString = 'ENDPOINT';

class RestClient {
  RestClient({
    required this.httpClient,
  });
  final http.Client httpClient;

  Future<http.Response> get({
    required String api,
    String? endpoint,
    bool authenticated = true,
  }) async {
    final e = _getEndpoint(endpoint);
    final headers = await _getHeaders(authenticated);

    return httpClient.get(
      Uri.parse('$e$api'),
      headers: headers,
    );
  }

  Future<http.Response> post({
    required String api,
    Map<String, dynamic>? body,
    String? endpoint,
    bool authenticated = true,
  }) async {
    final e = _getEndpoint(endpoint);
    final headers = await _getHeaders(authenticated);

    return httpClient.post(
      Uri.parse('$e$api'),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  Future<http.Response> put({
    required String api,
    required Map<String, dynamic>? body,
    String? endpoint,
    bool authenticated = true,
  }) async {
    final e = _getEndpoint(endpoint);
    final headers = await _getHeaders(authenticated);

    return httpClient.put(
      Uri.parse('$e$api'),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  Future<Map<String, String>> _getHeaders(bool authenticated) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (authenticated) {
      final tokens = await TokensUtils.getTokens();
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
}
