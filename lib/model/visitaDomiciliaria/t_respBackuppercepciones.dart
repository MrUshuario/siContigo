import 'package:floor/floor.dart';

@entity
class RespuestaBACKUPpercepcion {
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
  String? nombre_usuario;

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
  String? p11percepcion;
  int? p12percepcion;
  int? p13percepcion;
  int? p14percepcion;
  int? p15percepcion;

  int? p16percepcion1;
  int? p16percepcion2;
  int? p16percepcion3;


  String? p16percepcionEspecificar1;
  String? p16percepcionEspecificar2;
  String? p16percepcionEspecificar3;

  int? p17percepcion1;
  int? p17percepcion2;
  int? p17percepcion3;

  int? p18percepcion1;
  int? p18percepcion2;
  int? p18percepcion3;

  String? p19percepcion1;
  String? p19percepcion2;
  String? p19percepcion3;

  int? p20percepcion;
  int? p21percepcion;
  int? p22percepcion;
  String? p21percepcionEspecificar;
  int? p23percepcion;
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


  RespuestaBACKUPpercepcion({
    this.cod, this.idformato, this.id_usuario, this.fecha,
    this.respuestas, this.puntaje, this.longitud, this.latitud,this.id_gestor,this.tipoencuesta,

    this.p01percepcion,this.p02percepcion,this.p03percepcion,this.p04percepcion,this.p05percepcion,
    this.p06percepcion,this.p07percepcion,this.p08percepcion,this.p09percepcion,this.p10percepcion,
    this.p11percepcion,this.p12percepcion,this.p13percepcion,this.p14percepcion,this.p15percepcion,
    this.p16percepcion1,this.p16percepcion2,this.p16percepcion3,

    this.p17percepcion1, this.p17percepcion2, this.p17percepcion3,
    this.p18percepcion1, this.p18percepcion2, this.p18percepcion3,
    this.p19percepcion1, this.p19percepcion2, this.p19percepcion3,

    this.p20percepcion,
    this.p21percepcion,this.p22percepcion,this.p23percepcion,this.p24percepcion,this.p25percepcion,
    this.p26percepcion,this.p27percepcion,this.p28percepcion,this.p29percepcion,this.p30percepcion,
    this.p31percepcion,this.p32percepcion,this.p33percepcion,this.p34percepcion,this.p35percepcion,
    this.p36percepcion,this.p37percepcion,this.p38percepcion,this.p39percepcion,this.p40percepcion,
    this.p41percepcion,this.p42percepcion,this.p43percepcion,this.p44percepcion,this.p45percepcion,
    this.p46percepcion,this.p47percepcion,this.p48percepcion,this.p49percepcion,this.p50percepcion,
    this.p51percepcion,this.p52percepcion,this.p53percepcion,this.p54percepcion,this.p55percepcion,
    this.p56percepcion,this.p57percepcion, this.p16percepcionEspecificar1, this.p16percepcionEspecificar2, this.p16percepcionEspecificar3,
    this.p21percepcionEspecificar, this.p44percepcionEspecificar,
    this.p45percepcionEspecificar, this.p46percepcionEspecificar, this.p49percepcionEspecificar,
    this.p52percepcionEspecificar, this.p57percepcionEspecificar, this.p42percepcionEspecificar,
    this.p54percepcionEspecificar, this.nombre_usuario
  });

  factory RespuestaBACKUPpercepcion.fromJson(dynamic json) {
    return RespuestaBACKUPpercepcion(
      cod: json['cod'] as int?,
      idformato: json['idformato'] as int?,
      id_usuario: json['id_usuario'] as String?,
      fecha: json['fecha'] as String?,
      respuestas: json['respuestas'] as String?,
      puntaje: json['puntaje'] as int?,
      longitud: json['longitud'] as String?,
      latitud: json['latitud'] as String?,
      id_gestor: json['id_gestor'] as int?,
      tipoencuesta: json['tipoencuesta'] as int?,
      nombre_usuario: json['nombre_usuario'] as String?,

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
        p11percepcion: json['p11percepcion'] as String?,
        p12percepcion: json['p12percepcion'] as int?,
        p13percepcion: json['p13percepcion'] as int?,
        p14percepcion: json['p14percepcion'] as int?,
        p15percepcion: json['p15percepcion'] as int?,
        p16percepcion1: json['p16percepcion1'] as int?,
        p16percepcion2: json['p16percepcion2'] as int?,
        p16percepcion3: json['p16percepcion3'] as int?,

        p17percepcion1: json['p17percepcion1'] as int?,
        p17percepcion2: json['p17percepcion2'] as int?,
        p17percepcion3: json['p17percepcion3'] as int?,

        p18percepcion1: json['p18percepcion1'] as int?,
        p18percepcion2: json['p18percepcion2'] as int?,
        p18percepcion3: json['p18percepcion3'] as int?,

        p19percepcion1: json['p19percepcion1'] as String?,
        p19percepcion2: json['p19percepcion2'] as String?,
        p19percepcion3: json['p19percepcion3'] as String?,

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
        p16percepcionEspecificar1: json['p16percepcionEspecificar1'] as String?,
        p16percepcionEspecificar2: json['p16percepcionEspecificar2'] as String?,
        p16percepcionEspecificar3: json['p16percepcionEspecificar3'] as String?,

        p21percepcionEspecificar: json['p21percepcionEspecificar'] as String?,
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

  static List<RespuestaBACKUPpercepcion> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<RespuestaBACKUPpercepcion> items =
    bienvenidaList.map((e) => RespuestaBACKUPpercepcion.fromJson(e)).toList();
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
      "p16percepcion1":p16percepcion1,
      "p16percepcion2":p16percepcion2,
      "p16percepcion3":p16percepcion3,
      "p17percepcion1":p17percepcion1,
      "p17percepcion2":p17percepcion2,
      "p17percepcion3":p17percepcion3,
      "p18percepcion1":p18percepcion1,
      "p18percepcion2":p18percepcion2,
      "p18percepcion3":p18percepcion3,

      "p19percepcion1":p19percepcion1,
      "p19percepcion2":p19percepcion2,
      "p19percepcion3":p19percepcion3,

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
      "p16percepcionEspecificar1":p16percepcionEspecificar1,
      "p16percepcionEspecificar2":p16percepcionEspecificar2,
      "p16percepcionEspecificar3":p16percepcionEspecificar3,
      "p21percepcionEspecificar": p21percepcionEspecificar,
      "p44percepcionEspecificar": p44percepcionEspecificar,
      "p45percepcionEspecificar": p45percepcionEspecificar,
      "p46percepcionEspecificar": p46percepcionEspecificar,
      "p49percepcionEspecificar": p49percepcionEspecificar,
      "p52percepcionEspecificar": p52percepcionEspecificar,
      "p57percepcionEspecificar": p57percepcionEspecificar,
      "p42percepcionEspecificar": p42percepcionEspecificar,
      "p54percepcionEspecificar": p54percepcionEspecificar,
      "nombre_usuario":nombre_usuario,
    };
  }

}
