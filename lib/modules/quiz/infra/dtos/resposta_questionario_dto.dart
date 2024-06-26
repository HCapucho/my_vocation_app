import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:my_vocation_app/modules/quiz/domain/models/enums/tipo_resposta.dart';

class RespostaQuestionarioDto {
  final int idPergunta;
  final int resposta;
  RespostaQuestionarioDto({
    required this.idPergunta,
    required this.resposta,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idPergunta': idPergunta,
      'resposta': resposta,
    };
  }

  factory RespostaQuestionarioDto.fromMap(Map<String, dynamic> map) {
    return RespostaQuestionarioDto(
      idPergunta: map['idPergunta'] as int,
      resposta: map['resposta'] as int,
    );
  }

  String toJson(RespostaQuestionarioDto e) => json.encode(toMap());

  factory RespostaQuestionarioDto.fromJson(String source) =>
      RespostaQuestionarioDto.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

const _TipoRespostaEnumMap = {
  TipoResposta.naoRepresenta: 1,
  TipoResposta.meRepresentaMal: 2,
  TipoResposta.quaseNaoMeRepresenta: 3,
  TipoResposta.indiferente: 4,
  TipoResposta.meRepresentaPouco: 5,
  TipoResposta.meRepresentaBem: 6,
  TipoResposta.meRepresentaMuitoBem: 7,
};
