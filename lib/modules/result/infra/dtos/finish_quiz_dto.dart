import 'dart:convert';
import 'package:my_vocation_app/modules/quiz/infra/dtos/resposta_questionario_dto.dart';

class FinishQuizDto {
  final int idUsuario;
  final int idQuestionario;
  final List<RespostaQuestionarioDto> respostas;
  FinishQuizDto({
    required this.idUsuario,
    required this.idQuestionario,
    required this.respostas,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idUsuario': idUsuario,
      'idQuestionario': idQuestionario,
      'respostas': respostas.map((x) => x.toMap()).toList(),
    };
  }

  factory FinishQuizDto.fromMap(Map<String, dynamic> map) {
    return FinishQuizDto(
      idUsuario: map['idUsuario'] as int,
      idQuestionario: map['idQuestionario'] as int,
      respostas:
          map['respostas'].map((x) => RespostaQuestionarioDto.fromMap(x)),
    );
  }

  String toJson() => json.encode(toMap());

  factory FinishQuizDto.fromJson(String source) =>
      FinishQuizDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
