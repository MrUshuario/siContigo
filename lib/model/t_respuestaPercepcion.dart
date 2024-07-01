import 'package:floor/floor.dart';

@entity
class Respuestapercepcion {
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

  int? p01;
  int? p02;
  int? p03;
  int? p04;
  int? p05;
  int? p06;
  int? p07;
  int? p08;
  int? p09;
  int? p10;
  int? p11;
  int? p12;
  int? p13;
  int? p14;
  int? p15;
  int? p16;
  int? p17;
  int? p18;
  int? p19;
  int? p20;
  int? p21;
  int? p22;
  int? p23;
  int? p24;
  int? p25;
  int? p26;
  int? p27;
  int? p28;
  int? p29;
  int? p30;
  int? p31;
  int? p32;
  int? p33;
  int? p34;
  int? p35;
  int? p36;
  int? p37;
  int? p38;
  int? p39;
  int? p40;
  int? p41;
  int? p42;
  int? p43;
  int? p44;
  int? p45;
  int? p46;
  int? p47;
  int? p48;
  int? p49;
  int? p50;
  int? p51;
  int? p52;
  int? p53;
  int? p54;
  int? p55;
  int? p56;
  int? p57;

  Respuestapercepcion({
    this.cod, this.idformato, this.id_usuario, this.fecha,
    this.respuestas, this.puntaje, this.longitud, this.latitud, this.id_gestor,
    this.p01,this.p02,this.p03,this.p04,this.p05,
    this.p06,this.p07,this.p08,this.p09,this.p10,
    this.p11,this.p12,this.p13,this.p14,this.p15,
    this.p16,this.p17,this.p18,this.p19,this.p20,
    this.p21,this.p22,this.p23,this.p24,this.p25,
    this.p26,this.p27,this.p28,this.p29,this.p30,
    this.p31,this.p32,this.p33,this.p34,this.p35,
    this.p36,this.p37,this.p38,this.p39,this.p40,
    this.p41,this.p42,this.p43,this.p44,this.p45,
    this.p46,this.p47,this.p48,this.p49,this.p50,
    this.p51,this.p52,this.p53,this.p54,this.p55,
    this.p56,this.p57,
  });

  factory Respuestapercepcion.fromJson(dynamic json) {
    return Respuestapercepcion(
      idformato: json['idformato'] as int?,
      id_usuario: json['id_usuario'] as int?,
      fecha: json['fecha'] as String?,
      respuestas: json['respuestas'] as String?,
      puntaje: json['puntaje'] as int?,
      longitud: json['longitud'] as String?,
      latitud: json['latitud'] as String?,
      id_gestor: json['id_gestor'] as int?,

      p01: json['p01'] as int?,
      p02: json['p02'] as int?,
      p03: json['p03'] as int?,
      p04: json['p04'] as int?,
      p05: json['p05'] as int?,
      p06: json['p06'] as int?,
      p07: json['p07'] as int?,
      p08: json['p08'] as int?,
      p09: json['p09'] as int?,
      p10: json['p10'] as int?,
      p11: json['p11'] as int?,
      p12: json['p12'] as int?,
      p13: json['p13'] as int?,
      p14: json['p14'] as int?,
      p15: json['p15'] as int?,
      p16: json['p16'] as int?,
      p17: json['p17'] as int?,
      p18: json['p18'] as int?,
      p19: json['p19'] as int?,
      p20: json['p20'] as int?,
      p21: json['p21'] as int?,
      p22: json['p22'] as int?,
      p23: json['p23'] as int?,
      p24: json['p24'] as int?,
      p25: json['p25'] as int?,
      p26: json['p26'] as int?,
      p27: json['p27'] as int?,
      p28: json['p28'] as int?,
      p29: json['p29'] as int?,
      p30: json['p30'] as int?,
      p31: json['p31'] as int?,
      p32: json['p32'] as int?,
      p33: json['p33'] as int?,
      p34: json['p34'] as int?,
      p35: json['p35'] as int?,
      p36: json['p36'] as int?,
      p37: json['p37'] as int?,
      p38: json['p38'] as int?,
      p39: json['p39'] as int?,
      p40: json['p40'] as int?,
      p41: json['p41'] as int?,
      p42: json['p42'] as int?,
      p43: json['p43'] as int?,
      p44: json['p44'] as int?,
      p45: json['p45'] as int?,
      p46: json['p46'] as int?,
      p47: json['p47'] as int?,
      p48: json['p48'] as int?,
      p49: json['p49'] as int?,
      p50: json['p50'] as int?,
      p51: json['p51'] as int?,
      p52: json['p52'] as int?,
      p53: json['p53'] as int?,
      p54: json['p54'] as int?,
      p55: json['p55'] as int?,
      p56: json['p56'] as int?,
      p57: json['p57'] as int?,
    );
  }

  static List<Respuestapercepcion> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<Respuestapercepcion> items =
    bienvenidaList.map((e) => Respuestapercepcion.fromJson(e)).toList();
    return items ?? [];
  }

  Map<String, dynamic> toMap() {
    return {
      "idformato": idformato,
      "id_usuario": id_usuario,
      "fecha": fecha,
      "respuestas": respuestas,
      "puntaje":puntaje,
      "longitud":longitud,
      "latitud":latitud,
      "id_gestor": id_gestor,

      "p01":p01,
      "p02":p02,
      "p03":p03,
      "p04":p04,
      "p05":p05,
      "p06":p06,
      "p07":p07,
      "p08":p08,
      "p09":p09,
      "p10":p10,
      "p11":p11,
      "p12":p12,
      "p13":p13,
      "p14":p14,
      "p15":p15,
      "p16":p16,
      "p17":p17,
      "p18":p18,
      "p19":p19,
      "p20":p20,
      "p21":p21,
      "p22":p22,
      "p23":p23,
      "p24":p24,
      "p25":p25,
      "p26":p26,
      "p27":p27,
      "p28":p28,
      "p29":p29,
      "p30":p30,
      "p31":p31,
      "p32":p32,
      "p33":p33,
      "p34":p34,
      "p35":p35,
      "p36":p36,
      "p37":p37,
      "p38":p38,
      "p39":p39,
      "p40":p40,
      "p41":p41,
      "p42":p42,
      "p43":p43,
      "p44":p44,
      "p45":p45,
      "p46":p46,
      "p47":p47,
      "p48":p48,
      "p49":p49,
      "p50":p50,
      "p51":p51,
      "p52":p52,
      "p53":p53,
      "p54":p54,
      "p55":p55,
      "p56":p56,
      "p57":p57,

    };
  }

}
