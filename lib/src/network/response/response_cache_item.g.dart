// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_cache_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseCacheItem _$ResponseCacheItemFromJson(Map<String, dynamic> json) =>
    ResponseCacheItem(
      json['body'] as String,
      json['statusCode'] as int,
      json['cachedMilliseconds'] as int,
    );

Map<String, dynamic> _$ResponseCacheItemToJson(ResponseCacheItem instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'body': instance.body,
      'cachedMilliseconds': instance.cachedMilliseconds,
    };
