import 'package:http/http.dart' as http;
import 'package:magut/magut.dart';
import 'package:magut/src/network/caching/caching_strategy.dart';
import 'package:magut/src/network/response/response_magut.dart';

class ExpiryCache extends CachingStrategy {
  const ExpiryCache({this.duration = _defaultDuration});

  final Duration duration;

  static const _defaultDuration = Duration(hours: 24);

  @override
  Future<ResponseMagut> get(
    Function networkRequest,
    String key,
  ) async {
    final valueFromStorage = LocalStorage.getString(key);

    final cachedValue = valueFromStorage != null
        ? ResponseMagut.fromJsonString(valueFromStorage)
        : null;
    if (cachedValue == null || _hasCacheExpired(cachedValue)) {
      final http.Response r = await networkRequest();
      return addToCache(r, key);
    } else {
      return cachedValue;
    }
  }

  bool _hasCacheExpired(ResponseMagut cachedValue) {
    final nowMilliseconds = DateTime.now().millisecondsSinceEpoch;
    final cacheExpiryMilliseconds = nowMilliseconds - duration.inMilliseconds;
    final hasCacheExpired =
        cachedValue.cachedMilliseconds < cacheExpiryMilliseconds;
    return hasCacheExpired;
  }
}
