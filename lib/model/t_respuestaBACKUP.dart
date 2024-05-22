import 'package:floor/floor.dart';

@entity
class RespuestaBACKUP {
  @PrimaryKey(autoGenerate: true)
  int? cod;
  int? idformato;
  int? id_usuario;
  String? fecha;
  String? Nombres;


  RespuestaBACKUP({
    this.cod, this.idformato, this.id_usuario, this.fecha,
    this.Nombres});

  factory RespuestaBACKUP.fromJson(dynamic json) {
    return RespuestaBACKUP(
      cod: json['cod'] as int?,
      idformato: json['idformato'] as int?,
      id_usuario: json['id_usuario'] as int?,
      fecha: json['fecha'] as String?,
      Nombres: json['Nombres'] as String?,

    );
  }

  static List<RespuestaBACKUP> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<RespuestaBACKUP> items =
    bienvenidaList.map((e) => RespuestaBACKUP.fromJson(e)).toList();
    return items ?? [];
  }

  Map<String, dynamic> toMap() {
    return {
      "cod": cod,
      "idformato": idformato,
      "id_usuario": id_usuario,
      "fecha": fecha,
      "Nombres": Nombres,
    };
  }

}
