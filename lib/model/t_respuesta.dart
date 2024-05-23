import 'package:floor/floor.dart';

@entity
class Respuesta {
  @PrimaryKey(autoGenerate: true)
  int? cod;
  int? idformato;
  int? id_usuario;
  String? fecha;
  String? respuestas;
  String? longitud;
  String? latitud;

  Respuesta({
    this.cod, this.idformato, this.id_usuario, this.fecha,
    this.respuestas, this.longitud, this.latitud});

  factory Respuesta.fromJson(dynamic json) {
    return Respuesta(
      cod: json['cod'] as int?,
      idformato: json['idformato'] as int?,
      id_usuario: json['id_usuario'] as int?,
      fecha: json['fecha'] as String?,
      respuestas: json['respuestas'] as String?,
      longitud: json['longitud'] as String?,
      latitud: json['latitud'] as String?,
    );
  }

  static List<Respuesta> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<Respuesta> items =
    bienvenidaList.map((e) => Respuesta.fromJson(e)).toList();
    return items ?? [];
  }

  Map<String, dynamic> toMap() {
    return {
      "cod": cod,
      "idformato": idformato,
      "id_usuario": id_usuario,
      "fecha": fecha,
      "respuestas": respuestas,
      "longitud":longitud,
      "latitud":latitud
    };
  }

}
