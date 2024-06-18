import 'package:floor/floor.dart';

@entity
class Formulario {
  @PrimaryKey(autoGenerate: true)
  int? cod;
  String? pregunta;
  String? tipoOpcion;
  String? puntaje;
  int? tipoRepuesta;
  int? id;
  int? idformato;
  String? texto;
  String? titulo;
  int? idseccion;
  String? descripcion;
  int? id_tipo_respuesta;
  int? id_seccion;


  Formulario({
    this.cod, this.pregunta, this.tipoOpcion, this.puntaje, this.tipoRepuesta,
    this.id, this.idformato, this.texto, this.titulo, this.idseccion,
    this.descripcion, this.id_tipo_respuesta, this.id_seccion});

  factory Formulario.fromJson(dynamic json) {

    String tipoOpcionList = "";
    if (json['tipoOpcion'] != null || json['tipoOpcion'] != "" || json['tipoOpcion'] != "texto") {
      tipoOpcionList = (json['tipoOpcion'] as List<dynamic>).join('; ');
    }

    String puntajeList = "";
    if (json['puntaje'] != null || json['puntaje'] != "" || json['puntaje'] != "texto") {
      puntajeList = (json['puntaje'] as List<dynamic>).join('; ');
    }


    return Formulario(
      cod: json['cod'] as int?,
      pregunta: json['pregunta'] as String?,
      tipoOpcion: tipoOpcionList as String?,
      puntaje: puntajeList as String?,
      tipoRepuesta: json['tipoRepuesta'] as int?,
      id: json['id'] as int?,
      idformato: json['idformato'] as int?,
      texto: json['texto'] as String?,
      titulo: json['titulo'] as String?,
      idseccion: json['idseccion'] as int?,
      descripcion: json['descripcion'] as String?,
      id_tipo_respuesta: json['id_tipo_respuesta'] as int?,
      id_seccion: json['id_seccion'] as int?,
    );
  }

  static List<Formulario> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<Formulario> items =
    bienvenidaList.map((e) => Formulario.fromJson(e)).toList();
    return items ?? [];
  }

  Map<String, dynamic> toMap() {
    return {
      "cod": cod,
      "pregunta": pregunta,
      "tipoOpcion": tipoOpcion,
      "puntaje": puntaje,
      "tipoRepuesta": tipoRepuesta,
      "id": id,
      "idformato": idformato,
      "texto": texto,
      "titulo": titulo,
      "idseccion": idseccion,
      "descripcion": descripcion,
      "id_tipo_respuesta": id_tipo_respuesta,
      "id_seccion": id_seccion,
    };
  }

}
