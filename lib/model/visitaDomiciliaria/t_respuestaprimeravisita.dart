import 'package:floor/floor.dart';

@entity
class RespuestaPrimeraVisita {
  @PrimaryKey(autoGenerate: true)
  int? cod;
  int? idformato;
  String? id_usuario;
  String? fecha;
  String? respuestas;
  int? puntaje;
  String? longitud;
  String? latitud;
  int? id_gestor;

  int? tipoencuesta;

  //PRIMERA VISITA
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

  //PERCEPCION
  String? p01percepcion;
  String? p02percepcion;
  String? p03percepcion;
  String? p04percepcion;
  int? p05percepcion;
  String? p06percepcion;
  String? p07percepcion;
  String? p08percepcion;
  int? p09percepcion;
  int? p10percepcion;
  int? p11percepcion;
  String? p12percepcion;
  int? p13percepcion;
  int? p14percepcion;
  int? p15percepcion;
  int? p16percepcion;
  String? p16percepcionEspecificar;
  int? p17percepcion;
  int? p18percepcion;
  String? p19percepcion;
  int? p20percepcion;
  int? p21percepcion;
  int? p22percepcion;
  String? p22percepcionEspecificar;
  int? p23percepcion;
  String? p23percepcionEspecificar;
  int? p24percepcion;
  int? p25percepcion;
  int? p26percepcion;
  int? p27percepcion;
  int? p28percepcion;
  int? p29percepcion;
  String? p30percepcion;
  int? p31percepcion;
  int? p32percepcion;
  int? p33percepcion;
  int? p34percepcion;
  int? p35percepcion;
  int? p36percepcion;
  int? p37percepcion;
  int? p38percepcion;
  int? p39percepcion;
  int? p40percepcion;
  int? p41percepcion;
  String? p42percepcion;
  int? p43percepcion;
  int? p44percepcion;
  String? p44percepcionEspecificar;
  int? p45percepcion;
  String? p45percepcionEspecificar;
  int? p46percepcion;
  String? p46percepcionEspecificar;
  int? p47percepcion;
  int? p48percepcion;
  int? p49percepcion;
  String? p49percepcionEspecificar;
  String? p50percepcion;
  int? p51percepcion;
  String? p52percepcion;
  String? p52percepcionEspecificar;
  int? p53percepcion;
  String? p54percepcion;
  int? p55percepcion;
  int? p56percepcion;
  int? p57percepcion;
  String? p57percepcionEspecificar;
  String? p42percepcionEspecificar;
  String? p54percepcionEspecificar;


  RespuestaPrimeraVisita({
    this.cod, this.idformato, this.id_usuario, this.fecha,
    this.respuestas, this.puntaje, this.longitud, this.latitud, this.id_gestor,
    this.p01CobroPension, this.p02TipoMeses, this.p03Check, this.p03CheckEspecificar, this.p04Check, this.p05pension,
    this.p06Establecimiento, this.p06EstablecimientoESPECIFICAR, this.p07Atendio, this.p08Check, this.p08CheckEspecificar, this.p09Check, this.p09CheckEspecificar,
    this.p10Frecuencia, this.p11Vive, this.p12Familia, this.p12FamiliaB, this.p13Ayudas, this.p13AyudasB,
    this.p14Ingreso, this.p15Tipovivienda, this.p15TipoviviendaB, this.p16Riesgo, this.p16RiesgoB, this.p17Check, this.p17CheckEspecificar,
    this.p18Emprendimiento, this.tipoencuesta,

    this.p01percepcion,this.p02percepcion,this.p03percepcion,this.p04percepcion,this.p05percepcion,
    this.p06percepcion,this.p07percepcion,this.p08percepcion,this.p09percepcion,this.p10percepcion,
    this.p11percepcion,this.p12percepcion,this.p13percepcion,this.p14percepcion,this.p15percepcion,
    this.p16percepcion,this.p17percepcion,this.p18percepcion,this.p19percepcion,this.p20percepcion,
    this.p21percepcion,this.p22percepcion,this.p23percepcion,this.p24percepcion,this.p25percepcion,
    this.p26percepcion,this.p27percepcion,this.p28percepcion,this.p29percepcion,this.p30percepcion,
    this.p31percepcion,this.p32percepcion,this.p33percepcion,this.p34percepcion,this.p35percepcion,
    this.p36percepcion,this.p37percepcion,this.p38percepcion,this.p39percepcion,this.p40percepcion,
    this.p41percepcion,this.p42percepcion,this.p43percepcion,this.p44percepcion,this.p45percepcion,
    this.p46percepcion,this.p47percepcion,this.p48percepcion,this.p49percepcion,this.p50percepcion,
    this.p51percepcion,this.p52percepcion,this.p53percepcion,this.p54percepcion,this.p55percepcion,
    this.p56percepcion,this.p57percepcion, this.p16percepcionEspecificar,
    this.p22percepcionEspecificar, this.p23percepcionEspecificar, this.p44percepcionEspecificar,
    this.p45percepcionEspecificar, this.p46percepcionEspecificar, this.p49percepcionEspecificar,
    this.p52percepcionEspecificar, this.p57percepcionEspecificar, this.p42percepcionEspecificar,
    this.p54percepcionEspecificar

  });

