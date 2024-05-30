

import 'package:sicontigoVisita/model/t_respBackup.dart';
import 'package:sicontigoVisita/model/t_respuesta.dart';

class BackupMapper {

  BackupMapper._();
  static BackupMapper get instance => BackupMapper._();

  Respuesta backuptoResp(RespuestaBACKUP rpta) {
    var rptabck = Respuesta();
    rptabck.p01CobroPension = rpta.p01CobroPension;
    rptabck.p02TipoMeses = rpta.p02TipoMeses;
    rptabck.p03Check = rpta.p03Check;
    rptabck.p03CheckEspecificar = rpta.p03CheckEspecificar;
    rptabck.p04Check = rpta.p04Check;
    rptabck.p05pension = rpta.p05pension;
    rptabck.p06Establecimiento = rpta.p06Establecimiento;
    rptabck.p06EstablecimientoESPECIFICAR = rpta.p06EstablecimientoESPECIFICAR;
    rptabck.p07Atendio = rpta.p07Atendio;
    rptabck.p08Check = rpta.p08Check;
    rptabck.p08CheckEspecificar = rpta.p08CheckEspecificar;
    rptabck.p09Check = rpta.p09Check;
    rptabck.p09CheckEspecificar = rpta.p09CheckEspecificar;
    rptabck.p10Frecuencia = rpta.p10Frecuencia;
    rptabck.p11Vive = rpta.p11Vive;
    rptabck.p12Familia = rpta.p12Familia;
    rptabck.p12FamiliaB = rpta.p12FamiliaB;
    rptabck.p13Ayudas = rpta.p13Ayudas;
    rptabck.p13AyudasB = rpta.p13AyudasB;
    rptabck.p14Ingreso = rpta.p14Ingreso;
    rptabck.p15Tipovivienda = rpta.p15Tipovivienda;
    rptabck.p15TipoviviendaB = rpta.p15TipoviviendaB;
    rptabck.p16Riesgo = rpta.p16Riesgo;
    rptabck.p16RiesgoB = rpta.p16RiesgoB;
    rptabck.p17Check = rpta.p17Check;
    rptabck.p17CheckEspecificar = rpta.p17CheckEspecificar;
    rptabck.p18Emprendimiento = rpta.p18Emprendimiento;
    return rptabck;
  }

  List<Respuesta> listRespuestaToRespuestaENVIO(List<RespuestaBACKUP> listVisitas) {
    return listVisitas.map((e) => backuptoResp(e)).toList();
  }
}