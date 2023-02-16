import 'package:json_annotation/json_annotation.dart';

enum TipoResposta {
  @JsonValue(1)
  naoRepresenta,
  @JsonValue(2)
  meRepresentaMal,
  @JsonValue(3)
  quaseNaoMeRepresenta,
  @JsonValue(4)
  indiferente,
  @JsonValue(5)
  meRepresentaPouco,
  @JsonValue(6)
  meRepresentaBem,
  @JsonValue(7)
  meRepresentaMuitoBem,
}
