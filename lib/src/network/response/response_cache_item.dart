import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'response_cache_item.g.dart';

@JsonSerializable()
class ResponseCacheItem extends http.Response {
  ResponseCacheItem(super.body, super.statusCode, this.cachedMilliseconds);

  factory ResponseCacheItem.fromJson(Map<String, dynamic> json) =>
      _$ResponseCacheItemFromJson(json);

  factory ResponseCacheItem.fromJsonString(String jsonString) =>
      _$ResponseCacheItemFromJson(jsonDecode(jsonString));

  int cachedMilliseconds = 0;

  Map<String, dynamic> toJson() => _$ResponseCacheItemToJson(this);

  String toJsonString() => jsonEncode(toJson());
}
