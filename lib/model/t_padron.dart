

import 'package:floor/floor.dart';

@entity
class Padron {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? fechaCorte;
  String? hogarUbigeo;
  String? hogarDepartamento;
  String? hogarRegion;
  String? hogarProvincia;
  String? hogarDistrito;
  String? hogarNombreCcpp;
  String? hogarDireccionDescripcion;
  String? area;
  String? comunidadNativa;
  String? puebloIndigena;
  String? saldoCuenta;
  String? estadoCuenta;
  String? tarjetizacion;
  String? tipoDoc;
  String? dniCe;
  String? apPaterno;
  String? apMaterno;
  String? nombre;
  String? fechaNacimiento;
  String? edadPadron;
  String? sexo;
  String? telefonoUsuario; //PODRIA SER INT
  String? cse;
  String? vigenciaCse;
  String? condicionEdad;
  String? rangoEdad;
  String? estadoActivo;
  String? estadoDetalle;
  String? ingreso;
  String? ultimoPadronAfiliado;
  String? motivoDesafiliacionSuspencion;  //PODRIA SER INT
  String? detalleDesafiliacionSuspencion;
  String? alertaGeneral;
  String? recomendacion;  //PODRIA SER INT
  String? tieneAutorizacion;
  String? estadoAutorizacion;
  String? detalleObservacion;
  String? rde;
  String? fechaRde;
  String? parentezco;
  String? nombreAutorizado;
  String? tipoDocAutorizado;
  String? dniAutorizado;
  String? autorizadoSexo;
  String? telefonoAutorizado;
  String? correoAutorizado;
  String? prioridad;
  String? tipoDistrito;


  Padron(
      {this.id, this.fechaCorte, this.hogarUbigeo, this.hogarDepartamento, this.hogarRegion,
        this.hogarProvincia, this.hogarDistrito, this.hogarNombreCcpp, this.hogarDireccionDescripcion, this.area, this.comunidadNativa,
        this.puebloIndigena, this.saldoCuenta, this.estadoCuenta, this.tarjetizacion, this.tipoDoc, this.dniCe,
        this.apPaterno, this.apMaterno, this.nombre, this.fechaNacimiento, this.edadPadron, this.sexo,
        this.telefonoUsuario, this.cse, this.vigenciaCse, this.condicionEdad, this.rangoEdad, this.estadoActivo,
        this.estadoDetalle, this.ingreso, this.ultimoPadronAfiliado, this.motivoDesafiliacionSuspencion, this.detalleDesafiliacionSuspencion, this.alertaGeneral,
        this.recomendacion, this.tieneAutorizacion, this.estadoAutorizacion, this.detalleObservacion, this.rde, this.fechaRde,
        this.parentezco, this.nombreAutorizado, this.tipoDocAutorizado, this.dniAutorizado, this.autorizadoSexo, this.telefonoAutorizado,
        this.correoAutorizado, this.prioridad, this.tipoDistrito
      });