  factory RespuestaPrimeraVisita.fromJson(dynamic json) {
    return RespuestaPrimeraVisita(
      cod: json['cod'] as int?,
      idformato: json['idformato'] as int?,
      id_usuario: json['id_usuario'] as String?,
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
      tipoencuesta: json['tipoencuesta'] as int?,

      p01percepcion: json['p01percepcion'] as String?,
      p02percepcion: json['p02percepcion'] as String?,
      p03percepcion: json['p03percepcion'] as String?,
      p04percepcion: json['p04percepcion'] as String?,
      p05percepcion: json['p05percepcion'] as int?,
      p06percepcion: json['p06percepcion'] as String?,
      p07percepcion: json['p07percepcion'] as String?,
      p08percepcion: json['p08percepcion'] as String?,
      p09percepcion: json['p09percepcion'] as int?,
      p10percepcion: json['p10percepcion'] as int?,
      p11percepcion: json['p11percepcion'] as int?,
      p12percepcion: json['p12percepcion'] as String?,
      p13percepcion: json['p13percepcion'] as int?,
      p14percepcion: json['p14percepcion'] as int?,
      p15percepcion: json['p15percepcion'] as int?,
      p16percepcion: json['p16percepcion'] as int?,
      p17percepcion: json['p17percepcion'] as int?,
      p18percepcion: json['p18percepcion'] as int?,
      p19percepcion: json['p19percepcion'] as String?,
      p20percepcion: json['p20percepcion'] as int?,
      p21percepcion: json['p21percepcion'] as int?,
      p22percepcion: json['p22percepcion'] as int?,
      p23percepcion: json['p23percepcion'] as int?,
      p24percepcion: json['p24percepcion'] as int?,
      p25percepcion: json['p25percepcion'] as int?,
      p26percepcion: json['p26percepcion'] as int?,
      p27percepcion: json['p27percepcion'] as int?,
      p28percepcion: json['p28percepcion'] as int?,
      p29percepcion: json['p29percepcion'] as int?,
      p30percepcion: json['p30percepcion'] as String?,
      p31percepcion: json['p31percepcion'] as int?,
      p32percepcion: json['p32percepcion'] as int?,
      p33percepcion: json['p33percepcion'] as int?,
      p34percepcion: json['p34percepcion'] as int?,
      p35percepcion: json['p35percepcion'] as int?,
      p36percepcion: json['p36percepcion'] as int?,
      p37percepcion: json['p37percepcion'] as int?,
      p38percepcion: json['p38percepcion'] as int?,
      p39percepcion: json['p39percepcion'] as int?,
      p40percepcion: json['p40percepcion'] as int?,
      p41percepcion: json['p41percepcion'] as int?,
      p42percepcion: json['p42percepcion'] as String?,
      p43percepcion: json['p43percepcion'] as int?,
      p44percepcion: json['p44percepcion'] as int?,
      p45percepcion: json['p45percepcion'] as int?,
      p46percepcion: json['p46percepcion'] as int?,
      p47percepcion: json['p47percepcion'] as int?,
      p48percepcion: json['p48percepcion'] as int?,
      p49percepcion: json['p49percepcion'] as int?,
      p50percepcion: json['p50percepcion'] as String?,
      p51percepcion: json['p51percepcion'] as int?,
      p52percepcion: json['p52percepcion'] as String?,
      p53percepcion: json['p53percepcion'] as int?,
      p54percepcion: json['p54percepcion'] as String?,
      p55percepcion: json['p55percepcion'] as int?,
      p56percepcion: json['p56percepcion'] as int?,
      p57percepcion: json['p57percepcion'] as int?,
      p16percepcionEspecificar: json['p16percepcionEspecificar'] as String?,
      p22percepcionEspecificar: json['p22percepcionEspecificar'] as String?,
      p23percepcionEspecificar: json['p23percepcionEspecificar'] as String?,
      p44percepcionEspecificar: json['p44percepcionEspecificar'] as String?,
      p45percepcionEspecificar: json['p45percepcionEspecificar'] as String?,
      p46percepcionEspecificar: json['p46percepcionEspecificar'] as String?,
      p49percepcionEspecificar: json['p49percepcionEspecificar'] as String?,
      p52percepcionEspecificar: json['p52percepcionEspecificar'] as String?,
      p57percepcionEspecificar: json['p57percepcionEspecificar'] as String?,
      p42percepcionEspecificar: json['p42percepcionEspecificar'] as String?,
      p54percepcionEspecificar: json['p54percepcionEspecificar'] as String?


    );
  }

