import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Pergunta {
  final int id;
  final String titulo;
  final String descricao;
  final int idQuestionario;
  Pergunta({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.idQuestionario,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'idQuestionario': idQuestionario,
    };
  }

  factory Pergunta.fromMap(Map<String, dynamic> map) {
    return Pergunta(
      id: map['id'] as int,
      titulo: map['titulo'] as String,
      descricao: map['descricao'] as String,
      idQuestionario: map['idQuestionario'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pergunta.fromJson(String source) =>
      Pergunta.fromMap(json.decode(source) as Map<String, dynamic>);
}
