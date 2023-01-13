import 'package:http/http.dart' as http;
import 'package:magut/magut.dart';
import 'package:magut/src/network/response/response_cache_item.dart';

const kCacheMagutString = 'cache.magut.';

abstract class CachingStrategy {
  const CachingStrategy({
    this.duration = const Duration(),
  });

  final Duration duration;

  Future<http.Response> get(
    Function networkRequest,
    String key,
  );

  ResponseCacheItem? getValueFromStorage(String key) {
    final valueFromStorage = LocalStorage.getString(kCacheMagutString + key);

    final cachedValue = valueFromStorage != null
        ? ResponseCacheItem.fromJsonString(valueFromStorage)
        : null;
    return cachedValue;
  }

  void addToCache(
    http.Response networkValue,
    String key,
  ) {
    if (networkValue.statusCode < 205) {
      LocalStorage.setString(
        kCacheMagutString + key,
        ResponseCacheItem(
          networkValue.body,
          networkValue.statusCode,
          DateTime.now().millisecondsSinceEpoch,
        ).toJsonString(),
      );
    }
  }

  bool hasCacheExpired(ResponseCacheItem cachedValue, Duration cacheDuration) {
    final nowMilliseconds = DateTime.now().millisecondsSinceEpoch;
    final cacheExpiryMilliseconds =
        nowMilliseconds - cacheDuration.inMilliseconds;
    final hasCacheExpired =
        cachedValue.cachedMilliseconds < cacheExpiryMilliseconds;

    return hasCacheExpired;
  }
}
