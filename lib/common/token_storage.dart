import 'package:get_storage/get_storage.dart';

class TokenStorage {
  static final _box = GetStorage();

  // KEYS
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  // ---------- SET ----------
  static void setAccessToken(String token) {
    _box.write(_accessTokenKey, token);
  }

  static void setRefreshToken(String token) {
    _box.write(_refreshTokenKey, token);
  }

  static void setTokens({
    required String accessToken,
    required String refreshToken,
  }) {
    _box.write(_accessTokenKey, accessToken);
    _box.write(_refreshTokenKey, refreshToken);
  }

  // ---------- GET ----------
  static String get accessToken =>
      _box.read(_accessTokenKey) ?? "";

  static String get refreshToken =>
      _box.read(_refreshTokenKey) ?? "";

  // ---------- CLEAR ----------
  static void clear() {
    _box.remove(_accessTokenKey);
    _box.remove(_refreshTokenKey);
  }

  // ---------- CHECK ----------
  static bool get hasAccessToken =>
      _box.hasData(_accessTokenKey);
}
