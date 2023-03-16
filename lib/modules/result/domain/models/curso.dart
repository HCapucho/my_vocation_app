import 'dart:convert';

class Curso {
  String nome;
  List<String> universidades;
  Curso({
    required this.nome,
    required this.universidades,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'universidades': universidades,
    };
  }

  factory Curso.fromMap(Map<String, dynamic> map) {
    return Curso(
      nome: map['nome'] as String,
      universidades: List<String>.from(map['universidades']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Curso.fromJson(String source) =>
      Curso.fromMap(json.decode(source) as Map<String, dynamic>);
}
