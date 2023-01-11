import 'package:magut/src/network/caching/caching_strategy.dart';
import 'package:magut/src/network/response/response_magut.dart';
import 'package:magut/src/storage/local_storage.dart';

import 'items/expiry_cache.dart';

class NetworkCache {
  Future clear() async {
    await LocalStorage.clear();
  }

  Future<ResponseMagut> getOrUpdate({
    required String cacheKey,
    required Function networkRequest,
    CachingStrategy cachingStrategy = const ExpiryCache(),
  }) async =>
      cachingStrategy.get(networkRequest, cacheKey);
}
