

import 'package:floor/floor.dart';

@entity
class insertarEncuestaRSPTA {
  @PrimaryKey(autoGenerate: true)
  int? cod;
  String? codigo;
  int? id;


  insertarEncuestaRSPTA(
      {
        this.cod,
        this.codigo,
        this.id,
      });

  factory insertarEncuestaRSPTA.fromJson(dynamic json) {
    return insertarEncuestaRSPTA(
      cod: json['cod'],
      codigo: json['codigo'],
      id: json['id'],
    );
  }

  static List<insertarEncuestaRSPTA> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<insertarEncuestaRSPTA> items =
    bienvenidaList.map((e) => insertarEncuestaRSPTA.fromJson(e)).toList();
    return items;
  }

  Map<String, dynamic> toMap() {
    return {
      "cod": cod,
      "codigo": codigo,
      "id": id,

    };
  }
}
