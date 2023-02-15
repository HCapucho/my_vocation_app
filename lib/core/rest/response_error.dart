// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class ResponseError {
  @JsonKey(defaultValue: true)
  bool success = true;
  @JsonKey(defaultValue: <String>[])
  List<String> errors = [];
  @JsonKey(name: "Code", defaultValue: 0)
  int code = 0;
  ResponseError({
    required this.success,
    required this.code,
    required this.errors,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'errors': errors,
      'code': code,
    };
  }

  factory ResponseError.fromMap(Map<String, dynamic> map) {
    return ResponseError(
      success: map['success'],
      errors: List<String>.from(map['errors']),
      code: map['code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseError.fromJson(String source) =>
      ResponseError.fromMap(json.decode(source) as Map<String, dynamic>);
}
