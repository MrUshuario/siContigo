import 'dart:async';
import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/apis/apiprovider_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/database/database.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_respuesta.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_respuestaBACKUP.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_respBackup.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_respuesta.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/constantes.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/helpersviewAlertMensajeTitutlo.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/helpersviewLetrasSubsGris.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Sicontigo_Visita_Domiciliaria/utils/resources_apis.dart';
import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/menu_login.dart';
import 'package:Sicontigo_Visita_Domiciliaria/viewmodels/UI/viewmodels/form_viewsmodel_formulario.dart';
import '../../infraestructure/dao/formdatamodeldao_padron.dart';
import '../../model/t_insertarEncuestaRSPTA.dart';
import '../../model/t_padron.dart';
import '../../utils/helpersviewAlertFaltaMSG.dart';
import '../../utils/helpersviewAlertMensajeFOTO.dart';
import '../../utils/helpersviewAlertProgressCircle.dart';
import '../../utils/helpersviewBlancoIcon.dart';
import '../../utils/helpersviewBlancoSelect.dart';
import '../../utils/helpersviewLetrasRojas.dart';
import '../../utils/helpersviewLetrasSubs.dart';
import '../../utils/helperviewCabecera.dart';
import 'menu_deOpcionesLISTADO.dart';


class MenudeOpcionesPercepcion extends StatefulWidget {

  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoRespuesta get formDataModelDao => _appDatabase.formDataModelDaoRespuesta;
  FormDataModelDaoRespuestaBACKUP get formDataModelDaoBackup => _appDatabase.formDataModelDaoRespuestaBACKUP;

  //PADRON
  FormDataModelDaoPadron get padronsql => _appDatabase.formDataModelDaoPadron;

  GlobalKey<FormState> keyForm = GlobalKey();
  //SIGUIENTE
  TextEditingController formIdUsuario = TextEditingController();
  TextEditingController formNombreUsuario = TextEditingController();

  //MODULO 1 (FASE 2)
  TextEditingController P01EspecificarPerc = TextEditingController();
  final ParamP01EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P02EspecificarPerc = TextEditingController();
  final ParamP02EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P03EspecificarPerc = TextEditingController();
  final ParamP03EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P04EspecificarPerc = TextEditingController();
  final ParamP04EspecificarPerc = List.filled(3, "", growable: false);


  TextEditingController P05OTROEspecificarPerc = TextEditingController();
  final ParamP05OTROEspecificarPerc = List.filled(3, "", growable: false);



  TextEditingController P06EspecificarPerc = TextEditingController();
  final ParamP06EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P07EspecificarPerc = TextEditingController();
  final ParamP07EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P08EspecificarPerc = TextEditingController();
  final ParamP08EspecificarPerc = List.filled(3, "", growable: false);

  //FASE2
  TextEditingController P12EspecificarPerc = TextEditingController();
  final ParamP12EspecificarPerc = List.filled(3, "", growable: false);

  //DEL ANTERIOR
  TextEditingController formP03EspecificarCtrl = TextEditingController();
  final ParamP03EspecificarCtrl = List.filled(3, "", growable: false);

  TextEditingController formP06EspecificarCtrl = TextEditingController();
  final ParamP06EspecificarCtrl = List.filled(3, "", growable: false);

  TextEditingController formP08EspecificarCtrl = TextEditingController();
  final ParamP08EspecificarCtrl = List.filled(3, "", growable: false);

  TextEditingController formP09EspecificarCtrl = TextEditingController();
  final ParamP09EspecificarCtrl = List.filled(3, "", growable: false);

  TextEditingController formP17EspecificarCtrl = TextEditingController();
  final ParamP17EspecificarCtrl = List.filled(3, "", growable: false);

  //BACKUP
  bool backup = false;



  //SIGUIENTE

  final ParamGestor = List.filled(3, "", growable: false);


  //ENVIAR LA DATA
  apiprovider_formulario apiForm = apiprovider_formulario();
  Respuesta? formData;
  RespuestaBACKUP? formDataBACKUP = RespuestaBACKUP();
  MenudeOpcionesPercepcion(this.formData, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenudeOpcionesPercepcion();
  }

}

enum P05Perc { avenida, calle, jiron, pasaje, carretera, otro }
enum P09Perc { Si, No }
enum P10Perc { Si, No }
enum P11Perc { Si, No }

enum P13Perc { hombre, mujer }
enum P14Perc { Si, No }
enum P15Perc { Si, No }

enum CobroPension { Si, No }
enum PensionRecibe { Totalmente, Parcialmente}
enum Tiempomeses {dos,tres}
enum TipoEstablecimientoSalud {sis, essalud, policiales, privado, ninguno, nosabe, otro}
enum FrecuenciaAtiende {tiempoMes06,tiempoAno,tiempoMasdeUnAno}
enum ViveUsted {otrasConHijos,otrasConHijosCuidado,otrasEnPareja,soloConHijos,soloConFamiliares}
enum SeAtendio { Si, No }
enum TieneFamilia { Si, No }
enum TieneFamiliaABCDE {opcionA,opcionB,opcionC,opcionD,opcionE}
enum TieneAyudas {Si, No}
enum TipoVivienda {Si, No}
enum SituacionRiesgo {Si, No}
enum TipoEmprendimiento {Si, No}
enum SituacionRiesgoAB {relacionCobro, relacionSocioEconomico}
enum TipoViviendaABC {inadecuadaBarreras, inadecuadaSuministros, inadecuadaAusencia }
enum TieneAyudasABCD {redInformalSUficiente,cuidadoraExterna, redInformalInsuficiente,noTieneApoyo}
enum IngresoEconomico {recibenMas2050,recibenMas1537,recibenIgual1537,reciben1025,sinIngresosFijos}

class _MenudeOpcionesPercepcion extends State<MenudeOpcionesPercepcion> {

  //HORA
  String? horaFecha;
  //ANTES TENIAN LATE
  String? PREFname;
  String? PREFapPaterno;
  String? PREFapMaterno;
  String? PREFnroDoc;
  String? PREFtypeUser;
  String? PREFtoken;

  int? Puntossumados = 0;

  String? GPSlatitude = "";
  String? GPSlongitude = "";
  String? GPSaltitude = "";

  String rpstP01 = "P01 ";
  String rpstP02 = " P02 ";
  String rpstP03 = " P03 ";
  String rpstP04 = " P04 ";
  String rpstP05 = " P05 ";
  String rpstP06 = " P06 ";
  String rpstP07 = " P07 ";
  String rpstP08 = " P08 ";
  String rpstP09 = " P09 ";
  String rpstP10 = " P10 ";
  String rpstP11 = " P11 ";
  String rpstP12 = " P12 ";
  String rpstP13 = " P13 ";
  String rpstP14 = " P14 ";
  String rpstP15 = " P15 ";
  String rpstP16 = " P16 ";
  String rpstP17 = " P17 ";
  String rpstP18 = " P18 ";
  int puntaje = 0;

  //BACKUP
  List <RespuestaBACKUP> listBackup = List.empty();

  Future<void> conseguirVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      PREFname = prefs.getString('name') ?? "ERROR";
      PREFapPaterno = prefs.getString('apPaterno') ?? "ERROR";
      PREFapMaterno = prefs.getString('apMaterno') ?? "ERROR";
      PREFnroDoc = prefs.getString('nroDoc') ?? "ERROR";
      PREFtypeUser = prefs.getString('typeUser') ?? "ERROR";
      PREFtoken = prefs.getString('token') ?? "ERROR";

      GPSlatitude = prefs.getString('latitude') ?? "";
      GPSlongitude = prefs.getString('longitude') ?? "";
      GPSaltitude = prefs.getString('altitude') ?? "";

