import 'dart:convert';

class Curso {
  String nome;
  int? duracao;
  Curso({
    required this.nome,
    this.duracao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'duracao': duracao,
    };
  }

  factory Curso.fromMap(Map<String, dynamic> map) {
    return Curso(
      nome: map['nome'] as String,
      duracao: map['duracao'] != null ? map['duracao'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Curso.fromJson(String source) =>
      Curso.fromMap(json.decode(source) as Map<String, dynamic>);
}
