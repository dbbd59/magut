import 'package:magut/src/auth/jwt_utils.dart';
import 'package:magut/src/auth/tokens.dart';
import 'package:magut/src/constants.dart';
import 'package:magut/src/storage/local_storage.dart';

class TokensUtils {
  const TokensUtils({
    this.onTokenExpired,
  });

  final Function? onTokenExpired;

  static Future<Tokens?> getTokens({Function? onTokenExpired}) async {
    final tokens = Tokens(
      accessToken: _getAccessToken(),
      refreshToken: _getRefreshToken(),
    );

    if (JwtUtils.shouldRefresh(
      tokens.accessToken,
    )) {
      onTokenExpired?.call();
    }

    return tokens;
  }

  static Future removeTokensPrefs() async {
    await LocalStorage.remove(
      PREFS_ACCESS_TOKEN,
    );

    await LocalStorage.remove(
      PREFS_REFRESH_TOKEN,
    );
  }

  static Future setTokensPrefs({
    required String accessToken,
    required String? refreshToken,
  }) async {
    await LocalStorage.setString(
      PREFS_ACCESS_TOKEN,
      accessToken,
    );

    if (refreshToken != null) {
      await LocalStorage.setString(
        PREFS_REFRESH_TOKEN,
        refreshToken,
      );
    }
  }

  static String _getAccessToken({String? accessToken}) {
    final token = accessToken ?? LocalStorage.getString(PREFS_ACCESS_TOKEN);

    return token!;
  }

  static String? _getRefreshToken({String? refreshToken}) {
    final token = refreshToken ?? LocalStorage.getString(PREFS_REFRESH_TOKEN);

    return token;
  }

  /* static Future<Tokens?> _refreshToken({String? refreshToken}) async {
    return null;
  } */
}
