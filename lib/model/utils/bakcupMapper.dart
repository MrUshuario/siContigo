

import 'package:Sicontigo_Visita_Domiciliaria/model/visitaDomiciliaria/t_respBackuppercepciones.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/visitaDomiciliaria/t_respuestaprimeravisita.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/visitaDomiciliaria/t_respuestaprimeravisita.dart';

import '../visitaDomiciliaria/t_respBackupprimeravisita.dart';
import '../visitaDomiciliaria/t_respBackupsegundavisita.dart';
import '../visitaDomiciliaria/t_respBackupterceravisita.dart';

class BackupMapper {

  BackupMapper._();
  static BackupMapper get instance => BackupMapper._();

  RespuestaPrimeraVisita backuptoResp(RespuestaBACKUPprimeravisita rpta) {
    var rptabck = RespuestaPrimeraVisita();
    rptabck.id_usuario = rpta.id_usuario;
    rptabck.nombre_usuario = rpta.nombre_usuario;
    rptabck.id_gestor = rpta.id_gestor;
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
    rptabck.id_usuario = rpta.id_usuario;
    return rptabck;
  }

  RespuestaPrimeraVisita backuptoRespdos(RespuestaBACKUPsegundavisita rpta) {
    var rptabck = RespuestaPrimeraVisita();
    rptabck.id_usuario = rpta.id_usuario;
    rptabck.nombre_usuario = rpta.nombre_usuario;
    rptabck.id_gestor = rpta.id_gestor;
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
    rptabck.id_usuario = rpta.id_usuario;
    return rptabck;
  }

  RespuestaPrimeraVisita backuptoResptres(RespuestaBACKUPterceravisita rpta) {
    var rptabck = RespuestaPrimeraVisita();
    rptabck.id_gestor = rpta.id_gestor;
    rptabck.id_usuario = rpta.id_usuario;
    rptabck.nombre_usuario = rpta.nombre_usuario;
    return rptabck;
  }

  RespuestaPrimeraVisita backuptoPercp(RespuestaBACKUPpercepcion rpta) {

    var rptabck = RespuestaPrimeraVisita();
    rptabck.id_usuario = rpta.id_usuario;
    rptabck.nombre_usuario = rpta.nombre_usuario;
    rptabck.id_gestor = rpta.id_gestor;
    rptabck.p01percepcion = rpta.p01percepcion;
    rptabck.p02percepcion = rpta.p02percepcion;
    rptabck.p03percepcion = rpta.p03percepcion;
    rptabck.p04percepcion = rpta.p04percepcion;
    rptabck.p05percepcion = rpta.p05percepcion;
    rptabck.p06percepcion = rpta.p06percepcion;
    rptabck.p07percepcion = rpta.p07percepcion;
    rptabck.p08percepcion = rpta.p08percepcion;
    rptabck.p09percepcion = rpta.p09percepcion;
    rptabck.p10percepcion = rpta.p10percepcion;
    rptabck.p11percepcion = rpta.p11percepcion;
    rptabck.p12percepcion = rpta.p12percepcion;
    rptabck.p13percepcion = rpta.p13percepcion;
    rptabck.p14percepcion = rpta.p14percepcion;
    rptabck.p15percepcion = rpta.p15percepcion;
    rptabck.p16percepcion1 = rpta.p16percepcion1;
    rptabck.p16percepcion2 = rpta.p16percepcion2;
    rptabck.p16percepcion3 = rpta.p16percepcion3;
    rptabck.p17percepcion1 = rpta.p17percepcion1;
    rptabck.p17percepcion2 = rpta.p17percepcion2;
    rptabck.p17percepcion3 = rpta.p17percepcion3;

    rptabck.p18percepcion1 = rpta.p18percepcion1;
    rptabck.p18percepcion2 = rpta.p18percepcion2;
    rptabck.p18percepcion3 = rpta.p18percepcion3;

    rptabck.p19percepcion1 = rpta.p19percepcion1;
    rptabck.p19percepcion2 = rpta.p19percepcion2;
    rptabck.p19percepcion3 = rpta.p19percepcion3;

    rptabck.p20percepcion = rpta.p20percepcion;
    rptabck.p21percepcion = rpta.p21percepcion;
    rptabck.p22percepcion = rpta.p22percepcion;
    rptabck.p23percepcion = rpta.p23percepcion;
    rptabck.p24percepcion = rpta.p24percepcion;
    rptabck.p25percepcion = rpta.p25percepcion;
    rptabck.p26percepcion = rpta.p26percepcion;
    rptabck.p27percepcion = rpta.p27percepcion;
    rptabck.p28percepcion = rpta.p28percepcion;
    rptabck.p29percepcion = rpta.p29percepcion;
    rptabck.p30percepcion = rpta.p30percepcion;
    rptabck.p31percepcion = rpta.p31percepcion;
    rptabck.p32percepcion = rpta.p32percepcion;
    rptabck.p33percepcion = rpta.p33percepcion;
    rptabck.p34percepcion = rpta.p34percepcion;
    rptabck.p35percepcion = rpta.p35percepcion;
    rptabck.p36percepcion = rpta.p36percepcion;
    rptabck.p37percepcion = rpta.p37percepcion;
    rptabck.p38percepcion = rpta.p38percepcion;
    rptabck.p39percepcion = rpta.p39percepcion;
    rptabck.p40percepcion = rpta.p40percepcion;
    rptabck.p41percepcion = rpta.p41percepcion;
    rptabck.p42percepcion = rpta.p42percepcion;
    rptabck.p43percepcion = rpta.p43percepcion;
    rptabck.p44percepcion = rpta.p44percepcion;
    rptabck.p45percepcion = rpta.p45percepcion;
    rptabck.p46percepcion = rpta.p46percepcion;
    rptabck.p47percepcion = rpta.p47percepcion;
    rptabck.p48percepcion = rpta.p48percepcion;
    rptabck.p49percepcion = rpta.p49percepcion;
    rptabck.p50percepcion = rpta.p50percepcion;
    rptabck.p51percepcion = rpta.p51percepcion;
    rptabck.p52percepcion = rpta.p52percepcion;
    rptabck.p53percepcion = rpta.p53percepcion;
    rptabck.p54percepcion = rpta.p54percepcion;
    rptabck.p55percepcion = rpta.p55percepcion;
    rptabck.p56percepcion = rpta.p56percepcion;
    rptabck.p57percepcion = rpta.p57percepcion;
    rptabck.p21percepcionEspecificar = rpta.p21percepcionEspecificar;
    rptabck.p44percepcionEspecificar = rpta.p44percepcionEspecificar;
    rptabck.p45percepcionEspecificar = rpta.p45percepcionEspecificar;
    rptabck.p46percepcionEspecificar = rpta.p46percepcionEspecificar;
    rptabck.p49percepcionEspecificar = rpta.p49percepcionEspecificar;
    rptabck.p52percepcionEspecificar = rpta.p52percepcionEspecificar;
    rptabck.p57percepcionEspecificar = rpta.p57percepcionEspecificar;
    rptabck.p33percepcionEspecificar = rpta.p33percepcionEspecificar;
    rptabck.p54percepcionEspecificar = rpta.p54percepcionEspecificar;

    rptabck.id_usuario = rpta.id_usuario;
    return rptabck;


  }

  List<RespuestaPrimeraVisita> listRespuestaToRespuestaENVIO(List<RespuestaBACKUPprimeravisita> listVisitas) {
    return listVisitas.map((e) => backuptoResp(e)).toList();
  }
}