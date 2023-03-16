import 'dart:convert';

class FinishQuizDto {
  final int idUsuario;
  final int idQuestionario;
  final int idPergunta;
  final int resposta;
  final bool perguntaFinal;

  FinishQuizDto({
    required this.idUsuario,
    required this.idQuestionario,
    required this.idPergunta,
    required this.resposta,
    required this.perguntaFinal,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idUsuario': idUsuario,
      'idQuestionario': idQuestionario,
      'idPergunta': idPergunta,
      'resposta': resposta,
      'perguntaFinal': perguntaFinal,
    };
  }

  factory FinishQuizDto.fromMap(Map<String, dynamic> map) {
    return FinishQuizDto(
      idUsuario: map['idUsuario'] as int,
      idQuestionario: map['idQuestionario'] as int,
      idPergunta: map['idPergunta'] as int,
      resposta: map['resposta'] as int,
      perguntaFinal: map['perguntaFinal'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinishQuizDto.fromJson(String source) =>
      FinishQuizDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
