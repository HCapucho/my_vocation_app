import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginDto {
  final String user;
  final String senha;
  LoginDto({
    required this.user,
    required this.senha,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'senha': senha,
    };
  }

  factory LoginDto.fromMap(Map<String, dynamic> map) {
    return LoginDto(
      user: map['user'] as String,
      senha: map['senha'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginDto.fromJson(String source) =>
      LoginDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
