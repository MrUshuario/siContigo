import 'package:floor/floor.dart';

@entity
class Respuesta {
  @PrimaryKey(autoGenerate: true)
  int? cod;
  int? idformato;
  int? id_usuario;
  String? fecha;
  String? respuestas;
  int? puntaje;
  String? longitud;
  String? latitud;
  //ESTO SOLO ES PARA MODIFICAR Y DEMAS
  //int?

  Respuesta({
    this.cod, this.idformato, this.id_usuario, this.fecha,
    this.respuestas, this.puntaje, this.longitud, this.latitud});

  factory Respuesta.fromJson(dynamic json) {
    return Respuesta(
      cod: json['cod'] as int?,
      idformato: json['idformato'] as int?,
      id_usuario: json['id_usuario'] as int?,
      fecha: json['fecha'] as String?,
      respuestas: json['respuestas'] as String?,
      puntaje: json['puntaje'] as int?,
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
      "puntaje":puntaje,
      "longitud":longitud,
      "latitud":latitud
    };
  }

}
