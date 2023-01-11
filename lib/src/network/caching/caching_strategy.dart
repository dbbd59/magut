import 'package:http/http.dart' as http;
import 'package:magut/magut.dart';
import 'package:magut/src/network/response/response_magut.dart';

abstract class CachingStrategy {
  const CachingStrategy();

  Future<ResponseMagut> get(
    Function networkRequest,
    String key,
  );

  Future<ResponseMagut> addToCache(
    http.Response networkValue,
    String key,
  ) async {
    final resM = ResponseMagut(
      networkValue.body,
      networkValue.statusCode,
      DateTime.now().millisecondsSinceEpoch,
    );
    await LocalStorage.setString(key, resM.toJsonString());
    return resM;
  }
}
