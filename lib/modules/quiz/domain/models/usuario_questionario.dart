import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:my_vocation_app/core/extensions/date_time_extension.dart';

@JsonSerializable()
class UsuarioQuestionario {
  final int idUsuario;
  final int idQuestionario;
  final DateTime dataInicio;
  final DateTime? dataTermino;
  UsuarioQuestionario({
    required this.idUsuario,
    required this.idQuestionario,
    required this.dataInicio,
    this.dataTermino,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idUsuario': idUsuario,
      'idQuestionario': idQuestionario,
      'dataInicio': dataInicio.toIso8601String(),
      'dataTermino': dataTermino?.toIso8601String(),
    };
  }

  factory UsuarioQuestionario.fromMap(Map<String, dynamic> map) {
    return UsuarioQuestionario(
      idUsuario: map['idUsuario'] as int,
      idQuestionario: map['idQuestionario'] as int,
      dataInicio:
          DateTimeExtension.fromJson(map['dataInicio'] as String) as DateTime,
      dataTermino: DateTimeExtension.fromJson(map['dataTermino'] as String?),
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioQuestionario.fromJson(String source) =>
      UsuarioQuestionario.fromMap(json.decode(source) as Map<String, dynamic>);
}
