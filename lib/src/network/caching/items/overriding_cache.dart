import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:magut/src/network/caching/caching_strategy.dart';
import 'package:magut/src/network/response/response_magut.dart';
import 'package:magut/src/storage/local_storage.dart';

class OverridingCache extends CachingStrategy {
  @override
  Future<ResponseMagut> get(
    Function networkRequest,
    String key,
  ) async {
    final valueFromStorage = LocalStorage.getString(key);

    final cachedValue = valueFromStorage != null
        ? ResponseMagut.fromJsonString(valueFromStorage)
        : null;
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
    final http.Response networkResult = await networkRequest();

    return addToCache(
      networkResult,
      key,
    );
  }
}
