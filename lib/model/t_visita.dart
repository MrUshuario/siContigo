import 'package:floor/floor.dart';

@entity
class Visitas {
  @PrimaryKey(autoGenerate: true)
  int? codigoVisita;
  String? descripcionTema; //CHARLA STRING
  int? enHogar; //Condicion visita

  String? apepat;
  String? apemat;
  String? nombres;

  String? nombreDepartamento;
  String? nombreProvinci;
  String? nombreDistrito;

  String? nombreViolenciaDetectada;
  String? nombreVictima;
  String? nombreVinculoPersonaAgresora;
  String? descripcionInstancia;

  int? flagVictimaUsuario; //RAdio USUIARIO 1 FAMILIAR 2 OTROS 3
  int? codigoViolenciaDetectada; //Viende de un select pero debo agarrar el index
  int? codigoVictima; //VIOLENCIA SELECT
  int? codigoVinculoPersonaAgresora; //VIOLENCIA SELECT
  int? codigoInstancia; //Instancia
  int? flagInstanciaSi; //se procederea derivacion?
  String? observacionSaberes; //INFORMACION DEL CASO

  String? placa; //BITACORA
  int? kilometraje; //BITACORA
  String? monto; //BITACORA
  String? galones; //BITACORA
  String? grifo; //BITACORA

  String? telefonoContacto; //contacto referencia
  String? personaContacto; //contacto referencia

  String? horaInicio; //ESTOS 4 NO LO USAN PARA NADA!
  String? horaFin;
  String? horaInicio2;
  String? horaFin2;

  String? fechaFallecimiento; // VISITA PRESENCIAL FECHA FALLECIMIENTO
  int?      tipoCondicion; //VISITA PRESENCIAL OCURRENCIA = 0 | VISITA = 1
  String?  direccion; //FORMULARIO NO MUERTO
  String?  distrito; //FORMULARIO NO MUERTO
  int?   recibeTratamientoDiabetes; //SI COBRO (1) No COBRO (2)
  String? otrosDiabetes; //DETALLAR PORQUE
  String? otrosHipertension;
  int? codigoMedicacionDiabetes; //ATV AGENCIA
  int? cumpleTratamientoHipertension; //Por algu nmotivo es declaracion jurada
  String? otrosArtritis;
  int? tieneArtritis;
  String? descripcionMedicacionOtraEnfermedad; // DESCIRPCION VULNERABILIDAD ADICIONAL SELECT
  int? recibeTratamientoOtraEnfermedad; // INDICE VULNERABILIDAD ADICIONAL SELECT
  int? codigoSaberesTema; //CHARLA INDICE //USUARIOS PRODUCTOS (ENCUENTRO SABERES)

  String? descTema2; //TEMA 02 SABERES
  int? codigoTema2; //TEMA 03 CODIGO
  String? descSubTema1; //SUBTEMA 01 SABERES
  String? descSubTema2; //SUBTEMA 01 SABERES
  int? codigoSubTema1; //SUBTEMA 01 CODIGO
  int? codigoSubTema2; //SUBTEMA 02 CODIGO

  int? tieneLentes; //RADIO EDUCACION FINANCIERA

  //BENEFICIARIO DATOS GUARDAR EXTRA
  int? indicadorAspirante;
  int? codigoCondicion;
  String? descripcionCondicion;

  int? contactoReferencia; //LE PONENE UN DEFAULT EN BENEFICIARIO

  String? observacion; //observacion del caso

  String? codigoOperador;
  int? codigoRegistro; //TIPO REGISTRO EN TABLA VISITA
  String? dni;
  String? fechaRegistro; //FECHA GPS, ES LA FECHA QUE MARCA DONDE SE DIBUJARA EN EL SISTEMA (FECHA DEL DISPOSITIVO)

