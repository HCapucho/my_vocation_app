import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Questionario {
  final int id;
  final String nome;
  final String descricao;
  final int quantidadePerguntas;
  Questionario({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.quantidadePerguntas,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'quantidadePerguntas': quantidadePerguntas,
    };
  }

  factory Questionario.fromMap(Map<String, dynamic> map) {
    return Questionario(
      id: map['id'] as int,
      nome: map['nome'] as String,
      descricao: map['descricao'] as String,
      quantidadePerguntas: map['quantidadePerguntas'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Questionario.fromJson(String source) =>
      Questionario.fromMap(json.decode(source) as Map<String, dynamic>);
}
