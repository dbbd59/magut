import 'dart:convert';

class JwtUtils {
  static DateTime? getExpiryDate(String token) {
    final payload = _parseJwt(token);
    if (payload['exp'] != null) {
      return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).add(
        Duration(
          seconds: payload['exp'],
        ),
      );
    }

    return null;
  }

  static DateTime? getIssuedDate(String token) {
    final payload = _parseJwt(token);
    if (payload['exp'] != null) {
      return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).add(
        Duration(
          seconds: payload['iat'],
        ),
      );
    }

    return null;
  }

  static String? getUserRole({
    required String token,
  }) {
    final payload = _parseJwt(
      token,
    );

    if (payload['roles'] != null) {
      final roles = payload['roles'] as List<dynamic>;
      if (roles.isNotEmpty) {
        return roles.join();
      }
    }
    return null;
  }

  static String? getUsername({
    required String token,
  }) {
    final payload = _parseJwt(
      token,
    );

    if (payload['username'] != null) {
      return payload['username'];
    }
    return null;
  }

  static bool shouldRefresh(String token) {
    final expirationDate = getExpiryDate(token);

    return expirationDate != null
        ? _isExpired(token, date: expirationDate)
        : false;
  }

  static String _decodeBase64(String str) {
    var output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64 string.');
    }

    return utf8.decode(
      base64Url.decode(
        output,
      ),
    );
  }

  static bool _isExpired(
    String token, {
    DateTime? date,
  }) {
    final expirationDate = date ?? getExpiryDate(token);

    return expirationDate != null
        ? DateTime.now().toUtc().isAfter(expirationDate)
        : false;
  }

  static Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw const FormatException('Invalid token.');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw const FormatException('Invalid payload.');
    }

    return payloadMap;
  }
}
