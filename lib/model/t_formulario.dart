import 'package:floor/floor.dart';

@entity
class Formulario {
  @PrimaryKey(autoGenerate: true)
  int? cod;
  String? pregunta;
  String? tipoOpcion;
  String? tipoRepuesta;
  int? id;
  int? idformato;

  Formulario({this.cod, this.pregunta, this.tipoOpcion, this.tipoRepuesta, this.id, this.idformato});

  factory Formulario.fromJson(dynamic json)  => Formulario(
    cod: json['cod'] as int?,
    pregunta: json['pregunta'] as String?,
    tipoOpcion: json['tipoOpcion'] as String?,
    tipoRepuesta: json['tipoRepuesta'] as String?,
    id: json['id'] as int?,
    idformato: json['idformato'] as int?,
  );

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
      "tipoRepuesta": tipoRepuesta,
      "id": id,
      "idformato": idformato,
    };
  }

}
