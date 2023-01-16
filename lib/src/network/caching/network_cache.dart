import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:magut/src/network/caching/caching_strategy.dart';
import 'package:magut/src/network/caching/items/expiry_cache.dart';
import 'package:magut/src/network/response/response_cache_item.dart';
import 'package:magut/src/storage/local_storage.dart';

class NetworkCache {
  Future<http.Response> getOrUpdate({
    required String cacheKey,
    required Function networkRequest,
    CachingStrategy cachingStrategy = const ExpiryCache(),
  }) async {
    final response = cachingStrategy.get(networkRequest, cacheKey);
    unawaited(cleanCache(cachingStrategy));
    return response;
  }

  Future<void> cleanCache(CachingStrategy cachingStrategy) async {
    final keys = LocalStorage.getKeys();
    for (final key in keys) {
      if (key.startsWith(kCacheMagutString)) {
        final responseCacheItem =
            ResponseCacheItem.fromJsonString(LocalStorage.getString(key)!);
        if (cachingStrategy.hasCacheExpired(
          responseCacheItem,
          cachingStrategy.duration,
        )) {
          await LocalStorage.remove(key);
        }
      }
    }
  }
}
