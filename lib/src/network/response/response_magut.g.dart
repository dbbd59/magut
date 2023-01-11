// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_magut.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMagut _$ResponseMagutFromJson(Map<String, dynamic> json) =>
    ResponseMagut(
      json['body'] as String,
      json['statusCode'] as int,
      json['cachedMilliseconds'] as int,
    );

Map<String, dynamic> _$ResponseMagutToJson(ResponseMagut instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'body': instance.body,
      'cachedMilliseconds': instance.cachedMilliseconds,
    };
