// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class ErrorMessage {
  @JsonKey(name: "message", defaultValue: "")
  String message;
  @JsonKey(name: "Message", defaultValue: "")
  String message2;

  ErrorMessage(this.message, {this.message2 = ""});

  @override
  String toString() {
    return message2.isEmpty ? message : message2;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'message2': message2,
    };
  }

  factory ErrorMessage.fromMap(Map<String, dynamic> map) {
    return ErrorMessage(
      map['message'] as String,
      message2: map['message2'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorMessage.fromJson(String source) =>
      ErrorMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}
