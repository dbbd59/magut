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
    final ResponseMagut? cachedValue =
        ResponseMagut.fromJsonString(LocalStorage.getString(key)!);
    if (cachedValue == null || _hasCacheExpired(cachedValue)) {
      final ResponseMagut t = await networkRequest();
      await addToCache(t, key);
      return t;
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
