import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:magut/src/network/caching/caching_strategy.dart';

class ExpiryCache extends CachingStrategy {
  const ExpiryCache({
    this.duration = const Duration(
      hours: 24,
    ),
  });

  @override
  final Duration duration;

  @override
  Future<http.Response> get(
    Function networkRequest,
    String key,
  ) async {
    final cachedValue = getValueFromStorage(key);
    if (cachedValue == null || hasCacheExpired(cachedValue, duration)) {
      final http.Response r = await networkRequest();
      addToCache(r, key);

      return r;
    } else {
      return http.Response(
        cachedValue.body,
        cachedValue.statusCode,
      );
    }
  }
}
