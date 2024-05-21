

import 'package:floor/floor.dart';

@entity
class ReponseInicioFinActividades {
  String? nroDoc;
  String? name;
  String? apPaterno;
  String? apMaterno;
  String? ubigeo;
  String? region;
  String? provincia;
  String? distrito;
  String? typeUser;
  String? privilege;
  String? state;

  ReponseInicioFinActividades(
      {this.nroDoc,
        this.name,
        this.apPaterno,
        this.apMaterno,
        this.ubigeo,
        this.region,
        this.provincia,
        this.distrito,
        this.typeUser,
        this.privilege,
        this.state,
      });

  factory ReponseInicioFinActividades.fromJson(dynamic json) {
    return ReponseInicioFinActividades(
      nroDoc: json['nroDoc'],
      name: json['name'],
      apPaterno: json['apPaterno'],
      apMaterno: json['apMaterno'],
      ubigeo: json['ubigeo'],
      region: json['region'],
      provincia: json['provincia'],
      distrito: json['distrito'],
      typeUser: json['typeUser'],
      privilege: json['privilege'],
      state: json['state'],
    );
  }

  static List<ReponseInicioFinActividades> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<ReponseInicioFinActividades> items =
    bienvenidaList.map((e) => ReponseInicioFinActividades.fromJson(e)).toList();
    return items;
  }

  Map<String, dynamic> toMap() {
    return {
      "nroDoc": nroDoc,
      "name": name,
      "apPaterno": apPaterno,
      "apMaterno": apMaterno,
      "ubigeo": ubigeo,
      "region": region,
      "provincia": provincia,
      "distrito": distrito,
      "typeUser": typeUser,
      "privilege": privilege,
      "state": state,
    };
  }
}