  String? fechaEncuentro; //FECHA SECUNDARIA; ESTA NO SE MARCA EN EL SISTEMA
  String? codigoModular; //ENCUENTROSABERES TIPO REUNION P W M
  String? saberEspecifico;
  String? puntoFocal; //SABERES ESPECIFICO AUTORIDAD
  int? codigoSaberesGrado; //LOGRO VENDER SI 1 NO 0
  int? nroNinos; //USUARIOS SABERES
  int? nroNinas; //USUARIAS SABERES
  int? codigoSaberesNivel; //USUARIOS PRODUCTOS
  int? seRealizoFechaProgramada; //PUNTO DE PAGO
  String? fechaTablet;
  String? fechaTabletFotoDos;
  String? fechaTabletFotoTres;
  String? fechaTabletFotoUno;
  String? fechaTabletFotoCuatro;
  String? fotoDos;
  String? fotoTres;
  String? fotoUno;
  String? fotoCuatro;
  String? freeEspacioTablet;
  String? longitud;
  String? latitud;
  String? altitud;
  String? imei;
  int? recorrido;                     // INICIO/FIN ACTIVIDADES INICIO ES 0 FIN ES 1
  String? totalEspacioTablet;
  String? versionAplicacion;
  int? versionCondicion;
  int? versionOperador;
  //campaña salud
  int? enTambo; //Sí check 1, no check 0
  String? fechaProgramado;
  int? cantidadUsuarios;
  //UBIGEO  ESTO NO ESTA EN VISTIA PRESONAL//String? nombreDepartamento; String? nombreProvincia; String? nombreDistrito;
  String? centroPoblado;
  String? ubigeo; //FUSION
  String? tipologiaSaber; //VISITA COLECTIVA PARAMETRO
  int? codigoSubTipologia;
  //PUNTO PAGO
  int? usuariosAtendidos;
  int? usuariosFallecidos;
  String? horaProgramadoInicio;
  String? horaProgramadoFin;

  String? nombreTipoCampania;
  int? codigoTipoCampania;
  //VERIFICACION REMOTA SI OTRA VEZ RECICLAN
  int? codigoUltimoControlVisual;
  int? codigoDiagnosticoVisual;
  int? tieneHipertension;
  int? codigoCuandoDiagnosticaronHipertension;
  int? codigoUltimoDespistajeHipertension;
  String? otrosVisual;

  Visitas(
      {this.altitud,
        this.enHogar,
        this.nombreDepartamento,
        this.nombreProvinci,
        this.nombreDistrito,
        this.descripcionTema,
      this.apepat,
      this.apemat,
        this.codigoViolenciaDetectada,
       this.flagVictimaUsuario,
       this.codigoVictima,
       this.codigoVinculoPersonaAgresora,
       this.codigoInstancia,
       this.flagInstanciaSi,
       this.observacionSaberes,
        this.placa,
        this.kilometraje,
        this.monto,
        this.galones,
        this.grifo,

        this.nombreViolenciaDetectada,
        this.nombreVictima,
        this.nombreVinculoPersonaAgresora,
        this.descripcionInstancia,

        this.telefonoContacto,
        this.personaContacto,

        this.horaInicio,
        this.horaFin,
        this.horaInicio2,
        this.horaFin2,

        this.fechaFallecimiento,
        this.tipoCondicion,
        this.direccion,
        this.distrito,
        this.recibeTratamientoDiabetes,
        this.otrosDiabetes,
        this.otrosHipertension,
        this.codigoMedicacionDiabetes,
        this.cumpleTratamientoHipertension,
        this.otrosArtritis,
        this.tieneArtritis,
        this.descripcionMedicacionOtraEnfermedad,
        this.recibeTratamientoOtraEnfermedad,
        this.codigoSaberesTema,

        this.descTema2,
        this.codigoTema2,
        this.descSubTema1,
        this.descSubTema2,
        this.codigoSubTema1,
        this.codigoSubTema2,

        this.tieneLentes,

        this.indicadorAspirante,
        this.codigoCondicion,
        this.descripcionCondicion,
        this.contactoReferencia,

        this.nombres,
        this.codigoOperador,
        this.codigoRegistro,
        this.codigoVisita,
        this.dni,
        this.fechaRegistro,

        this.fechaEncuentro,
        this.codigoModular,
        this.saberEspecifico,
        this.puntoFocal,
        this.codigoSaberesGrado,
        this.nroNinos,
        this.nroNinas,
        this.codigoSaberesNivel,

        //this.descripcionCondicion, ¿tipocondicion?
        //this.codigoCondicion,

        this.seRealizoFechaProgramada,

        this.fechaTablet,
        this.fechaTabletFotoDos,
        this.fechaTabletFotoTres,
        this.fechaTabletFotoUno,
        this.fechaTabletFotoCuatro,
        this.fotoDos,
        this.fotoTres,
        this.fotoUno,
        this.fotoCuatro,
        this.freeEspacioTablet,
        this.imei,
        this.latitud,
        this.longitud,
        this.observacion,
        this.recorrido,
        this.totalEspacioTablet,
        this.versionAplicacion,
        this.versionCondicion,
        this.versionOperador,

        this.enTambo,
        this.fechaProgramado,
        this.cantidadUsuarios,

        this.centroPoblado,
        this.ubigeo,

        this.tipologiaSaber,
        this.codigoSubTipologia,
        this.usuariosAtendidos,
        this.usuariosFallecidos,
        this.horaProgramadoInicio,
        this.horaProgramadoFin,
        this.nombreTipoCampania,
        this.codigoTipoCampania,

        this.codigoUltimoControlVisual,
        this.codigoDiagnosticoVisual,
        this.tieneHipertension,
        this.codigoCuandoDiagnosticaronHipertension,
        this.codigoUltimoDespistajeHipertension,
        this.otrosVisual

      });

