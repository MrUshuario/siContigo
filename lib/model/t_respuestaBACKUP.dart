import 'package:floor/floor.dart';

@entity
class RespuestaENVIO {
  @PrimaryKey(autoGenerate: true)
  int? idformato;
  int? id_usuario;
  String? fecha;
  String? respuestas;
  String? longitud;
  String? latitud;

  RespuestaENVIO({
    this.idformato, this.id_usuario, this.fecha,
    this.respuestas, this.longitud, this.latitud});

  factory RespuestaENVIO.fromJson(dynamic json) {
    return RespuestaENVIO(
      idformato: json['idformato'] as int?,
      id_usuario: json['id_usuario'] as int?,
      fecha: json['fecha'] as String?,
      respuestas: json['respuestas'] as String?,
      longitud: json['longitud'] as String?,
      latitud: json['latitud'] as String?,
    );
  }

  static List<RespuestaENVIO> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<RespuestaENVIO> items =
    bienvenidaList.map((e) => RespuestaENVIO.fromJson(e)).toList();
    return items ?? [];
  }

  Map<String, dynamic> toMap() {
    return {
      "idformato": idformato,
      "id_usuario": id_usuario,
      "fecha": fecha,
      "respuestas": respuestas,
      "longitud":longitud,
      "latitud":latitud
    };
  }

}