  static List<RespuestaPrimeraVisita> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<RespuestaPrimeraVisita> items =
    bienvenidaList.map((e) => RespuestaPrimeraVisita.fromJson(e)).toList();
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
      "tipoencuesta": tipoencuesta,

      "p01percepcion":p01percepcion,
      "p02percepcion":p02percepcion,
      "p03percepcion":p03percepcion,
      "p04percepcion":p04percepcion,
      "p05percepcion":p05percepcion,
      "p06percepcion":p06percepcion,
      "p07percepcion":p07percepcion,
      "p08percepcion":p08percepcion,
      "p09percepcion":p09percepcion,
      "p10percepcion":p10percepcion,
      "p11percepcion":p11percepcion,
      "p12percepcion":p12percepcion,
      "p13percepcion":p13percepcion,
      "p14percepcion":p14percepcion,
      "p15percepcion":p15percepcion,
      "p16percepcion":p16percepcion,
      "p17percepcion":p17percepcion,
      "p18percepcion":p18percepcion,
      "p19percepcion":p19percepcion,
      "p20percepcion":p20percepcion,
      "p21percepcion":p21percepcion,
      "p22percepcion":p22percepcion,
      "p23percepcion":p23percepcion,
      "p24percepcion":p24percepcion,
      "p25percepcion":p25percepcion,
      "p26percepcion":p26percepcion,
      "p27percepcion":p27percepcion,
      "p28percepcion":p28percepcion,
      "p29percepcion":p29percepcion,
      "p30percepcion":p30percepcion,
      "p31percepcion":p31percepcion,
      "p32percepcion":p32percepcion,
      "p33percepcion":p33percepcion,
      "p34percepcion":p34percepcion,
      "p35percepcion":p35percepcion,
      "p36percepcion":p36percepcion,
      "p37percepcion":p37percepcion,
      "p38percepcion":p38percepcion,
      "p39percepcion":p39percepcion,
      "p40percepcion":p40percepcion,
      "p41percepcion":p41percepcion,
      "p42percepcion":p42percepcion,
      "p43percepcion":p43percepcion,
      "p44percepcion":p44percepcion,
      "p45percepcion":p45percepcion,
      "p46percepcion":p46percepcion,
      "p47percepcion":p47percepcion,
      "p48percepcion":p48percepcion,
      "p49percepcion":p49percepcion,
      "p50percepcion":p50percepcion,
      "p51percepcion":p51percepcion,
      "p52percepcion":p52percepcion,
      "p53percepcion":p53percepcion,
      "p54percepcion":p54percepcion,
      "p55percepcion":p55percepcion,
      "p56percepcion":p56percepcion,
      "p57percepcion":p57percepcion,
      "p16percepcionEspecificar":p16percepcionEspecificar,
      "p22percepcionEspecificar": p22percepcionEspecificar,
      "p23percepcionEspecificar": p23percepcionEspecificar,
      "p44percepcionEspecificar": p44percepcionEspecificar,
      "p45percepcionEspecificar": p45percepcionEspecificar,
      "p46percepcionEspecificar": p46percepcionEspecificar,
      "p49percepcionEspecificar": p49percepcionEspecificar,
      "p52percepcionEspecificar": p52percepcionEspecificar,
      "p57percepcionEspecificar": p57percepcionEspecificar,
      "p42percepcionEspecificar": p42percepcionEspecificar,
      "p54percepcionEspecificar": p54percepcionEspecificar,
    };
  }

}