  factory Visitas.fromJson(dynamic json) {
    return Visitas(
      altitud: json['altitud'],
      descripcionTema: json['descripcionTema'],
        enHogar: json['enHogar'],
        nombreDepartamento: json['nombreDepartamento'],
        nombreProvinci: json['nombreProvinci'],
        nombreDistrito: json['nombreDistrito'],
      apepat: json['apepat'],
      apemat: json['apemat'],
      nombres: json['nombres'],
      codigoViolenciaDetectada: json['codigoViolenciaDetectada'],

      flagVictimaUsuario: json['flagVictimaUsuario'],
      codigoVictima:  json['codigoVictima'],
      codigoVinculoPersonaAgresora: json['codigoVinculoPersonaAgresora'],
      codigoInstancia:  json['codigoInstancia'],
      flagInstanciaSi:  json['flagInstanciaSi'],
      observacionSaberes: json['observacionSaberes'],

        nombreViolenciaDetectada: json['nombreViolenciaDetectada'],
        nombreVictima: json['nombreVictima'],
        nombreVinculoPersonaAgresora: json['nombreVinculoPersonaAgresora'],
        descripcionInstancia: json['descripcionInstancia'],

      placa: json["placa"],
      kilometraje: json['kilometraje'],
      monto: json['monto'],
      galones: json['galones'],
      grifo: json['grifo'],

      telefonoContacto:json['telefonoContacto'],
      personaContacto:json['personaContacto'],

      horaInicio:json['horaInicio'],
      horaFin:json['horaFin'],
      horaInicio2:json['horaInicio2'],
      horaFin2:json['horaFin2'],

      fechaFallecimiento:json['fechaFallecimiento'],
      tipoCondicion:json['tipoCondicion'],
      direccion:json['direccion'],
      distrito:json['distrito'],
      recibeTratamientoDiabetes:json['recibeTratamientoDiabetes'],
      otrosDiabetes:json['otrosDiabetes'],
        otrosHipertension:json['otrosHipertension'],
      codigoMedicacionDiabetes:json['codigoMedicacionDiabetes'],
      cumpleTratamientoHipertension:json['cumpleTratamientoHipertension'],
      otrosArtritis:json['otrosArtritis'],
      tieneArtritis:json['tieneArtritis'],
      descripcionMedicacionOtraEnfermedad:json['descripcionMedicacionOtraEnfermedad'],
      recibeTratamientoOtraEnfermedad:json['recibeTratamientoOtraEnfermedad'],
      codigoSaberesTema:json['codigoSaberesTema'],

    descTema2:json['descTema2'],
    codigoTema2:json['codigoTema2'],
    descSubTema1:json['descSubTema1'],
    descSubTema2:json['descSubTema2'],
    codigoSubTema1:json['codigoSubTema1'],
    codigoSubTema2:json['codigoSubTema2'],

      tieneLentes:json['tieneLentes'],

      indicadorAspirante:json['indicadorAspirante'],
      codigoCondicion:json['codigoCondicion'],
      descripcionCondicion:json['descripcionCondicion'],
      contactoReferencia:json['contactoReferencia'],

      codigoOperador: json['codigoOperador'],
      codigoRegistro: json['codigoRegistro'],
      codigoVisita: json['codigoVisita'],
      dni: json['dni'],
      fechaRegistro: json['fechaRegistro'],

      fechaEncuentro: json['fechaEncuentro'],
      codigoModular:json['codigoModular'],
      saberEspecifico:json['saberEspecifico'],
      puntoFocal:json['puntoFocal'],
      codigoSaberesGrado:json['codigoSaberesGrado'],
      nroNinos:json['nroNinos'],
      nroNinas:json['nroNinas'],
      codigoSaberesNivel:json['codigoSaberesNivel'],

      seRealizoFechaProgramada: json['seRealizoFechaProgramada'],

      fechaTablet: json['fechaTablet'],
      fechaTabletFotoDos: json['fechaTabletFotoDos'],
      fechaTabletFotoTres: json['fechaTabletFotoTres'],
      fechaTabletFotoUno: json['fechaTabletFotoUno'],
      fechaTabletFotoCuatro: json['fechaTabletFotoCuatro'],
      fotoDos: json['fotoDos'],
      fotoTres: json['fotoTres'],
      fotoUno: json['fotoUno'],
      fotoCuatro: json['fotoCuatro'],
      freeEspacioTablet: json['freeEspacioTablet'],
      imei: json['imei'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      observacion: json['observacion'],
      recorrido: json['recorrido'],
      totalEspacioTablet: json['totalEspacioTablet'],
      versionAplicacion: json['versionAplicacion'],
      versionCondicion: json['versionCondicion'],
      versionOperador: json['versionOperador'],

      fechaProgramado: json['fechaProgramado'],
      cantidadUsuarios: json['cantidadUsuarios'],

      centroPoblado: json['centroPoblado'],
      ubigeo: json['ubigeo'],

      tipologiaSaber: json['tipologiaSaber'],
      codigoSubTipologia: json['codigoSubTipologia'],
      usuariosAtendidos: json['usuariosAtendidos'],
      usuariosFallecidos: json['usuariosFallecidos'],
      horaProgramadoInicio:json['horaProgramadoInicio'],
      horaProgramadoFin:json['horaProgramadoFin'],
      nombreTipoCampania:json['nombreTipoCampania'],
      codigoTipoCampania:json['codigoTipoCampania'],

      codigoUltimoControlVisual: json['codigoUltimoControlVisual'],
      codigoDiagnosticoVisual: json['codigoDiagnosticoVisual'],
      tieneHipertension: json['tieneHipertension'],
      codigoCuandoDiagnosticaronHipertension: json['codigoCuandoDiagnosticaronHipertension'],
      codigoUltimoDespistajeHipertension: json['codigoUltimoDespistajeHipertension'],
      otrosVisual:json['otrosVisual']
    );
  }

  static List<Visitas> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<Visitas> items =
        bienvenidaList.map((e) => Visitas.fromJson(e)).toList();
    return items;
  }

