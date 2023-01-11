import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'response_magut.g.dart';

@JsonSerializable()
class ResponseMagut extends http.Response {
  ResponseMagut(super.body, super.statusCode, this.cachedMilliseconds);

  factory ResponseMagut.fromJson(Map<String, dynamic> json) =>
      _$ResponseMagutFromJson(json);

  factory ResponseMagut.fromJsonString(String jsonString) =>
      _$ResponseMagutFromJson(jsonDecode(jsonString));

  int cachedMilliseconds = 0;

  Map<String, dynamic> toJson() => _$ResponseMagutToJson(this);

  String toJsonString() => jsonEncode(toJson());
}
