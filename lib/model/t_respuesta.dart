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
  int? id_gestor;
  
  //ESTO SOLO ES PARA MODIFICAR Y DEMAS
  int? p01CobroPension;
  int? p02TipoMeses;
  String? p03Check;
  String? p03CheckEspecificar;
  String? p04Check;
  int? p05pension;
  int? p06Establecimiento;
  String? p06EstablecimientoESPECIFICAR;
  int? p07Atendio;
  String? p08Check;
  String? p08CheckEspecificar;
  String? p09Check;
  String? p09CheckEspecificar;
  int? p10Frecuencia;
  int? p11Vive;
  int? p12Familia;
  int? p12FamiliaB;
  int? p13Ayudas;
  int? p13AyudasB;
  int? p14Ingreso;
  int? p15Tipovivienda;
  int? p15TipoviviendaB;
  int? p16Riesgo;
  int? p16RiesgoB;
  String? p17Check;
  String? p17CheckEspecificar;
  int? p18Emprendimiento;


  Respuesta({
    this.cod, this.idformato, this.id_usuario, this.fecha,
    this.respuestas, this.puntaje, this.longitud, this.latitud, this.id_gestor,
    this.p01CobroPension, this.p02TipoMeses, this.p03Check, this.p03CheckEspecificar, this.p04Check, this.p05pension,
    this.p06Establecimiento, this.p06EstablecimientoESPECIFICAR, this.p07Atendio, this.p08Check, this.p08CheckEspecificar, this.p09Check, this.p09CheckEspecificar,
    this.p10Frecuencia, this.p11Vive, this.p12Familia, this.p12FamiliaB, this.p13Ayudas, this.p13AyudasB,
    this.p14Ingreso, this.p15Tipovivienda, this.p15TipoviviendaB, this.p16Riesgo, this.p16RiesgoB, this.p17Check, this.p17CheckEspecificar,
    this.p18Emprendimiento
  });

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
      id_gestor: json['id_gestor'] as int?,
      
      p01CobroPension: json['p01CobroPension'] as int?,
      p02TipoMeses: json['p02TipoMeses'] as int?,
      p03Check: json['p03Check'] as String?,
      p03CheckEspecificar: json['p03CheckEspecificar'] as String?,
      p04Check: json['p04Check'] as String?,
      p05pension: json['p05pension'] as int?,
      p06Establecimiento: json['p06Establecimiento'] as int?,
      p06EstablecimientoESPECIFICAR: json['p06EstablecimientoESPECIFICAR'] as String,
      p07Atendio: json['p07Atendio'] as int?,
      p08CheckEspecificar: json['p08CheckEspecificar'] as String?,
      p09Check: json['p09Check'] as String?,
      p09CheckEspecificar: json['p09CheckEspecificar'] as String?,
      p10Frecuencia: json['p10Frecuencia'] as int?,
      p11Vive: json['p11Vive'] as int?,
      p12Familia: json['p12Familia'] as int?,
      p12FamiliaB: json['p12FamiliaB'] as int?,
      p13Ayudas: json['p13Ayudas'] as int?,
      p13AyudasB: json['p13AyudasB'] as int?,
      p14Ingreso: json['p14Ingreso'] as int?,
      p15Tipovivienda: json['p15Tipovivienda'] as int?,
      p15TipoviviendaB: json['p15TipoviviendaB'] as int?,
      p16Riesgo: json['p15TipoviviendaB'] as int?,
      p16RiesgoB: json['p15TipoviviendaB'] as int?,
      p17Check: json['p15TipoviviendaB'] as String?,
      p17CheckEspecificar: json['p15TipoviviendaB'] as String?,
      p18Emprendimiento: json['p15TipoviviendaB'] as int?,

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
      "latitud":latitud,
      "id_gestor": id_gestor,
      "p01CobroPension":p01CobroPension,
      "p02TipoMeses":p02TipoMeses,
      "p03Check":p03Check,
      "p03CheckEspecificar":p03CheckEspecificar,
      "p04Check":p04Check,
      "p05pension":p05pension,
      "p06Establecimiento":p06Establecimiento,
      "p06EstablecimientoESPECIFICAR":p06EstablecimientoESPECIFICAR,
      "p07Atendio":p07Atendio,
      "p08Check":p08Check,
      "p08CheckEspecificar":p08CheckEspecificar,
      "p09Check":p09Check,
      "p09CheckEspecificar":p09CheckEspecificar,
      "p10Frecuencia":p10Frecuencia,
      "p11Vive":p11Vive,
      "p12Familia":p12Familia,
      "p12FamiliaB":p12FamiliaB,
      "p13Ayudas":p13Ayudas,
      "p13AyudasB":p13AyudasB,
      "p14Ingreso":p14Ingreso,
      "p15Tipovivienda":p15Tipovivienda,
      "p15TipoviviendaB":p15TipoviviendaB,
      "p16Riesgo":p16Riesgo,
      "p16RiesgoB":p16RiesgoB,
      "p17Check":p17Check,
      "p17CheckEspecificar":p17CheckEspecificar,
      "p18Emprendimiento": p18Emprendimiento,

    };
  }

}
