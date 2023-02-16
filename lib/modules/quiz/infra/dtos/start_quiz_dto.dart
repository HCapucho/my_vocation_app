import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class StartQuizDto {
  final int idUsuario;
  final int idQuestionario;
  StartQuizDto({
    required this.idUsuario,
    required this.idQuestionario,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idUsuario': idUsuario,
      'idQuestionario': idQuestionario,
    };
  }

  factory StartQuizDto.fromMap(Map<String, dynamic> map) {
    return StartQuizDto(
      idUsuario: map['idUsuario'] as int,
      idQuestionario: map['idQuestionario'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory StartQuizDto.fromJson(String source) =>
      StartQuizDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