      if(GPSlatitude == ""){
        print("NO COORDENADAS");

      } else {
        print("HAY COORDENADAS");
        isSatelliteGreen = true;
      }


    });
  }

  P05Perc? _P05Perc;
  P09Perc? _P09Perc;
  P10Perc? _P10Perc;
  P11Perc? _P11Perc;

  P13Perc? _P13Perc;
  P14Perc? _P14Perc;
  P15Perc? _P15Perc;

  CobroPension? _CobroPension;
  PensionRecibe? _PensionRecibe;
  Tiempomeses? _Tiempomeses;
  TipoEstablecimientoSalud? _TipoEstablecimientoSalud;
  FrecuenciaAtiende? _FrecuenciaAtiende;
  SeAtendio? _SeAtendio;
  ViveUsted ? _ViveUsted;
  TieneFamilia? _TieneFamilia;
  TieneFamiliaABCDE? _TieneFamiliaABCDE;
  TieneAyudas? _TieneAyudas;
  TieneAyudasABCD? _TieneAyudasABCD;
  TipoVivienda? _TipoVivienda;
  TipoViviendaABC? _TipoViviendaABC;
  IngresoEconomico? _IngresoEconomico;
  SituacionRiesgo? _SituacionRiesgo;
  SituacionRiesgoAB? _SituacionRiesgoAB;
  TipoEmprendimiento? _TipoEmprendimiento;
  //CobroPension? _CobroPension = CobroPension.Si;

  @override
  void initState() {
    conseguirVersion();
    revisarBackup();
    ConseguirHora();


    if(widget.formData != null) {

      if (widget.formData!.id_gestor != null) {
        setState(() {
          widget.formIdUsuario!.text = widget.formData!.id_usuario!.toString();
        });
      }

      if (widget.formData!.p01CobroPension != null) {
        setState(() {
          _CobroPension = widget.formData!.p01CobroPension == 0
              ? CobroPension.Si
              : CobroPension.No;
        });
      }

      if (widget.formData!.p02TipoMeses != null) {
        setState(() {
          _Tiempomeses = widget.formData!.p02TipoMeses == 0
              ? Tiempomeses.dos
              : Tiempomeses.tres;
        });
      }

      if (widget.formData!.p02TipoMeses != null) {
        setState(() {
          _Tiempomeses = widget.formData!.p02TipoMeses == 0
              ? Tiempomeses.dos
              : Tiempomeses.tres;
        });
      }

      if (widget.formData!.p03Check != null  && widget.formData!.p03Check!.isNotEmpty) {
        setState(() {
          if( widget.formData!.p03Check!.contains('A')){isCheckedP03Distancia = true;}
          if( widget.formData!.p03Check!.contains('B')){isCheckedP03Acumular = true;}
          if( widget.formData!.p03Check!.contains('C')){isCheckedP03Noacompaniado = true;}
          if( widget.formData!.p03Check!.contains('D')){isCheckedP03Ahorrando = true;}
          if( widget.formData!.p03Check!.contains('E')){isCheckedP03DificultarTrasladar = true;}
        });
      }

      if (widget.formData!.p03CheckEspecificar != null  && widget.formData!.p03CheckEspecificar!.isNotEmpty) {
        setState(() {
          widget.formP03EspecificarCtrl!.text = widget.formData!.p03CheckEspecificar!;
          isCheckedP03OtroEspecificar = true; //esto tengo que simplificarlo
        });
      }

      if (widget.formData!.p04Check != null  && widget.formData!.p04Check!.isNotEmpty) {
        setState(() {
          if( widget.formData!.p04Check!.contains('A')){isCheckedP04Alimentacion = true;}
          if( widget.formData!.p04Check!.contains('B')){isCheckedP04Salud = true;}
          if( widget.formData!.p04Check!.contains('C')){isCheckedP04Limpieza = true;}
          if( widget.formData!.p04Check!.contains('D')){isCheckedP04Rehabilitacion = true;}
          if( widget.formData!.p04Check!.contains('E')){isCheckedP04Educacion = true;}
          if( widget.formData!.p04Check!.contains('F')){isCheckedP04PagoServicio = true;}
          if( widget.formData!.p04Check!.contains('G')){isCheckedP04PagoComunicacion = true;}
          if( widget.formData!.p04Check!.contains('H')){isCheckedP04Transporte = true;}
          if( widget.formData!.p04Check!.contains('I')){isCheckedP04Vestimenta = true;}
          if( widget.formData!.p04Check!.contains('J')){isCheckedP04Recreacion = true;}
          if( widget.formData!.p04Check!.contains('K')){isCheckedP04Ahorro = true;}
          if( widget.formData!.p04Check!.contains('L')){isCheckedP04AhorroSalud = true;}
          if( widget.formData!.p04Check!.contains('M')){isCheckedP04OtroGasto = true;}
        });
      }

      if (widget.formData!.p05pension != null) {
        setState(() {
          _PensionRecibe = widget.formData!.p05pension == 0
              ? PensionRecibe.Totalmente
              : PensionRecibe.Parcialmente;
        });
      }

      if (widget.formData!.p06Establecimiento != null) {
        setState(() {
          switch (widget.formData!.p06Establecimiento) {
            case 0:
              _TipoEstablecimientoSalud = TipoEstablecimientoSalud.sis;
            case 1:
              _TipoEstablecimientoSalud = TipoEstablecimientoSalud.essalud;
            case 2:
              _TipoEstablecimientoSalud = TipoEstablecimientoSalud.policiales;
            case 3:
              _TipoEstablecimientoSalud = TipoEstablecimientoSalud.privado;
            case 4:
              _TipoEstablecimientoSalud = TipoEstablecimientoSalud.ninguno;
            case 5:
              _TipoEstablecimientoSalud = TipoEstablecimientoSalud.nosabe;
            case 6:
              _TipoEstablecimientoSalud = TipoEstablecimientoSalud.otro;
          }
        });
      }

      if (widget.formData!.p06EstablecimientoESPECIFICAR != null  && widget.formData!.p06EstablecimientoESPECIFICAR!.isNotEmpty) {
        setState(() {
          widget.formP06EspecificarCtrl!.text = widget.formData!.p06EstablecimientoESPECIFICAR!;
        });
      }

      if (widget.formData!.p07Atendio != null) {
        setState(() {
          _SeAtendio = widget.formData!.p07Atendio == 0
              ? SeAtendio.Si
              : SeAtendio.No;
        });
      }

      if (widget.formData!.p08Check != null  && widget.formData!.p08Check!.isNotEmpty) {
        setState(() {
          if( widget.formData!.p08Check!.contains('A')){isCheckedP08NoCentro = true;}
          if( widget.formData!.p08Check!.contains('B')){isCheckedP08NoNecesito = true;}
          if( widget.formData!.p08Check!.contains('C')){isCheckedP08MetodoTradicional = true;}
          if( widget.formData!.p08Check!.contains('D')){isCheckedP08NoBuenTrato = true;}
          if( widget.formData!.p08Check!.contains('E')){isCheckedP08NoDoctores = true;}
          if( widget.formData!.p08Check!.contains('F')){isCheckedP08NoMedicina = true;}
          if( widget.formData!.p08Check!.contains('G')){isCheckedP08Otros = true;}
        });
      }

      if (widget.formData!.p08CheckEspecificar != null  && widget.formData!.p08CheckEspecificar!.isNotEmpty) {
        setState(() {
          widget.formP08EspecificarCtrl!.text = widget.formData!.p08CheckEspecificar!;
        });
      }

      if (widget.formData!.p09Check != null  && widget.formData!.p09Check!.isNotEmpty) {
        setState(() {
          if( widget.formData!.p09Check!.contains('A')){isCheckedP09MedicinaGeneral = true;}
          if( widget.formData!.p09Check!.contains('B')){isCheckedP09Rehabilitacion = true;}
          if( widget.formData!.p09Check!.contains('C')){isCheckedP09Psicologia = true;}
          if( widget.formData!.p09Check!.contains('D')){isCheckedP09Odontologia = true;}
          if( widget.formData!.p09Check!.contains('E')){isCheckedP09Oftalmologia = true;}
          if( widget.formData!.p09Check!.contains('F')){isCheckedP09Ginecologia = true;}
          if( widget.formData!.p09Check!.contains('G')){isCheckedP09Otros = true;}
        });
      }

      if (widget.formData!.p09CheckEspecificar != null  && widget.formData!.p09CheckEspecificar!.isNotEmpty) {
        setState(() {
          widget.formP09EspecificarCtrl!.text = widget.formData!.p09CheckEspecificar!;
        });
      }

      if (widget.formData!.p10Frecuencia != null) {
        setState(() {
          switch (widget.formData!.p10Frecuencia) {
            case 0:
              _FrecuenciaAtiende = FrecuenciaAtiende.tiempoMes06;
            case 1:
              _FrecuenciaAtiende = FrecuenciaAtiende.tiempoAno;
            case 2:
              _FrecuenciaAtiende = FrecuenciaAtiende.tiempoMasdeUnAno;
          }
        });
      }

      if (widget.formData!.p11Vive != null) {
        setState(() {
          switch (widget.formData!.p11Vive) {
            case 0:
              _ViveUsted = ViveUsted.otrasConHijos;
            case 1:
              _ViveUsted = ViveUsted.otrasConHijosCuidado;
            case 2:
              _ViveUsted = ViveUsted.otrasEnPareja;
            case 3:
              _ViveUsted = ViveUsted.soloConHijos;
            case 4:
              _ViveUsted = ViveUsted.soloConFamiliares;
          }
        });
      }

      if (widget.formData!.p12Familia != null) {
        setState(() {
          _TieneFamilia = widget.formData!.p12Familia == 0
              ? TieneFamilia.Si
              : TieneFamilia.No;
        });
      }

      if (widget.formData!.p12FamiliaB != null) {
        setState(() {
          switch (widget.formData!.p12FamiliaB) {
            case 0:
              _TieneFamiliaABCDE = TieneFamiliaABCDE.opcionA;
            case 1:
              _TieneFamiliaABCDE = TieneFamiliaABCDE.opcionB;
            case 2:
              _TieneFamiliaABCDE = TieneFamiliaABCDE.opcionC;
            case 3:
              _TieneFamiliaABCDE = TieneFamiliaABCDE.opcionD;
            case 4:
              _TieneFamiliaABCDE = TieneFamiliaABCDE.opcionE;
          }
        });
      }

      if (widget.formData!.p13Ayudas != null) {
        setState(() {
          _TieneAyudas = widget.formData!.p13Ayudas == 0
              ? TieneAyudas.Si
              : TieneAyudas.No;
        });
      }

      if (widget.formData!.p13AyudasB != null) {
        setState(() {
          switch (widget.formData!.p13AyudasB) {
            case 0:
              _TieneAyudasABCD = TieneAyudasABCD.redInformalSUficiente;
            case 1:
              _TieneAyudasABCD = TieneAyudasABCD.cuidadoraExterna;
            case 2:
              _TieneAyudasABCD = TieneAyudasABCD.redInformalInsuficiente;
            case 3:
              _TieneAyudasABCD = TieneAyudasABCD.noTieneApoyo;
          }
        });
      }

      if (widget.formData!.p14Ingreso != null) {
        setState(() {
          switch (widget.formData!.p14Ingreso) {
            case 0:
              _IngresoEconomico = IngresoEconomico.recibenMas2050;
            case 1:
              _IngresoEconomico = IngresoEconomico.recibenMas1537;
            case 2:
              _IngresoEconomico = IngresoEconomico.recibenIgual1537;
            case 3:
              _IngresoEconomico = IngresoEconomico.reciben1025;
            case 4:
              _IngresoEconomico = IngresoEconomico.sinIngresosFijos;
          }
        });
      }

      if (widget.formData!.p15Tipovivienda != null) {
        setState(() {
          _TipoVivienda = widget.formData!.p15Tipovivienda == 0
              ? TipoVivienda.Si
              : TipoVivienda.No;
        });
      }

      if (widget.formData!.p15TipoviviendaB != null) {
        setState(() {
          switch (widget.formData!.p15Tipovivienda) {
            case 0:
              _TipoViviendaABC = TipoViviendaABC.inadecuadaBarreras;
            case 1:
              _TipoViviendaABC = TipoViviendaABC.inadecuadaSuministros;
            case 2:
              _TipoViviendaABC = TipoViviendaABC.inadecuadaAusencia;
          }
        });
      }

      if (widget.formData!.p15Tipovivienda != null) {
        setState(() {
          _TipoVivienda = widget.formData!.p15Tipovivienda == 0
              ? TipoVivienda.Si
              : TipoVivienda.No;
        });
      }

      if (widget.formData!.p15TipoviviendaB != null) {
        setState(() {
          switch (widget.formData!.p15Tipovivienda) {
            case 0:
              _TipoViviendaABC = TipoViviendaABC.inadecuadaBarreras;
            case 1:
              _TipoViviendaABC = TipoViviendaABC.inadecuadaSuministros;
            case 2:
              _TipoViviendaABC = TipoViviendaABC.inadecuadaAusencia;
          }
        });
      }

      if (widget.formData!.p16Riesgo != null) {
        setState(() {
          _SituacionRiesgo = widget.formData!.p16Riesgo == 0
              ? SituacionRiesgo.Si
              : SituacionRiesgo.No;
        });
      }

      if (widget.formData!.p16RiesgoB != null) {
        setState(() {
          switch (widget.formData!.p16RiesgoB) {
            case 0:
              _SituacionRiesgoAB = SituacionRiesgoAB.relacionCobro;
            case 1:
              _SituacionRiesgoAB = SituacionRiesgoAB.relacionSocioEconomico;
          }
        });
      }

      if (widget.formData!.p17Check != null  && widget.formData!.p17Check!.isNotEmpty) {
        setState(() {
          if( widget.formData!.p17Check!.contains('A')){isCheckedP17Cuidados = true;}
          if( widget.formData!.p17Check!.contains('B')){isCheckedP17ORehabilitacion = true;}
          if( widget.formData!.p17Check!.contains('C')){isCheckedP17Alimentacion = true;}
          if( widget.formData!.p17Check!.contains('D')){isCheckedP17Otros = true;}
        });
      }

      if (widget.formData!.p17CheckEspecificar != null  && widget.formData!.p17CheckEspecificar!.isNotEmpty) {
        setState(() {
          widget.formP17EspecificarCtrl!.text = widget.formData!.p17CheckEspecificar!;
        });
      }

      if (widget.formData!.p18Emprendimiento != null) {
        setState(() {
          _TipoEmprendimiento = widget.formData!.p18Emprendimiento == 0
              ? TipoEmprendimiento.Si
              : TipoEmprendimiento.No;
        });
      }


    }

    // TODO: implement initState
    super.initState();
  }

  bool isSatelliteGreen=false;

  bool Fase1 = true;
  bool Fase2 = false;
  bool Fase3 = false;
  bool Fase4 = false;
  bool Fase5 = false;
  bool Fase6 = false;

  //OCULTAR PREGUNTAS
  bool PregCada3meses = false;
  bool PregCada2meses = false;
  //2 meses oculto
  bool isCheckedP04Alimentacion = false;
  bool isCheckedP04Salud = false;
  bool isCheckedP04Limpieza = false;
  bool isCheckedP04Rehabilitacion = false;
  bool isCheckedP04Educacion = false;
  bool isCheckedP04PagoServicio = false;
  bool isCheckedP04PagoComunicacion = false;
  bool isCheckedP04Transporte = false;
  bool isCheckedP04Vestimenta = false;
  bool isCheckedP04Recreacion = false;
  bool isCheckedP04Ahorro = false;
  bool isCheckedP04AhorroSalud = false;
  bool isCheckedP04OtroGasto = false;
  //3 meses oculto
  bool isCheckedP03Distancia = false;
  bool isCheckedP03Acumular = false;
  bool isCheckedP03Noacompaniado = false;
  bool isCheckedP03Ahorrando = false;
  bool isCheckedP03DificultarTrasladar = false;
  bool isCheckedP03OtroEspecificar = false;
  //P08 si P07 es no
  bool isCheckedP08NoCentro = false;
  bool isCheckedP08NoNecesito= false;
  bool isCheckedP08MetodoTradicional = false;
  bool isCheckedP08NoBuenTrato= false;
  bool isCheckedP08NoDoctores = false;
  bool isCheckedP08NoMedicina = false;
  bool isCheckedP08Otros = false;
  //P09 si P07 es SI
  bool isCheckedP09MedicinaGeneral = false;
  bool isCheckedP09Rehabilitacion= false;
  bool isCheckedP09Psicologia = false;
  bool isCheckedP09Odontologia= false;
  bool isCheckedP09Oftalmologia = false;
  bool isCheckedP09Ginecologia = false;
  bool isCheckedP09Otros = false;
  //P17
  bool isCheckedP17Cuidados= false;
  bool isCheckedP17ORehabilitacion = false;
  bool isCheckedP17Alimentacion = false;
  bool isCheckedP17Otros = false;

  Future<void> revisarBackup() async {

    if (widget.formDataBACKUP != null) {
      widget.formDataBACKUP!.cod = 0;
    }


    listBackup = await widget.formDataModelDaoBackup.findAllRespuesta();
    setState(() {
      if(listBackup.isNotEmpty){
        widget.backup = true;
        //objBackup = listBackup[0];
      } else {
        widget.backup = false;
      }
    });
  }

  void ConseguirHora(){
    //CONSEGUIR HORA
    String horamin = "";
    DateTime now = DateTime.now();
    int hour = now.hour;
    int hour12 = (now.hour == 0) ? 12 : now.hour % 12;
    String amPm = (now.hour < 12) ? 'AM' : 'PM';
    int minut = now.minute;
    horamin = "${hour12}:${minut} ${amPm}";

    setState(() {
      horaFecha = horamin;
    });
  }

  Future<void> capturarCoordenadas() async{
    HelpersViewCabecera.CoordenadasGPS(context).then((value) async {
      // Luego de recopilar la ubicación y la fecha, actualiza el estado del icono
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        isSatelliteGreen = true;
        GPSlatitude = prefs.getString('latitude') ?? "";
        GPSlongitude = prefs.getString('longitude') ?? "";
        GPSaltitude = prefs.getString('altitude') ?? "";
      });
    });
  }

  Future<void> guardadoFase1() async{

    widget.formData?.id_usuario =  int.parse(widget.formIdUsuario!.text);
  }


  Future<void> guardadoFase2() async{
    //P01 - P05

    if(_CobroPension == CobroPension.Si){rpstP01 = "${rpstP01}Sí-A";}
    else {rpstP01 = "${rpstP01}No-B";}
    rpstP01 = "${rpstP01};";

    widget.formData?.p01CobroPension = _CobroPension?.index;
    widget.formDataBACKUP?.p01CobroPension = _CobroPension?.index;


    if(_Tiempomeses == Tiempomeses.dos){rpstP02 = "${rpstP02}Dos-A";}
    else {rpstP02 = "${rpstP02}Tres-B";}
    rpstP02 = "${rpstP02};";

    widget.formData?.p02TipoMeses = _Tiempomeses?.index;
    widget.formDataBACKUP?.p02TipoMeses = _Tiempomeses?.index;

    //3 meses oculto
    String p03check = ""; //POR EL ESPECIFICA
    if(isCheckedP03Distancia){rpstP03 = "${rpstP03}A,"; p03check ="${p03check}A";}
    if(isCheckedP03Acumular){rpstP03 = "${rpstP03}B,"; p03check ="${p03check}B";}
    if(isCheckedP03Noacompaniado){rpstP03 = "${rpstP03}C,"; p03check ="${p03check}C";}
    if(isCheckedP03Ahorrando){rpstP03 = "${rpstP03}D,,"; p03check ="${p03check}D";}
    if(isCheckedP03DificultarTrasladar){rpstP03 = "${rpstP03}E,"; p03check ="${p03check}E";}
    if(isCheckedP03OtroEspecificar){rpstP03 = "${rpstP03}F:${widget.formP03EspecificarCtrl!.text}"; p03check ="${p03check}F";}
    rpstP03 = "${rpstP03};";

    widget.formData?.p03Check = p03check;
    widget.formDataBACKUP?.p03Check = p03check;
    widget.formData?.p03CheckEspecificar =widget.formP03EspecificarCtrl!.text;
    widget.formDataBACKUP?.p03CheckEspecificar =widget.formP03EspecificarCtrl!.text;

    //2meses
    if(isCheckedP04Alimentacion){rpstP04 = "${rpstP04}A,";}
    if(isCheckedP04Salud){rpstP04 = "${rpstP04}B,";}
    if(isCheckedP04Limpieza){rpstP04 = "${rpstP04}C,";}
    if(isCheckedP04Rehabilitacion){rpstP04 = "${rpstP04}D,";}
    if(isCheckedP04Educacion){rpstP04 = "${rpstP04}E,";}
    if(isCheckedP04PagoServicio){rpstP04 = "${rpstP04}F,";}
    if(isCheckedP04PagoComunicacion){rpstP04 = "${rpstP04}G,";}
    if(isCheckedP04Transporte){rpstP04 = "${rpstP04}H,";}
    if(isCheckedP04Vestimenta){rpstP04 = "${rpstP04}I,";}
    if(isCheckedP04Recreacion){rpstP04 = "${rpstP04}J,";}
    if(isCheckedP04Ahorro){rpstP04 = "${rpstP04}K,";}
    if(isCheckedP04AhorroSalud){rpstP04 = "${rpstP04}L,";}
    if(isCheckedP04OtroGasto){rpstP04 = "${rpstP04}M,";}
    rpstP04 = "${rpstP04};";

    widget.formData?.p04Check = rpstP04;
    widget.formDataBACKUP?.p04Check = rpstP04;

    if(_PensionRecibe == PensionRecibe.Totalmente){rpstP05 = "${rpstP05}Totalmente-A";}
    else {rpstP05 = "${rpstP05}Parcialmente-B";}
    rpstP05 = "${rpstP05};";

    widget.formData?.p05pension = _PensionRecibe?.index;
    widget.formDataBACKUP?.p05pension = _PensionRecibe?.index;

    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase3() async{
    //P06 - P10

    //REVISEMOS
    if(_TipoEstablecimientoSalud== TipoEstablecimientoSalud.sis){rpstP06 = "${rpstP06}SIS-A";}
    if(_TipoEstablecimientoSalud== TipoEstablecimientoSalud.essalud){rpstP06 = "${rpstP06}ESSALUD-B";}
    if(_TipoEstablecimientoSalud== TipoEstablecimientoSalud.policiales){rpstP06 = "${rpstP06}Armado-C";}
    if(_TipoEstablecimientoSalud== TipoEstablecimientoSalud.privado){rpstP06 = "${rpstP06}Privado-D";}
    if(_TipoEstablecimientoSalud== TipoEstablecimientoSalud.ninguno){rpstP06 = "${rpstP06}Ninguno-E";}
    if(_TipoEstablecimientoSalud== TipoEstablecimientoSalud.nosabe){rpstP06 = "${rpstP06}NoSabe-F";}
    if(_TipoEstablecimientoSalud== TipoEstablecimientoSalud.otro){rpstP06 = "${rpstP06}G:${widget.formP06EspecificarCtrl!.text}";}
    rpstP06 = "${rpstP06};";

    widget.formData?.p06Establecimiento = _TipoEstablecimientoSalud?.index;
    widget.formDataBACKUP?.p06Establecimiento = _TipoEstablecimientoSalud?.index;
    widget.formData?.p06EstablecimientoESPECIFICAR = widget.formP06EspecificarCtrl!.text;
    widget.formDataBACKUP?.p06EstablecimientoESPECIFICAR = widget.formP06EspecificarCtrl!.text;

    //FALTA

    if(_SeAtendio == SeAtendio.Si){rpstP07 = "${rpstP07}Sí-A";}
    else {rpstP07 = "${rpstP07}No-B";}
    rpstP07 = "${rpstP07};";

    widget.formData?.p07Atendio = _SeAtendio?.index;
    widget.formDataBACKUP?.p07Atendio = _SeAtendio?.index;

    //P08 si P07 es no
    String p08check = ""; //POR EL ESPECIFICA
    if(isCheckedP08NoCentro){rpstP08 = "${rpstP08}A,"; p08check ="${p08check}A";}
    if(isCheckedP08NoNecesito){rpstP08 = "${rpstP08}B,"; p08check ="${p08check}B";}
    if(isCheckedP08MetodoTradicional){rpstP08 = "${rpstP08}C,"; p08check ="${p08check}C";}
    if(isCheckedP08NoBuenTrato){rpstP08 = "${rpstP08}D,"; p08check ="${p08check}D";}
    if(isCheckedP08NoDoctores){rpstP08 = "${rpstP08}E,"; p08check ="${p08check}E";}
    if(isCheckedP08NoMedicina){rpstP08 = "${rpstP08}F,"; p08check ="${p08check}F";}
    if(isCheckedP08Otros){rpstP08 = "${rpstP08}G:${widget.formP08EspecificarCtrl!.text}"; p08check ="${p08check}G";}
    rpstP08 = "${rpstP08};";

    widget.formData?.p08Check = p08check;
    widget.formDataBACKUP?.p08Check = p08check;
    widget.formData?.p08CheckEspecificar = widget.formP08EspecificarCtrl!.text;
    widget.formDataBACKUP?.p08CheckEspecificar = widget.formP08EspecificarCtrl!.text;

    //P09 si P07 es SI
    String p09check = ""; //POR EL ESPECIFICA
    if(isCheckedP09MedicinaGeneral){rpstP09 = "${rpstP09}A,"; p09check ="${p09check}A";}
    if(isCheckedP09Rehabilitacion){rpstP09 = "${rpstP09}B,"; p09check ="${p09check}B";}
    if(isCheckedP09Psicologia){rpstP09 = "${rpstP09}C,"; p09check ="${p09check}C";}
    if(isCheckedP09Odontologia){rpstP09 = "${rpstP09}D,"; p09check ="${p09check}D";}
    if(isCheckedP09Oftalmologia){rpstP09 = "${rpstP09}E,"; p09check ="${p09check}E";}
    if(isCheckedP09Ginecologia){rpstP09 = "${rpstP09}F,"; p09check ="${p09check}F";}
    if(isCheckedP09Otros){rpstP09 = "${rpstP09}G:${widget.formP09EspecificarCtrl!.text}"; p09check ="${p09check}G";}
    rpstP09 = "${rpstP09};";

    widget.formData?.p09Check = p09check;
    widget.formDataBACKUP?.p09Check = p09check;
    widget.formData?.p09CheckEspecificar = widget.formP09EspecificarCtrl!.text;
    widget.formDataBACKUP?.p09CheckEspecificar = widget.formP09EspecificarCtrl!.text;

    //P10
    if(_FrecuenciaAtiende== FrecuenciaAtiende.tiempoMes06){rpstP10 = "${rpstP10}A";}
    if(_FrecuenciaAtiende== FrecuenciaAtiende.tiempoAno){rpstP10 = "${rpstP10}B";}
    if(_FrecuenciaAtiende== FrecuenciaAtiende.tiempoMasdeUnAno){rpstP10 = "${rpstP10}C";}
    rpstP10 = "${rpstP10};";

    widget.formData?.p10Frecuencia = _FrecuenciaAtiende?.index;
    widget.formDataBACKUP?.p10Frecuencia = _FrecuenciaAtiende?.index;


    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase4() async{
    //P11 - P14


    //HAY PUNTAJE!
    if(_ViveUsted== ViveUsted.otrasConHijos){rpstP11 = "${rpstP11}ConOtros-A"; puntaje=puntaje+1;}
    if(_ViveUsted== ViveUsted.otrasConHijosCuidado){rpstP11 = "${rpstP11}ConOtros-B"; puntaje=puntaje+2;}
    if(_ViveUsted== ViveUsted.otrasEnPareja){rpstP11 = "${rpstP11}ConOtros-C"; puntaje=puntaje+3;}
    if(_ViveUsted== ViveUsted.soloConHijos){rpstP11 = "${rpstP11}Solo-D"; puntaje=puntaje+4;}
    if(_ViveUsted== ViveUsted.soloConFamiliares){rpstP11 = "${rpstP11}Solo-E"; puntaje=puntaje+5;}
    rpstP11 = "${rpstP11};";

    widget.formData?.p11Vive = _ViveUsted?.index;
    widget.formDataBACKUP?.p11Vive = _ViveUsted?.index;

    if(_TieneFamilia == TieneFamilia.Si){rpstP12 = "${rpstP12}Sí-A";}
    else {rpstP12 = "${rpstP12}No-B,";}

    widget.formData?.p12Familia = _TieneFamilia?.index;
    widget.formDataBACKUP?.p12Familia = _TieneFamilia?.index;

    if(_TieneFamiliaABCDE== TieneFamiliaABCDE.opcionA){rpstP12 = "${rpstP12}A";puntaje=puntaje+1;}
    if(_TieneFamiliaABCDE== TieneFamiliaABCDE.opcionB){rpstP12 = "${rpstP12}B";puntaje=puntaje+2;}
    if(_TieneFamiliaABCDE== TieneFamiliaABCDE.opcionC){rpstP12 = "${rpstP12}C";puntaje=puntaje+3;}
    if(_TieneFamiliaABCDE== TieneFamiliaABCDE.opcionD){rpstP12 = "${rpstP12}D";puntaje=puntaje+4;}
    if(_TieneFamiliaABCDE== TieneFamiliaABCDE.opcionE){rpstP12 = "${rpstP12}E";puntaje=puntaje+5;}
    rpstP12 = "${rpstP12};";

    widget.formData?.p12FamiliaB = _TieneFamiliaABCDE?.index;
    widget.formDataBACKUP?.p12FamiliaB = _TieneFamiliaABCDE?.index;

    if(_TieneAyudas == TieneAyudas.No){rpstP13 = "${rpstP13}No-A";puntaje=puntaje+1;}
    else {rpstP13 = "${rpstP13}Sí-B,";}

    widget.formData?.p13Ayudas= _TieneAyudas?.index;
    widget.formDataBACKUP?.p13Ayudas= _TieneAyudas?.index;

    if(_TieneAyudasABCD== TieneAyudasABCD.redInformalSUficiente){rpstP13 = "${rpstP13}A";puntaje=puntaje+2;}
    if(_TieneAyudasABCD== TieneAyudasABCD.cuidadoraExterna){rpstP13 = "${rpstP13}B";puntaje=puntaje+3;}
    if(_TieneAyudasABCD== TieneAyudasABCD.redInformalInsuficiente){rpstP13 = "${rpstP13}C";puntaje=puntaje+4;}
    if(_TieneAyudasABCD== TieneAyudasABCD.noTieneApoyo){rpstP13 = "${rpstP13}D";puntaje=puntaje+5;}
    rpstP13 = "${rpstP13};";

    widget.formData?.p13AyudasB= _TieneAyudasABCD?.index;
    widget.formDataBACKUP?.p13AyudasB= _TieneAyudasABCD?.index;

    if(_IngresoEconomico== IngresoEconomico.recibenMas2050){rpstP14 = "${rpstP14}Ingresos-A";puntaje=puntaje+1;}
    if(_IngresoEconomico== IngresoEconomico.recibenMas1537){rpstP14 = "${rpstP14}Ingresos-B";puntaje=puntaje+2;}
    if(_IngresoEconomico== IngresoEconomico.recibenIgual1537){rpstP14 = "${rpstP14}Ingresos-C";puntaje=puntaje+3;}
    if(_IngresoEconomico== IngresoEconomico.reciben1025){rpstP14 = "${rpstP14}Ingresos-D";puntaje=puntaje+4;}
    if(_IngresoEconomico== IngresoEconomico.sinIngresosFijos){rpstP14 = "${rpstP14}SinIngresos-E";puntaje=puntaje+5;}
    rpstP14 = "${rpstP14};";

    widget.formData?.p14Ingreso = _IngresoEconomico?.index;
    widget.formDataBACKUP?.p14Ingreso = _IngresoEconomico?.index;

    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase5() async{
    //P15 - P18

    if(_TipoVivienda == TipoVivienda.Si){rpstP15 = "${rpstP15}Adecuada-A";puntaje=puntaje+1;}
    else {rpstP15 = "${rpstP15}Inadecuada-B,";puntaje=puntaje+2;}

    widget.formData?.p15Tipovivienda = _TipoVivienda?.index;
    widget.formDataBACKUP?.p15Tipovivienda = _TipoVivienda?.index;

    if(_TipoViviendaABC== TipoViviendaABC.inadecuadaBarreras){rpstP15 = "${rpstP15}A";puntaje=puntaje+3;}
    if(_TipoViviendaABC== TipoViviendaABC.inadecuadaSuministros){rpstP15 = "${rpstP15}B";puntaje=puntaje+4;}
    if(_TipoViviendaABC== TipoViviendaABC.inadecuadaAusencia){rpstP15 = "${rpstP15}C";puntaje=puntaje+5;}
    rpstP15 = "${rpstP15};";

    widget.formData?.p15TipoviviendaB = _TipoViviendaABC?.index;
    widget.formDataBACKUP?.p15TipoviviendaB = _TipoViviendaABC?.index;

    //TERMINA EL PUNTAJE

    if(_SituacionRiesgo == SituacionRiesgo.Si){rpstP12 = "${rpstP16}No-A";}
    else {rpstP16 = "${rpstP16}Sí-B,";}

    widget.formData?.p16Riesgo = _SituacionRiesgo?.index;
    widget.formDataBACKUP?.p16Riesgo = _SituacionRiesgo?.index;

    if(_SituacionRiesgoAB== SituacionRiesgoAB.relacionCobro){rpstP16 = "${rpstP16}A";}
    if(_SituacionRiesgoAB== SituacionRiesgoAB.relacionSocioEconomico){rpstP16 = "${rpstP16}B";}
    rpstP16 = "${rpstP16};";

    widget.formData?.p16RiesgoB = _SituacionRiesgoAB?.index;
    widget.formDataBACKUP?.p16RiesgoB = _SituacionRiesgoAB?.index;

    //P17
    String p17check = ""; //POR EL ESPECIFICA
    if(isCheckedP17Cuidados){rpstP17 = "${rpstP17}A,"; p17check ="${p17check}A";}
    if(isCheckedP17ORehabilitacion){rpstP17 = "${rpstP17}B,"; p17check ="${p17check}B";}
    if(isCheckedP17Alimentacion){rpstP17 = "${rpstP17}C,"; p17check ="${p17check}C";}
    if(isCheckedP17Otros){rpstP17 = "${rpstP17}D:${widget.formP17EspecificarCtrl!.text},"; p17check ="${p17check}D";}
    rpstP17 = "${rpstP17};";

    widget.formData?.p17Check = p17check;
    widget.formDataBACKUP?.p17Check = p17check;
    widget.formData?.p17CheckEspecificar = widget.formP17EspecificarCtrl!.text;
    widget.formDataBACKUP?.p17CheckEspecificar = widget.formP17EspecificarCtrl!.text;


    if(_TipoEmprendimiento == TipoEmprendimiento.Si){rpstP18 = "${rpstP18}Sí-A";}
    else {rpstP18 = "${rpstP18}No-B";}
    rpstP18 = "${rpstP18};";

    widget.formData?.p18Emprendimiento= _TipoEmprendimiento?.index;
    widget.formDataBACKUP?.p18Emprendimiento= _TipoEmprendimiento?.index;

    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  void PedirPermiso(){

    showDialog(
        context: context,
        builder: (context){
          //AGREGAR ESTO POR SI QUIERO QUE EL DIALOG SE REFRESQUE
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [

                      HelpersViewAlertMensajeTitulo.formItemsDesign("Se recogerá sus coordenadas actuales"),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // Align row to the end
                        children: [
                          Spacer(), // Push remaining space to the left

                          InkWell(
                            onTap: () async {

                              await capturarCoordenadas();

                              Navigator.pop(context);
                            },

                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, bottom: 20),
                              child: const Text(
                                "Aceptar",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {

                              Navigator.of(context).pop();

                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, bottom: 20),
                              child: const Text(
                                "Cancelar",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),

                        ],
                      ),

                    ],
                  )
              )
          );

        }
    );

  }


  final _mostrarLoadingStreamController = StreamController<bool>.broadcast();
  final _mostrarLoadingStreamControllerPuntaje = StreamController<int>.broadcast();
  void CargaDialog() {
    bool mostrarLOADING = false;
    int puntajeLOADING = 0;
    showDialog(
      barrierDismissible: mostrarLOADING,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {

            _mostrarLoadingStreamController.stream.listen((value) {
              setState(() {
                mostrarLOADING = value;
              });
            });

            _mostrarLoadingStreamControllerPuntaje.stream.listen((value) {
              setState(() {
                puntajeLOADING = value;
              });
            });

            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    HelpersViewAlertProgressCircle(
                      mostrar: mostrarLOADING,
                      puntaje: puntajeLOADING,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          Constants.tituloPercepciones,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 65, 187),
        //leading: Icon(Icons.menu),
        actions: [
          IconButton(
            icon: Image.asset(Resources.flechaazul),
            color: Colors.white,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Row(
                      children: [
                        Image.asset(Resources.iconInfo),
                        SizedBox(width: 4), // Espacio entre el icono y el texto
                        Expanded(
                          child: Text(
                            '¿Seguro que quieres salir?',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 20, // Tamaño de fuente deseado
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      ButtonBar(
                        alignment: MainAxisAlignment.start, // Alinea los botones a la izquierda
                        children: [
                          TextButton(
                            onPressed: () {

                              Navigator.pop(context); // Cierra el diálogo
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MenudeOpcionesListado()),
                              );

                            },
                            child: const Text('Sí',
                              style: TextStyle(
                                fontSize: 18, // Tamaño de fuente deseado
                              ),),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Cierra el diálogo
                            },
                            child: const Text('No',
                              style: TextStyle(
                                fontSize: 18, // Tamaño de fuente deseado
                              ),),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),

          //GUARDAR FORMULARIO BOTON DISKETE
          IconButton(
            icon: Image.asset(Resources.guardar),
            color: Colors.white,
            onPressed: () async {
              if ( GPSlongitude != "") {
                if (!Fase6) {
                  HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Faltan llenar campos", context);
                } else {
                  CargaDialog(); //INICIALIZA DIALOGO

                  String respuestas = "";


                  respuestas = ''
                      'Respuestas:'
                      '$rpstP01$rpstP02$rpstP03$rpstP04$rpstP05$rpstP06$rpstP07'
                      '$rpstP08$rpstP09$rpstP10$rpstP11$rpstP12$rpstP13$rpstP14'
                      '$rpstP15$rpstP16$rpstP17'
                      '- Nombre:$PREFname,'
                      '- Appaterno:$PREFapPaterno,'
                      '- MatMaterno:$PREFapMaterno,'
                      '- DNI:$PREFnroDoc,'
                      '- TipoUsuario:$PREFtypeUser,'
                  ;

                  //RELLENANDO
                  widget.formData?.idformato = apisResources.api_idFormato;
                  widget.formData?.id_gestor = int.parse(PREFnroDoc!);
                  widget.formData?.fecha = formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());
                  widget.formData?.respuestas = respuestas;
                  widget.formData?.puntaje =  puntaje;
                  widget.formData?.longitud = GPSlongitude;
                  widget.formData?.latitud = GPSlatitude;
                  widget.formData?.id_usuario = int.parse(widget.formIdUsuario.text);
                  //GPSlatitude

                  //FUNCION PARA SINCRONIZAR
                  //insertarEncuestaRSPTA rpta = await widget.apiForm.post_EnviarRspt(widget.formData!, PREFtoken);

                  //await GuardarFormulario();

                    await widget.formDataModelDaoBackup.BorrarTodo();

                  await widget.formDataModelDao.insertFormDataModel(widget.formData!);
                  cleanForm();
                  _mostrarLoadingStreamController.add(true);
                  _mostrarLoadingStreamControllerPuntaje.add(puntaje);

                }
              } else {
                HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Falta activar el GPS o dar permisos de ubicación y de teléfono para el correcto funcionamiento del APP", context);
              }

            },
          ),

          IconButton(
            icon: Image.asset(
              isSatelliteGreen ? Resources.sateliteverde : Resources.sateliterojo,
              // Usa la imagen verde si isSatelliteGreen es verdadero, de lo contrario, usa la imagen roja
            ),
            color: Colors.white,
            onPressed: () {
              if(!isSatelliteGreen) {

                PedirPermiso();

              } else {
                HelpersViewCabecera.CoordenadasGPS(context).then((value) async {
                  // Luego de recopilar la ubicación y la fecha, actualiza el estado del icono
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  setState(() {
                    isSatelliteGreen = true;
                    GPSlatitude = prefs.getString('latitude') ?? "";
                    GPSlongitude = prefs.getString('longitude') ?? "";
                    GPSaltitude = prefs.getString('altitude') ?? "";
                  });
                });
              }
            },
          ),

        ],
      ),
      body: Center (
        child: SingleChildScrollView(
          controller: scrollController,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 440.0, // Set your minimum width here
              maxWidth: double.infinity, // Set your maximum width here
            ),
            child: Container(
              margin: const EdgeInsets.all(41.0),
              child: Form(
                //key: widget.keyForm,
                child: formUI(scrollController),
              ),
            ),
          ),
        ),
      ),
    );
  }




  void showDialogValidFields(String? msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: const BoxDecoration(),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    msg.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  )),
                              const Icon(
                                Icons.save,
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )));
        });
  }


  static String formatDate(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime).toString();
  }

  void cleanForm() {
    _CobroPension = null;
    _Tiempomeses = null;
    widget.formP03EspecificarCtrl!.clear();
    widget.formP08EspecificarCtrl!.clear();
    widget.formP09EspecificarCtrl!.clear();
    widget.formP17EspecificarCtrl!.clear();
    widget.formIdUsuario!.clear();
    widget.formNombreUsuario!.clear();
    widget.formP17EspecificarCtrl!.clear();
    widget.formData = Respuesta();////
    widget.formNombreUsuario!.clear();


    setState(() {
      Fase1 = true;
      Fase2 = false;
      Fase3 = false;
      Fase4 = false;
      Fase5 = false;
      Fase6 = false;
      //

      _CobroPension = null;
      _PensionRecibe = null;
      _Tiempomeses = null;
      _TipoEstablecimientoSalud = null;
      _FrecuenciaAtiende = null;
      _ViveUsted = null;
      _SeAtendio = null;
      _TieneFamilia = null;
      _TieneFamiliaABCDE = null;
      _TieneAyudas = null;
      _TipoVivienda = null;
      _SituacionRiesgo = null;
      _TipoEmprendimiento = null;
      _SituacionRiesgoAB = null;
      _TipoViviendaABC = null;
      _TieneAyudasABCD = null;
      _IngresoEconomico = null;

      _CobroPension = null;
      _Tiempomeses = null;
      //OCULTAR PREGUNTAS
      PregCada3meses = false;
      PregCada2meses = false;
      //CHECKS
      isCheckedP04Alimentacion = false;
      isCheckedP04Salud = false;
      isCheckedP04Limpieza = false;
      isCheckedP04Rehabilitacion = false;
      isCheckedP04Educacion = false;
      isCheckedP04PagoServicio = false;
      isCheckedP04PagoComunicacion = false;
      isCheckedP04Transporte = false;
      isCheckedP04Vestimenta = false;
      isCheckedP04Recreacion = false;
      isCheckedP04Ahorro = false;
      isCheckedP04AhorroSalud = false;
      isCheckedP04OtroGasto = false;
      //eses oculto
      isCheckedP03Distancia = false;
      isCheckedP03Acumular = false;
      isCheckedP03Noacompaniado = false;
      isCheckedP03Ahorrando = false;
      isCheckedP03DificultarTrasladar = false;
      isCheckedP03OtroEspecificar = false;
       //si P07 es no
      isCheckedP08NoCentro = false;
      isCheckedP08NoNecesito= false;
      isCheckedP08MetodoTradicional = false;
      isCheckedP08NoBuenTrato= false;
      isCheckedP08NoDoctores = false;
      isCheckedP08NoMedicina = false;
      isCheckedP08Otros = false;
       //si P07 es SI
      isCheckedP09MedicinaGeneral = false;
      isCheckedP09Rehabilitacion= false;
      isCheckedP09Psicologia = false;
      isCheckedP09Odontologia= false;
      isCheckedP09Oftalmologia = false;
      isCheckedP09Ginecologia = false;
      isCheckedP09Otros = false;

      isCheckedP17Cuidados= false;
      isCheckedP17ORehabilitacion = false;
      isCheckedP17Alimentacion = false;
      isCheckedP17Otros = false;

    });

  }

  void NoEncontradoDNI(context){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      HelpersViewAlertMensajeFOTO.formItemsDesign(
                          "No existe un padron con el DNI ingresado", "DNI no encontrado"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // Align row to the end
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  )));
        });
  }

  Widget formUI(ScrollController scrollController) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [

          Visibility(
            visible: Fase1,
            child:Column(
              children: <Widget>[

                HelpersViewLetrasRojas.formItemsDesign( "Inicio del cuestionario"),
                const SizedBox(height: 16.0),
                HelpersViewLetrasSubs.formItemsDesign( "Encuestador/a: ${PREFname} ${PREFapPaterno} ${PREFapMaterno}"),
                HelpersViewLetrasSubsGris.formItemsDesign( "Hora Inicio: ${horaFecha}"),
                //PONER AQUI


                                //DNI & BUSCAR
                Row(
                  children: [

                    const Text('DNI:', style: TextStyle(
                      fontSize: 12.0,
                      //color: Colors.white,
                    ),),

                    HelpersViewBlancoIcon.formItemsDesignDNI(
                        TextFormField(
                          controller: widget.formIdUsuario,
                          decoration: const InputDecoration(
                            labelText: 'DNI del Usuario',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          /*
                      validator: (value) {
                        return HelpersViewBlancoIcon.validateField(
                            value!, widget.formIdUsuario);
                      }, */
                          maxLength: 8,
                        ), context),

                    IconButton(
                      icon: Image.asset(Resources.lupa),
                      color: Colors.white,
                      onPressed: () async {
                        List<Padron> padronObj;
                        Padron padronSelect;
                        padronObj = await widget.padronsql.findAllPadronDNI(widget.formIdUsuario.text);

                        if(padronObj.isNotEmpty){
                          padronSelect = padronObj[0];
                          String? nombreObj =  '${padronSelect.nombre} ${padronSelect.apPaterno} ${padronSelect.apMaterno}';
                          setState(() {

                            widget.formNombreUsuario.text = nombreObj!;
                            widget.P01EspecificarPerc.text = padronSelect.hogarDepartamento!;
                            widget.P02EspecificarPerc.text = padronSelect.hogarProvincia!;
                            widget.P03EspecificarPerc.text = padronSelect.hogarDistrito!;
                            widget.P04EspecificarPerc.text = padronSelect.hogarNombreCcpp!;

                           // widget.P05OTROEspecificarPerc.text = padronSelect.!;

                            widget.P06EspecificarPerc.text = padronSelect.hogarDireccionDescripcion!;
                            widget.P07EspecificarPerc.text = padronSelect.telefonoUsuario!;
                            widget.P08EspecificarPerc.text = padronSelect.hogarUbigeo!;

                          });

                        } else {
                          widget.formNombreUsuario!.clear();
                          NoEncontradoDNI(context);
                        }


                      },
                    ),

                  ],
                ),


                HelpersViewBlancoIcon.formItemsDesign(
                    Icons.person,
                    TextFormField(
                      controller: widget.formNombreUsuario,
                      decoration: const InputDecoration(
                        labelText: 'Nombre del Usuario',
                      ),
                      /*
                      validator: (value) {
                        return HelpersViewBlancoIcon.validateField(
                            value!, widget.formNombreUsuario);
                      }, */
                      maxLength: 35,
                    ), context),


                HelpersViewLetrasRojas.formItemsDesign( "I) Identificación de Vivienda"),
                const SizedBox(height: 16.0),

                //PREGUNTAS INPUT
                HelpersViewLetrasSubs.formItemsDesign( "Ubicación Geografica"),

                HelpersViewLetrasSubsGris.formItemsDesign("Departamento"),
                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.P01EspecificarPerc,
                            decoration: const InputDecoration(
                              labelText: 'Departamento',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.ParamP01EspecificarPerc);
                            },
                            maxLength: 100,
                          ), context),
                    ]
                ),

                HelpersViewLetrasSubsGris.formItemsDesign("Provincia"),
                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.P02EspecificarPerc,
                            decoration: const InputDecoration(
                              labelText: 'Provincia',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.ParamP02EspecificarPerc);
                            },
                            maxLength: 100,
                          ), context),
                    ]
                ),

                HelpersViewLetrasSubsGris.formItemsDesign("Distrito"),
                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.P03EspecificarPerc,
                            decoration: const InputDecoration(
                              labelText: 'Distrito',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.ParamP03EspecificarPerc);
                            },
                            maxLength: 100,
                          ), context),
                    ]
                ),

                HelpersViewLetrasSubsGris.formItemsDesign("Centro Poblado"),
                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.P04EspecificarPerc,
                            decoration: const InputDecoration(
                              labelText: 'Centro Poblado',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.ParamP04EspecificarPerc);
                            },
                            maxLength: 100,
                          ), context),
                    ]
                ),

                const SizedBox(height: 16.0),
                HelpersViewLetrasSubs.formItemsDesign( "Dirección de vivienda"),
                HelpersViewLetrasSubsGris.formItemsDesign("Tipo de Vía Avenida"),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Avenida"),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<P05Perc>(
                        value: P05Perc.avenida,
                        groupValue: _P05Perc,
                        onChanged: (P05Perc? value) {
                          setState(() {
                            _P05Perc = value;
                          });
                        },),
                    ),
                  ],
                ),


                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Calle"),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<P05Perc>(
                        value: P05Perc.calle,
                        groupValue: _P05Perc,
                        onChanged: (P05Perc? value) {
                          setState(() {
                            _P05Perc = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Jirón"),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<P05Perc>(
                        value: P05Perc.jiron,
                        groupValue: _P05Perc,
                        onChanged: (P05Perc? value) {
                          setState(() {
                            _P05Perc = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Pasaje"),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<P05Perc>(
                        value: P05Perc.pasaje,
                        groupValue: _P05Perc,
                        onChanged: (P05Perc? value) {
                          setState(() {
                            _P05Perc = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Carretera"),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<P05Perc>(
                        value: P05Perc.carretera,
                        groupValue: _P05Perc,
                        onChanged: (P05Perc? value) {
                          setState(() {
                            _P05Perc = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro"),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<P05Perc>(
                        value: P05Perc.otro,
                        groupValue: _P05Perc,
                        onChanged: (P05Perc? value) {
                          setState(() {
                            _P05Perc = value;
                          });
                        },),
                    ),
                  ],
                ),

                HelpersViewLetrasSubsGris.formItemsDesign("Nombre de la vía"),
                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.P06EspecificarPerc,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.ParamP06EspecificarPerc);
                            },
                            maxLength: 100,
                          ), context),
                    ]
                ),

                HelpersViewLetrasSubsGris.formItemsDesign("Télefono del Informante"),
                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.P07EspecificarPerc,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.ParamP07EspecificarPerc);
                            },
                            maxLength: 100,
                          ), context),
                    ]
                ),

                HelpersViewLetrasSubsGris.formItemsDesign("Ubigeo"),
                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.P08EspecificarPerc,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.ParamP08EspecificarPerc);
                            },
                            maxLength: 100,
                          ), context),
                    ]
                ),

                const SizedBox(height: 16.0),

                //BOTON PARA PRESEGUIR

                GestureDetector(
                    onTap: ()  async {

                      scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );

                      if( widget.formIdUsuario.text != null && widget.formIdUsuario.text != "" ){
                        await guardadoFase1();
                        setState(() {
                          Fase1 = false;
                          Fase2 = true;
                        });
                      } else {
                        showDialogValidFields(Constants.faltanCampos);
                      }


                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color.fromARGB(255, 27, 65, 187),
                      ),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text("Iniciar formulario",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    )),



              ],),
          ),


          Visibility(
            visible: Fase2,
            child:Column(
              children: <Widget>[

                HelpersViewLetrasRojas.formItemsDesign( "II) Identificación del Usuario y Cuidador"),
                HelpersViewLetrasSubs.formItemsDesign( "Datos de la persona con discapacidad"),
                const SizedBox(height: 16.0),
                HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al informante del hogar y solicitar entrevistar a la persona con discapacidad, consultar si la está en condiciones de responder, caso contrario solicitar que esté presente el cuidador/a para apoyar en la entrevista."),
                HelpersViewLetrasSubs.formItemsDesign( "¿Hay alguna persona con discapacidad en este hogar?"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                Row(
                  children: [
                    const Text(
                      'Sí',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<P09Perc>(
                      value: P09Perc.Si,
                      groupValue: _P09Perc,
                      onChanged: (P09Perc? value) {
                        setState(() {
                          _P09Perc = value;
                        });
                      },
                    ),
                    const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<P09Perc>(
                      value: P09Perc.No,
                      groupValue: _P09Perc,
                      onChanged: (P09Perc? value) {
                        setState(() {
                          _P09Perc = value;
                        });
                      },),],
                ),

                const SizedBox(height: 16.0),
                HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta a la persona con discapacidad o cuidador/a.\n"
                    "●Finalizar la encuesta si la persona señala que no es usuario/a del programa."),
                HelpersViewLetrasSubs.formItemsDesign( "¿La persona con discapacidad es usuario/a del Programa CONTIGO?"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                Row(
                  children: [
                    const Text(
                      'Sí',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<P10Perc>(
                      value: P10Perc.Si,
                      groupValue: _P10Perc,
                      onChanged: (P10Perc? value) {
                        setState(() {
                          _P10Perc = value;
                        });
                      },
                    ),
                    const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<P10Perc>(
                      value: P10Perc.No,
                      groupValue: _P10Perc,
                      onChanged: (P10Perc? value) {
                        setState(() {
                          _P10Perc = value;
                        });
                      },),],
                ),

                const SizedBox(height: 16.0),
                HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                    "●	Miembro del hogar: Es la persona pariente o no que reside en la vivienda, comparten al menos las comidas principales y/o "
                    "tienen en común otras necesidades básicas, con cargo a un presupuesto común (comen de una misma olla)."),
                HelpersViewLetrasSubs.formItemsDesign( "¿El/la usuario/a del programa es miembro del hogar?"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                Row(
                  children: [
                    const Text(
                      'Sí',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<P11Perc>(
                      value: P11Perc.Si,
                      groupValue: _P11Perc,
                      onChanged: (P11Perc? value) {
                        setState(() {
                          _P11Perc = value;
                        });
                      },
                    ),
                    const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<P11Perc>(
                      value: P11Perc.No,
                      groupValue: _P11Perc,
                      onChanged: (P11Perc? value) {
                        setState(() {
                          _P11Perc = value;
                        });
                      },),],
                ),

                const SizedBox(height: 16.0),
                HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a."),
                HelpersViewLetrasSubs.formItemsDesign( "El/la usuario/a del programa ¿Qué edad tiene en años cumplidos?"),

                Row(
                  children: [
                    const Text('Años:', style: TextStyle(
                      fontSize: 12.0,
                      //color: Colors.white,
                    ),),

                    HelpersViewBlancoIcon.formItemsDesignDNI(
                        TextFormField(
                          controller: widget.P12EspecificarPerc,
                          decoration: const InputDecoration(
                            labelText: 'Edad',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          /*
                      validator: (value) {
                        return HelpersViewBlancoIcon.validateField(
                            value!, widget.formIdUsuario);
                      }, */
                          maxLength: 2,
                        ), context),

                  ],
                ),

                const SizedBox(height: 16.0),
                HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Registrar por observación. De ser el caso realizar la pregunta al usuario/a o cuidador/a. "),
                HelpersViewLetrasSubs.formItemsDesign( "Sexo del usuario/a del programa"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                Row(
                  children: [
                    const Text(
                      'Hombre',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<P13Perc>(
                      value: P13Perc.hombre,
                      groupValue: _P13Perc,
                      onChanged: (P13Perc? value) {
                        setState(() {
                          _P13Perc = value;
                        });
                      },
                    ),
                    const Text(
                      'Mujer',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<P13Perc>(
                      value: P13Perc.mujer,
                      groupValue: _P13Perc,
                      onChanged: (P13Perc? value) {
                        setState(() {
                          _P13Perc = value;
                        });
                      },),],
                ),

                const SizedBox(height: 16.0),
                HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a."),
                HelpersViewLetrasSubs.formItemsDesign( "Actualmente ¿Cuenta con DNI?"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                Row(
                  children: [
                    const Text(
                      'Sí',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<P14Perc>(
                      value: P14Perc.Si,
                      groupValue: _P14Perc,
                      onChanged: (P14Perc? value) {
                        setState(() {
                          _P14Perc = value;
                        });
                      },
                    ),
                    const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<P14Perc>(
                      value: P14Perc.No,
                      groupValue: _P14Perc,
                      onChanged: (P14Perc? value) {
                        setState(() {
                          _P14Perc = value;
                        });
                      },),],
                ),

                HelpersViewLetrasSubs.formItemsDesign( "Datos del cuidador"),

                const SizedBox(height: 16.0),
                HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a."),
                HelpersViewLetrasSubs.formItemsDesign( "¿La persona con discapacidad tiene cuidador?"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                Row(
                  children: [
                    const Text(
                      'Sí',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<P15Perc>(
                      value: P15Perc.Si,
                      groupValue: _P15Perc,
                      onChanged: (P15Perc? value) {
                        setState(() {
                          _P15Perc = value;
                        });
                      },
                    ),
                    const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<P15Perc>(
                      value: P15Perc.No,
                      groupValue: _P15Perc,
                      onChanged: (P15Perc? value) {
                        setState(() {
                          _P15Perc = value;
                        });
                      },),],
                ),


                const SizedBox(height: 16.0),

                //BOTON PARA PRESEGUIR

                GestureDetector(
                    onTap: ()  async {

                      if(
                      1==2
                      ){
                        showDialogValidFields(Constants.faltanCampos);
                      } else {
                        //await guardadoFase2();
                        setState(() {
                          Fase2 = false;
                          Fase3 = true;
                        });
                      }

                      scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );

                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color.fromARGB(255, 27, 65, 187),
                      ),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text("Continuar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    )),



              ],),
          ),


          Visibility(
            visible: Fase3,
            child:Column(
              children: <Widget>[


                const SizedBox(height: 16.0),
                GestureDetector(
                    onTap: ()  async {
                      if( 2 == 2
                      ){
                        showDialogValidFields(Constants.faltanCampos);
                      } else {
                        //await guardadoFase3();
                        setState(() {
                          Fase3 = false;
                          Fase4 = true;
                        });
                      }

                      scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );

                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color.fromARGB(255, 27, 65, 187),
                      ),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text("Continuar (bloqueado)",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    )),




                ],),
            ),


          Visibility(
            visible: Fase4,
            child:Column(
              children: <Widget>[

                HelpersViewLetrasRojas.formItemsDesign( "VALORACION SOCIO FAMILIAR - OBSERVACION DEL GESTOR"),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "¿Con quién vive usted? *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Vive con otras personas (en pareja y/o familia) y hay hijos/as u otros familiares que requiere de cuidados."),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<ViveUsted>(
                        value: ViveUsted.otrasConHijos,
                        groupValue: _ViveUsted,
                        onChanged: (ViveUsted? value) {
                          setState(() {
                            _ViveUsted = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Vive con otras personas (en pareja o familia), requiere de cuidados, haya o no hijos/as u otros familiares que lo ayuden."),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<ViveUsted>(
                        value: ViveUsted.otrasConHijosCuidado,
                        groupValue: _ViveUsted,
                        onChanged: (ViveUsted? value) {
                          setState(() {
                            _ViveUsted = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Vive con otras personas (en pareja y/o con familiares) de edad avanzada, con/sin hijos/as con dificultades, capacidad y/o"
                        " disponibilidad para prestar cuidados de larga duración."),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<ViveUsted>(
                        value: ViveUsted.otrasEnPareja,
                        groupValue: _ViveUsted,
                        onChanged: (ViveUsted? value) {
                          setState(() {
                            _ViveUsted = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Vive solo y hay hijos o familia con limitaciones en capacidad, disponibilidad o disposición para cuidarlo/a."),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<ViveUsted>(
                        value: ViveUsted.soloConHijos,
                        groupValue: _ViveUsted,
                        onChanged: (ViveUsted? value) {
                          setState(() {
                            _ViveUsted = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Vive solo, con familiares que está distante (física o afectivamente) y presenta falta de cuidados."),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<ViveUsted>(
                        value: ViveUsted.soloConFamiliares,
                        groupValue: _ViveUsted,
                        onChanged: (ViveUsted? value) {
                          setState(() {
                            _ViveUsted = value;
                          });
                        },),
                    ),
                  ],
                ),


                HelpersViewLetrasSubs.formItemsDesign( "¿Usted tiene amigos, familiares, vecinos a los que suele visitar? *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                Row(
                  children: [
                    const Text(
                      'Sí',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<TieneFamilia>(
                      value: TieneFamilia.Si,
                      groupValue: _TieneFamilia,
                      onChanged: (TieneFamilia? value) {
                        setState(() {
                          _TieneFamilia = value;
                          _TieneFamiliaABCDE = null;
                        });
                      },
                    ),
                    const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<TieneFamilia>(
                      value: TieneFamilia.No,
                      groupValue: _TieneFamilia,
                      onChanged: (TieneFamilia? value) {
                        setState(() {
                          _TieneFamilia = value;
                          _TieneFamiliaABCDE = null;

                        });
                      },),],
                ),

                Visibility(
                  visible: (_TieneFamilia ==TieneFamilia.Si),
                  child:Column(
                    children: <Widget>[

                      HelpersViewLetrasSubsGris.formItemsDesign("Marque una opción"),

                      const SizedBox(height: 16.0),

                  Row(
                    children: [
                      HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("¿Ha recibido visita de algún familiar, suele visitarlos por lo menos una vez a la semana? "
                          "o durante la semana participa en alguna actividad pública."),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Radio<TieneFamiliaABCDE>(
                          value: TieneFamiliaABCDE.opcionA,
                          groupValue: _TieneFamiliaABCDE,
                          onChanged: (TieneFamiliaABCDE? value) {
                            setState(() {
                              _TieneFamiliaABCDE = value;
                            });
                          },),
                      ),
                    ],
                  ),

                      Row(
                        children: [
                          HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Suele salir fuera de su domicilio y se mantiene activa/o con familiares, amigos, vecinos, lo ha hecho en esta semana."),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Radio<TieneFamiliaABCDE>(
                              value: TieneFamiliaABCDE.opcionB,
                              groupValue: _TieneFamiliaABCDE,
                              onChanged: (TieneFamiliaABCDE? value) {
                                setState(() {
                                  _TieneFamiliaABCDE = value;
                                });
                              },),
                          ),
                        ],
                      ),



                    ],),
                ),

                Visibility(
                  visible: (_TieneFamilia ==TieneFamilia.No),
                  child:Column(
                    children: <Widget>[

                      HelpersViewLetrasSubsGris.formItemsDesign("Marque una opción"),
                      const SizedBox(height: 16.0),

                      Row(
                        children: [
                          HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Suele salir fuera de su hogar, con o sin compañía, por lo menos una vez a la semana."),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Radio<TieneFamiliaABCDE>(
                              value: TieneFamiliaABCDE.opcionC,
                              groupValue: _TieneFamiliaABCDE,
                              onChanged: (TieneFamiliaABCDE? value) {
                                setState(() {
                                  _TieneFamiliaABCDE = value;
                                });
                              },),
                          ),
                        ],
                      ),


                      Row(
                        children: [
                          HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Recibe visita de algún familiar en su hogar? Por lo menos una vez por semana."),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Radio<TieneFamiliaABCDE>(
                              value: TieneFamiliaABCDE.opcionD,
                              groupValue: _TieneFamiliaABCDE,
                              onChanged: (TieneFamiliaABCDE? value) {
                                setState(() {
                                  _TieneFamiliaABCDE = value;
                                });
                              },),
                          ),
                        ],
                      ),


                  Row(
                        children: [
                          HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("No recibe visitas, no sale a la calle, se encuentra en aislamiento social."),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Radio<TieneFamiliaABCDE>(
                              value: TieneFamiliaABCDE.opcionE,
                              groupValue: _TieneFamiliaABCDE,
                              onChanged: (TieneFamiliaABCDE? value) {
                                setState(() {
                                  _TieneFamiliaABCDE = value;
                                });
                              },),
                          ),
                        ],
                      ),



                    ],),
                ),

                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "¿Recibe ayuda en las actividades diarias? *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                Row(
                  children: [
                    const Text(
                      'No requiere \nayuda',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<TieneAyudas>(
                      value: TieneAyudas.No,
                      groupValue: _TieneAyudas,
                      onChanged: (TieneAyudas? value) {
                        setState(() {
                          _TieneAyudas = value;
                          _TieneAyudasABCD = null;
                        });
                      },
                    ),
                    const Text(
                      'Sí requiere \nayuda',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<TieneAyudas>(
                      value: TieneAyudas.Si,
                      groupValue: _TieneAyudas,
                      onChanged: (TieneAyudas? value) {
                        setState(() {
                          _TieneAyudas= value;
                          _TieneAyudasABCD = null;

                        });
                      },),],
                ),

                ////SEGUN LO MARCADO
                Visibility(
                visible: (_TieneAyudas ==TieneAyudas.Si),
                  child:Column(
                  children: <Widget>[

                    HelpersViewLetrasSubsGris.formItemsDesign("Marque una opción"),
                    const SizedBox(height: 16.0),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Requiere ayuda y la recibe de la red informal y/o formal y es suficiente."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<TieneAyudasABCD>(
                            value: TieneAyudasABCD.redInformalSUficiente,
                            groupValue: _TieneAyudasABCD,
                            onChanged: (TieneAyudasABCD? value) {
                              setState(() {
                                _TieneAyudasABCD = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Requiere ayuda y la recibe en su mayor parte de una persona cuidadora externa (privada)."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<TieneAyudasABCD>(
                            value: TieneAyudasABCD.cuidadoraExterna,
                            groupValue: _TieneAyudasABCD,
                            onChanged: (TieneAyudasABCD? value) {
                              setState(() {
                                _TieneAyudasABCD = value;
                              });
                            },),
                        ),
                      ],
                    ),

                        Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Requiere ayuda y la recibe de la red informal y/o formal y es insuficiente."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<TieneAyudasABCD>(
                            value: TieneAyudasABCD.redInformalInsuficiente,
                            groupValue: _TieneAyudasABCD,
                            onChanged: (TieneAyudasABCD? value) {
                              setState(() {
                                _TieneAyudasABCD = value;
                              });
                            },),
                        ),
                      ],
                    ),


                     Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Requiere ayuda y no tiene apoyo de la red de recursos (formal/informal) y/o no se puede ejercer."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<TieneAyudasABCD>(
                            value: TieneAyudasABCD.noTieneApoyo,
                            groupValue: _TieneAyudasABCD,
                            onChanged: (TieneAyudasABCD? value) {
                              setState(() {
                                _TieneAyudasABCD = value;
                              });
                            },),
                        ),
                      ],
                    ),

                  ])),
                const SizedBox(height: 16.0),
                HelpersViewLetrasSubs.formItemsDesign( "¿Cual es el ingreso economico en su hogar? *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),


                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("¿Reciben  más de S/2,050 mensualmente?"),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<IngresoEconomico >(
                        value: IngresoEconomico.recibenMas2050,
                        groupValue: _IngresoEconomico ,
                        onChanged: (IngresoEconomico ? value) {
                          setState(() {
                            _IngresoEconomico  = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("¿Reciben más de S/ 1537.50 hasta S/ 2,050 mensualmente?."),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<IngresoEconomico >(
                        value: IngresoEconomico.recibenMas1537,
                        groupValue: _IngresoEconomico ,
                        onChanged: (IngresoEconomico ? value) {
                          setState(() {
                            _IngresoEconomico  = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("¿Reciben mas de S/ 1025 hasta S/ 1537.50 mensualmente?"),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<IngresoEconomico >(
                        value: IngresoEconomico.recibenIgual1537,
                        groupValue: _IngresoEconomico ,
                        onChanged: (IngresoEconomico ? value) {
                          setState(() {
                            _IngresoEconomico  = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Reciben igual o menos de S/ 1025 mensualmente."),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<IngresoEconomico >(
                        value: IngresoEconomico.reciben1025,
                        groupValue: _IngresoEconomico ,
                        onChanged: (IngresoEconomico ? value) {
                          setState(() {
                            _IngresoEconomico  = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Sin ingresos fijos."),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<IngresoEconomico >(
                        value: IngresoEconomico.sinIngresosFijos,
                        groupValue: _IngresoEconomico ,
                        onChanged: (IngresoEconomico ? value) {
                          setState(() {
                            _IngresoEconomico  = value;
                          });
                        },),
                    ),
                  ],
                ),

                const SizedBox(height: 16.0),

                //BOTON DE SUBIR
                GestureDetector(
                    onTap: ()  async {
                      if(
                      (_ViveUsted == null) || //P11
                      (_TieneFamilia == null) || //P12
                      (_TieneFamiliaABCDE == null) ||
                      (_TieneAyudas == null) ||
                      (_TieneAyudas == TieneAyudas.Si && _TieneAyudasABCD == null) ||
                      (_IngresoEconomico == null)
                      ){
                        showDialogValidFields(Constants.faltanCampos);
                      } else {
                        await guardadoFase4();
                        setState(() {
                          Fase4 = false;
                          Fase5 = true;
                        });
                      }

                      scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );

                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color.fromARGB(255, 27, 65, 187),
                      ),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text("Continuar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    )),


              ],),
          ),

          Visibility(
            visible: Fase5,
            child:Column(
              children: <Widget>[

                HelpersViewLetrasRojas.formItemsDesign( "Tipo de Vivienda"),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "¿Que tipo de vivienda tienes? *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                Row(
                  children: [
                    const Text(
                      'Adecuada',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<TipoVivienda>(
                      value: TipoVivienda.Si,
                      groupValue: _TipoVivienda,
                      onChanged: (TipoVivienda? value) {
                        setState(() {
                          _TipoVivienda = value;
                          _TipoViviendaABC = null;
                        });
                      },
                    ),
                    const Text(
                      'Inadecuada',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<TipoVivienda>(
                      value: TipoVivienda.No,
                      groupValue: _TipoVivienda,
                      onChanged: (TipoVivienda? value) {
                        setState(() {
                          _TipoVivienda= value;
                          _TipoViviendaABC = null;

                        });
                      },),],
                ),

                ////SEGUN LO MARCADO
                Visibility(
                    visible: (_TipoVivienda == TipoVivienda.No),
                    child:Column(
                        children: <Widget>[

                          HelpersViewLetrasSubsGris.formItemsDesign("Marque una opción"),
                          const SizedBox(height: 16.0),

                          Row(
                            children: [
                              HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Inadecuada: Barreras arquitectónicas internas en el domicilio."),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Radio<TipoViviendaABC>(
                                  value: TipoViviendaABC.inadecuadaBarreras,
                                  groupValue: _TipoViviendaABC,
                                  onChanged: (TipoViviendaABC? value) {
                                    setState(() {
                                      _TipoViviendaABC = value;
                                    });
                                  },),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Inadecuada: Falta uno o más suministros y/o dos o más equipamientos."),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Radio<TipoViviendaABC>(
                                  value: TipoViviendaABC.inadecuadaSuministros,
                                  groupValue: _TipoViviendaABC,
                                  onChanged: (TipoViviendaABC? value) {
                                    setState(() {
                                      _TipoViviendaABC = value;
                                    });
                                  },),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Inadecuada: Ausencia de vivienda, infravivienda."),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Radio<TipoViviendaABC>(
                                  value: TipoViviendaABC.inadecuadaAusencia,
                                  groupValue: _TipoViviendaABC,
                                  onChanged: (TipoViviendaABC? value) {
                                    setState(() {
                                      _TipoViviendaABC = value;
                                    });
                                  },),
                              ),
                            ],
                          ),
                        ])),

                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "¿El gestor social, ha identificado alguna situación de riesgo? *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                Row(
                  children: [
                    const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<SituacionRiesgo>(
                      value: SituacionRiesgo.No,
                      groupValue: _SituacionRiesgo,
                      onChanged: (SituacionRiesgo? value) {
                        setState(() {
                          _SituacionRiesgo = value;
                          _SituacionRiesgoAB = null;
                        });
                      },
                    ),
                    const Text(
                      'Sí',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<SituacionRiesgo>(
                      value: SituacionRiesgo.Si,
                      groupValue: _SituacionRiesgo,
                      onChanged: (SituacionRiesgo? value) {
                        setState(() {
                          _SituacionRiesgo= value;
                          _SituacionRiesgoAB = null;

                        });
                      },),],
                ),

                ////SEGUN LO MARCADO
                Visibility(
                    visible: (_SituacionRiesgo== SituacionRiesgo.Si),
                    child:Column(
                        children: <Widget>[

                          HelpersViewLetrasSubsGris.formItemsDesign("Marque una opción"),
                          const SizedBox(height: 16.0),

                          Row(
                            children: [
                              HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("En relación al cobro."),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Radio<SituacionRiesgoAB>(
                                  value: SituacionRiesgoAB.relacionCobro,
                                  groupValue: _SituacionRiesgoAB,
                                  onChanged: (SituacionRiesgoAB? value) {
                                    setState(() {
                                      _SituacionRiesgoAB = value;
                                    });
                                  },),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("En relación a riesgo socioemocional."),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Radio<SituacionRiesgoAB>(
                                  value: SituacionRiesgoAB.relacionSocioEconomico,
                                  groupValue: _SituacionRiesgoAB,
                                  onChanged: (SituacionRiesgoAB? value) {
                                    setState(() {
                                      _SituacionRiesgoAB = value;
                                    });
                                  },),
                              ),
                            ],
                          ),

                        ])),

                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "¿De qué temas le interesaría, informase en las siguientes visitas? *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.checkAviso),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Cuidados de la PCDS."),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Checkbox(
                        value: isCheckedP17Cuidados,
                        onChanged: (bool? value) {
                          setState(() {
                            isCheckedP17Cuidados=  value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Rehabilitación."),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Checkbox(
                        value: isCheckedP17ORehabilitacion,
                        onChanged: (bool? value) {
                          setState(() {
                            isCheckedP17ORehabilitacion=  value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Alimentación."),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Checkbox(
                        value: isCheckedP17Alimentacion ,
                        onChanged: (bool? value) {
                          setState(() {
                            isCheckedP17Alimentacion =  value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro (Especificar)"),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Checkbox(
                        value: isCheckedP17Otros ,
                        onChanged: (bool? value) {
                          setState(() {
                            isCheckedP17Otros =  value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                Visibility(
                    visible: isCheckedP17Otros,
                    child:Column(
                        children: <Widget>[
                          HelpersViewBlancoIcon.formItemsDesign(
                              Icons.pending_actions,
                              TextFormField(
                                controller: widget.formP17EspecificarCtrl,
                                decoration: const InputDecoration(
                                  labelText: 'Especifique',
                                ),
                                validator: (value) {
                                  return HelpersViewBlancoIcon.validateField(
                                      value!, widget.ParamP17EspecificarCtrl);
                                },
                                maxLength: 100,
                              ), context),
                        ]
                    )),

                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "A la fecha, la persona usuaria, desarrolla algún tipo de emprendimiento *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                Row(
                  children: [
                    const Text(
                      'Si',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<TipoEmprendimiento>(
                      value: TipoEmprendimiento.Si,
                      groupValue: _TipoEmprendimiento,
                      onChanged: (TipoEmprendimiento? value) {
                        setState(() {
                          _TipoEmprendimiento = value;
                        });
                      },
                    ),
                    const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<TipoEmprendimiento>(
                      value: TipoEmprendimiento.No,
                      groupValue: _TipoEmprendimiento,
                      onChanged: (TipoEmprendimiento? value) {
                        setState(() {
                          _TipoEmprendimiento= value;
                        });
                      },),],
                ),

                GestureDetector(
                    onTap: ()  async {
                      if(
                      (_ViveUsted == null) ||
                      (_TipoVivienda == null) ||
                      ( _TipoVivienda == TipoVivienda.No && _TipoViviendaABC == null) ||
                      (_SituacionRiesgo == null) ||
                      (_SituacionRiesgo == SituacionRiesgo.Si && _SituacionRiesgoAB == null) ||
                      (_TipoEmprendimiento == null) ||
                      ( //
                      !isCheckedP17Cuidados &&
                      !isCheckedP17ORehabilitacion &&
                      !isCheckedP17Alimentacion &&
                      (widget.formP17EspecificarCtrl == null || widget.formP17EspecificarCtrl!.text.isEmpty)
                      )
                      ){
                        showDialogValidFields(Constants.faltanCampos);
                      } else {
                        await guardadoFase5();
                        setState(()  {
                          Fase5 = false;
                          Fase6 = true;
                        });
                      }

                      scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );

                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color.fromARGB(255, 27, 65, 187),
                      ),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text("Finalizar el formulario",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    )),


              ],),
          ),


          Visibility(
            visible: Fase6,
            child:Column(
              children: <Widget>[

                HelpersViewLetrasSubs.formItemsDesign( "Para mejorar la precisión de la coordenada presioné icono del satélite, luego guarde su cuestionario presionando el icono diskette."),

              ],),
          ),

        ],),
    );
  }
}
