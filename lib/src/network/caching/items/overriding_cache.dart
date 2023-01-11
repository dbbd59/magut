import 'dart:async';

import 'package:magut/src/network/caching/caching_strategy.dart';
import 'package:magut/src/network/response/response_magut.dart';
import 'package:magut/src/storage/local_storage.dart';

class OverridingCache extends CachingStrategy {
  @override
  Future<ResponseMagut> get(
    Function networkRequest,
    String key,
  ) async {
    final ResponseMagut? cachedValue =
        ResponseMagut.fromJsonString(LocalStorage.getString(key)!);
    if (cachedValue != null) {
      unawaited(
        getAndCacheNetworkValue(
          networkRequest,
          key,
        ),
      );
      return cachedValue;
    } else {
      return getAndCacheNetworkValue(
        networkRequest,
        key,
      );
    }
  }

  Future<ResponseMagut> getAndCacheNetworkValue(
    Function networkRequest,
    String key,
  ) async {
    final ResponseMagut networkResult = await networkRequest();
    await addToCache(
      networkResult,
      key,
    );
    return networkResult;
  }
}
