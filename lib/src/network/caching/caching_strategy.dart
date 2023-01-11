import 'package:magut/magut.dart';
import 'package:magut/src/network/response/response_magut.dart';

abstract class CachingStrategy {
  const CachingStrategy();

  Future<ResponseMagut> get(
    Function networkRequest,
    String key,
  );

  Future<void> addToCache(
    ResponseMagut networkValue,
    String key,
  ) async {
    networkValue.cachedMilliseconds = DateTime.now().millisecondsSinceEpoch;
    await LocalStorage.setString(key, networkValue.toJsonString());
  }
}
