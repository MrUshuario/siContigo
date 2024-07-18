import 'package:floor/floor.dart';

@entity
class RespuestaENVIO {
  @PrimaryKey(autoGenerate: true)
  int? idformato;
  String? id_usuario;
  String? fecha;
  String? respuestas;
  String? puntaje; //en los otros es int
  String? longitud;
  String? latitud;
  int? id_gestor;
  String? fecha_hora_inicio;
  String? fecha_hora_fin;

  RespuestaENVIO({
    this.idformato, this.id_usuario, this.fecha,
    this.respuestas, this.puntaje, this.longitud, this.latitud, this.id_gestor,
    this.fecha_hora_inicio, this.fecha_hora_fin});

  factory RespuestaENVIO.fromJson(dynamic json) {
    return RespuestaENVIO(
      idformato: json['idformato'] as int?,
      id_usuario: json['id_usuario'] as String?,
      fecha: json['fecha'] as String?,
      respuestas: json['respuestas'] as String?,
      puntaje: json['puntaje'] as String?,
      longitud: json['longitud'] as String?,
      latitud: json['latitud'] as String?,
      id_gestor: json['id_gestor'] as int?,
      fecha_hora_inicio: json['fecha_hora_inicio'] as String?,
      fecha_hora_fin: json['fecha_hora_fin'] as String?,
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
      "puntaje":puntaje,
      "longitud":longitud,
      "latitud":latitud,
      "id_gestor": id_gestor,
      "fecha_hora_inicio":fecha_hora_inicio,
      "fecha_hora_fin":fecha_hora_fin
    };
  }

}
