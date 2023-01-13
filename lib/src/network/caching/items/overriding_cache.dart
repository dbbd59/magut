import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:magut/src/network/caching/caching_strategy.dart';

class OverridingCache extends CachingStrategy {
  OverridingCache();

  @override
  Future<http.Response> get(
    Function networkRequest,
    String key,
  ) async {
    final cachedValue = getValueFromStorage(key);

    if (cachedValue != null) {
      unawaited(
        getAndCacheNetworkValue(
          networkRequest,
          key,
        ),
      );

      return http.Response(
        cachedValue.body,
        cachedValue.statusCode,
      );
    } else {
      return getAndCacheNetworkValue(
        networkRequest,
        key,
      );
    }
  }

  Future<http.Response> getAndCacheNetworkValue(
    Function networkRequest,
    String key,
  ) async {
    final http.Response networkResult = await networkRequest();
    addToCache(
      networkResult,
      key,
    );

    return networkResult;
  }
}
