import 'dart:convert';

class UserModel {
  final String name;
  final String photoUrl;
  final int score;
  UserModel({
    required this.name,
    required this.photoUrl,
    required this.score,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'photoUrl': photoUrl,
      'score': score,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      photoUrl: map['photoUrl'] as String,
      score: map['score'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
