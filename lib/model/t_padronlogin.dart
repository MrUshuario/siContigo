import 'package:floor/floor.dart';

@entity
class PadronLogin {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? nombre;
  String? apellidos;
  String? hogarDepartamento;



  PadronLogin(
      {this.id, this.nombre, this.apellidos, this.hogarDepartamento
      });

  factory PadronLogin.fromJson(dynamic json) {
    return PadronLogin(
    id: json['id'],
    nombre: json['nombre'],
    apellidos: json['apellidos'],
    hogarDepartamento: json['hogarDepartamento'],
    );
  }

  static List<PadronLogin> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<PadronLogin> items =
    bienvenidaList.map((e) => PadronLogin.fromJson(e)).toList();
    return items;
  }

  Map<String, dynamic> toMap() {
    return {
    "id": id,
    "nombre": nombre,
    "apellidos": apellidos,
    "hogarDepartamento": hogarDepartamento,
    };
  }
}