  Map<String, dynamic> toMap() {
    return {
      "altitud": altitud,
      "descripcionTema":descripcionTema,
      "enHogar": enHogar,
      "nombreDepartamento":nombreDepartamento,
      "nombreProvinci":nombreProvinci,
      "nombreDistrito":nombreDistrito,
      "apepat": apepat,
      "apemat": apemat,
      "nombres": nombres,
      "codigoViolenciaDetectada": codigoViolenciaDetectada,
      "flagVictimaUsuario": flagVictimaUsuario,
      "codigoVictima": codigoVictima,
      "codigoVinculoPersonaAgresora": codigoVinculoPersonaAgresora,
      "codigoInstancia":  codigoInstancia,
      "flagInstanciaSi":  flagInstanciaSi,
      "observacionSaberes": observacionSaberes,

      "placa": placa,
      "kilometraje": kilometraje,
      "monto": monto,
      "galones": galones,
      "grifo": grifo,

      "telefonoContacto": telefonoContacto,
      "personaContacto": personaContacto,

      "horaInicio":horaInicio,
      "horaFin":horaFin,
      "horaInicio2":horaInicio2,
      "horaFin2":horaFin2,

      "fechaFallecimiento":fechaFallecimiento,
      "tipoCondicion":tipoCondicion,
      "direccion":direccion,
      "distrito":distrito,
      "recibeTratamientoDiabetes":recibeTratamientoDiabetes,
      "otrosDiabetes":otrosDiabetes,
      "otrosHipertension":otrosHipertension,
      "codigoMedicacionDiabetes":codigoMedicacionDiabetes,
      "cumpleTratamientoHipertension":cumpleTratamientoHipertension,
      "otrosArtritis":otrosArtritis,
      "tieneArtritis":tieneArtritis,
      "descripcionMedicacionOtraEnfermedad":descripcionMedicacionOtraEnfermedad,
      "recibeTratamientoOtraEnfermedad":recibeTratamientoOtraEnfermedad,
      "codigoSaberesTema":codigoSaberesTema,

      "descTema2":descTema2,
      "codigoTema2":codigoTema2,
      "descSubTema1":descSubTema1,
      "descSubTema2":descSubTema2,
      "codigoSubTema1":codigoSubTema1,
      "codigoSubTema2":codigoSubTema2,

      "tieneLentes":tieneLentes,

      "indicadorAspirante":indicadorAspirante,
      "codigoCondicion":codigoCondicion,
      "descripcionCondicion":descripcionCondicion,
      "contactoReferencia":contactoReferencia,

      "codigoOperador": codigoOperador,
      "codigoRegistro": codigoRegistro,
      "codigoVisita": codigoVisita,
      "dni": dni,
      "fechaRegistro": fechaRegistro,

      "fechaEncuentro":fechaEncuentro,
      "codigoModular":codigoModular,
      "saberEspecifico":saberEspecifico,
      "puntoFocal":puntoFocal,
      "codigoSaberesGrado":codigoSaberesGrado,
      "nroNinos":nroNinos,
      "nroNinas":nroNinas,
      "codigoSaberesNivel":codigoSaberesNivel,

      //"descripcionCondicion":descripcionCondicion,
      //"codigoCondicion":codigoCondicion,

      "seRealizoFechaProgramada": seRealizoFechaProgramada,

      "fechaTablet": fechaTablet,
      "fechaTabletFotoDos": fechaTabletFotoDos,
      "fechaTabletFotoTres": fechaTabletFotoTres,
      "fechaTabletFotoUno": fechaTabletFotoUno,
      "fechaTabletFotoCuatro": fechaTabletFotoCuatro,
      "fotoDos": fotoDos,
      "fotoTres": fotoTres,
      "fotoUno": fotoUno,
      "fotoCuatro": fotoCuatro,
      "freeEspacioTablet": freeEspacioTablet,
      "imei": imei,
      "latitud": latitud,
      "longitud": longitud,
      "observacion": observacion,
      "recorrido": recorrido,
      "totalEspacioTablet": totalEspacioTablet,
      "versionAplicacion": versionAplicacion,
      "versionCondicion": versionCondicion,
      "versionOperador": versionOperador,

      "fechaProgramado": fechaProgramado,
      "cantidadUsuarios": cantidadUsuarios,

      "centroPoblado": centroPoblado,
      "ubigeo": ubigeo,

      "tipologiaSaber" : tipologiaSaber,
      "codigoSubTipologia" : codigoSubTipologia,
      "usuariosAtendidos":usuariosAtendidos,
      "usuariosFallecidos":usuariosFallecidos,
      "horaProgramadoInicio":horaProgramadoInicio,
      "horaProgramadoFin":horaProgramadoFin,
      "nombreTipoCampania":nombreTipoCampania,
      "codigoTipoCampania":codigoTipoCampania,

      "codigoUltimoControlVisual": codigoUltimoControlVisual,
      "codigoDiagnosticoVisual": codigoDiagnosticoVisual,
      "tieneHipertension": tieneHipertension,
      "codigoCuandoDiagnosticaronHipertension": codigoCuandoDiagnosticaronHipertension,
      "codigoUltimoDespistajeHipertension": codigoUltimoDespistajeHipertension,
      "otrosVisual" : otrosVisual

    };
  }
}