  factory Padron.fromJson(dynamic json) {
    return Padron(
    id: json['id'],
    fechaCorte: json['fechaCorte'],
    hogarUbigeo: json['hogarUbigeo'],
    hogarDepartamento: json['hogarDepartamento'],
    hogarRegion: json['hogarRegion'],
    hogarProvincia: json['hogarProvincia'],
    hogarDistrito: json['hogarDistrito'],
    hogarNombreCcpp: json['hogarNombreCcpp'],
    hogarDireccionDescripcion: json['hogarDireccionDescripcion'],
    area: json['area'],
    comunidadNativa: json['comunidadNativa'],
    puebloIndigena: json['puebloIndigena'],
    saldoCuenta: json['saldoCuenta'],
    estadoCuenta: json['estadoCuenta'],
    tarjetizacion: json['tarjetizacion'],
    tipoDoc: json['tipoDoc'],
    dniCe: json['dniCe'],
    apPaterno: json['apPaterno'],
    apMaterno: json['apMaterno'],
    nombre: json['nombre'],
    fechaNacimiento: json['fechaNacimiento'],
    edadPadron: json['edadPadron'],
    sexo: json['sexo'],
    telefonoUsuario: json['telefonoUsuario'],
    cse: json['cse'],
    vigenciaCse: json['vigenciaCse'],
    condicionEdad: json['condicionEdad'],
    rangoEdad: json['rangoEdad'],
    estadoActivo: json['estadoActivo'],
    estadoDetalle: json['estadoDetalle'],
    ingreso: json['ingreso'],
    ultimoPadronAfiliado: json['ultimoPadronAfiliado'],
    motivoDesafiliacionSuspencion: json['motivoDesafiliacionSuspencion'],
    detalleDesafiliacionSuspencion: json['detalleDesafiliacionSuspencion'],
    alertaGeneral: json['alertaGeneral'],
    recomendacion: json['recomendacion'],
    tieneAutorizacion: json['tieneAutorizacion'],
    estadoAutorizacion: json['estadoAutorizacion'],
    detalleObservacion: json['detalleObservacion'],
    rde: json['rde'],
    fechaRde: json['fechaRde'],
    parentezco: json['parentezco'],
    nombreAutorizado: json['nombreAutorizado'],
    tipoDocAutorizado: json['tipoDocAutorizado'],
    dniAutorizado: json['dniAutorizado'],
    autorizadoSexo: json['autorizadoSexo'],
    telefonoAutorizado: json['telefonoAutorizado'],
    correoAutorizado: json['correoAutorizado'],
    prioridad: json['prioridad'],
    tipoDistrito: json['tipoDistrito'],

    );
  }

  static List<Padron> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<Padron> items =
    bienvenidaList.map((e) => Padron.fromJson(e)).toList();
    return items;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
    "fechaCorte": fechaCorte,
    "hogarUbigeo": hogarUbigeo,
    "hogarDepartamento": hogarDepartamento,
    "hogarRegion": hogarRegion,
    "hogarProvincia": hogarProvincia,
    "hogarDistrito": hogarDistrito,
    "hogarNombreCcpp": hogarNombreCcpp,
    "hogarDireccionDescripcion": hogarDireccionDescripcion,
    "area": area,
    "comunidadNativa": comunidadNativa,
    "puebloIndigena": puebloIndigena,
    "saldoCuenta": saldoCuenta,
    "estadoCuenta": estadoCuenta,
    "tarjetizacion": tarjetizacion,
    "tipoDoc": tipoDoc,
    "dniCe": dniCe,
    "apPaterno": apPaterno,
    "apMaterno": apMaterno,
    "nombre": nombre,
    "fechaNacimiento": fechaNacimiento,
    "edadPadron": edadPadron,
    "sexo": sexo,
    "telefonoUsuario": telefonoUsuario,
    "cse": cse,
    "vigenciaCse": vigenciaCse,
    "condicionEdad": condicionEdad,
    "rangoEdad": rangoEdad,
    "estadoActivo": estadoActivo,
    "estadoDetalle": estadoDetalle,
    "ingreso": ingreso,
    "ultimoPadronAfiliado": ultimoPadronAfiliado,
    "motivoDesafiliacionSuspencion": motivoDesafiliacionSuspencion,
    "detalleDesafiliacionSuspencion": detalleDesafiliacionSuspencion,
    "alertaGeneral": alertaGeneral,
    "recomendacion": recomendacion,
    "tieneAutorizacion": tieneAutorizacion,
    "estadoAutorizacion": estadoAutorizacion,
    "detalleObservacion": detalleObservacion,
    "rde": rde,
    "fechaRde": fechaRde,
    "parentezco": parentezco,
    "nombreAutorizado": nombreAutorizado,
    "tipoDocAutorizado": tipoDocAutorizado,
    "dniAutorizado": dniAutorizado,
    "autorizadoSexo": autorizadoSexo,
    "telefonoAutorizado": telefonoAutorizado,
    "correoAutorizado": correoAutorizado,
    "prioridad": prioridad,
    "tipoDistrito": tipoDistrito,
    };
  }
}
