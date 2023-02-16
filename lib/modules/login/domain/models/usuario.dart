import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:my_vocation_app/core/extensions/date_time_extension.dart';

@JsonSerializable()
class Usuario {
  final int id;
  final String nome;
  final String cpf;
  final DateTime? dataNascimento;
  final String telefone;
  final String email;
  final String? token;

  Usuario({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.dataNascimento,
    required this.telefone,
    required this.email,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'dataNascimento': dataNascimento?.toIso8601String(),
      'telefone': telefone,
      'email': email,
      'token': token,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'] as int,
      nome: map['nome'] as String,
      cpf: map['cpf'] as String,
      dataNascimento:
          DateTimeExtension.fromJson(map['dataNascimento'] as String?),
      telefone: map['telefone'] as String,
      email: map['email'] as String,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source) as Map<String, dynamic>);
}
