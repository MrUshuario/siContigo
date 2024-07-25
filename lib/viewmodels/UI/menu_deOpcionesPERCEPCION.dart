import 'dart:async';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_respuestaBACKUPpercepcion.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/visitaDomiciliaria/t_respBackuppercepciones.dart';
import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/apis/apiprovider_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/database/database.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_respuestaunovisita.dart';
import 'package:Sicontigo_Visita_Domiciliaria/infraestructure/dao/formdatamodeldao_respuestaBACKUPunovisita.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/t_formulario.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/visitaDomiciliaria/t_respuestaprimeravisita.dart';
import 'package:Sicontigo_Visita_Domiciliaria/model/visitaDomiciliaria/t_respuestaprimeravisita.dart';
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
import 'package:super_tooltip/super_tooltip.dart';
import '../../infraestructure/dao/formdatamodeldao_padron.dart';
import '../../model/t_insertarEncuestaRSPTA.dart';
import '../../model/t_padron.dart';
import '../../model/utils/camera.dart';
import '../../model/utils/viewdisplayfoto.dart';
import '../../model/visitaDomiciliaria/t_respBackupprimeravisita.dart';
import '../../utils/helpersviewAlertFaltaMSG.dart';
import '../../utils/helpersviewAlertMensajeFOTO.dart';
import '../../utils/helpersviewAlertProgressCircle.dart';
import '../../utils/helpersviewBlancoIcon.dart';
import '../../utils/helpersviewBlancoSelect.dart';
import '../../utils/helpersviewLetrasRojas.dart';
import '../../utils/helpersviewLetrasSubs.dart';
import '../../utils/helpersviewLetrasToolTip.dart';
import '../../utils/helperviewCabecera.dart';
import 'menu_deOpcionesLISTADO.dart';


class MenudeOpcionesPercepcion extends StatefulWidget {
  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoRespuestaunovisita get formDataModelDao => _appDatabase.formDataModelDaoRespuesta;
  FormDataModelDaoRespuestaBACKUpercepcion get formDataModelDaoBackup => _appDatabase.formDataModelDaoRespuestaBACKUpercepcion;

  //PADRON
  FormDataModelDaoPadron get padronsql => _appDatabase.formDataModelDaoPadron;

  List<String> listMediaPath = List.empty(growable: true);

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
  TextEditingController P06EspecificarPerc = TextEditingController();
  final ParamP06EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P07EspecificarPerc = TextEditingController();
  final ParamP07EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P08EspecificarPerc = TextEditingController();
  final ParamP08EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P11EspecificarPerc = TextEditingController();
  final ParamP11EspecificarPerc = List.filled(3, "", growable: false);

  TextEditingController P19EspecificarPerc1 = TextEditingController();
  final ParamP19EspecificarPerc1 = List.filled(3, "", growable: false);
  TextEditingController P19EspecificarPerc2 = TextEditingController();
  final ParamP19EspecificarPerc2 = List.filled(3, "", growable: false);
  TextEditingController P19EspecificarPerc3 = TextEditingController();
  final ParamP19EspecificarPerc3 = List.filled(3, "", growable: false);

  TextEditingController P50EspecificarPerc = TextEditingController();
  final ParamP50EspecificarPerc = List.filled(3, "", growable: false);
  //ESPECIFICAR OTROS
  TextEditingController P16EspecificarPerc1 = TextEditingController();
  final ParamP16EspecificarPerc1 = List.filled(3, "", growable: false);
  TextEditingController P16EspecificarPerc2 = TextEditingController();
  final ParamP16EspecificarPerc2 = List.filled(3, "", growable: false);
  TextEditingController P16EspecificarPerc3 = TextEditingController();
  final ParamP16EspecificarPerc3 = List.filled(3, "", growable: false);

  TextEditingController P21EspecificarPerc = TextEditingController();
  final ParamP22EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P23EspecificarPerc = TextEditingController();
  final ParamP23EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P44EspecificarPerc = TextEditingController();
  final ParamP44EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P45EspecificarPerc = TextEditingController();
  final ParamP45EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P46EspecificarPerc = TextEditingController();
  final ParamP46EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P49EspecificarPerc = TextEditingController();
  final ParamP49EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P52EspecificarPerc = TextEditingController();
  final ParamP52EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P57EspecificarPerc = TextEditingController();
  final ParamP57EspecificarPerc = List.filled(3, "", growable: false);

  TextEditingController P42EspecificarPerc = TextEditingController();
  final ParamP42EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P54EspecificarPerc = TextEditingController();
  final ParamP54EspecificarPerc = List.filled(3, "", growable: false);

  //BACKUP
  bool backup = false;



  //SIGUIENTE

  final ParamGestor = List.filled(3, "", growable: false);


  //ENVIAR LA DATA
  apiprovider_formulario apiForm = apiprovider_formulario();
  RespuestaPrimeraVisita? formData;
  RespuestaBACKUPpercepcion? formDataBACKUP = RespuestaBACKUPpercepcion();
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
enum P12Perc { hombre, mujer }
enum P13Perc { Si, No }
enum P14Perc { Si, No }
enum P15Perc { Si, No }

enum P16Perc1 { esposa, conviviente, hijo, hijastro, yerno, nieto, padres, suegro, hermano, trabajador, otropariente, otronopariente }
enum P16Perc2 { esposa, conviviente, hijo, hijastro, yerno, nieto, padres, suegro, hermano, trabajador, otropariente, otronopariente }
enum P16Perc3 { esposa, conviviente, hijo, hijastro, yerno, nieto, padres, suegro, hermano, trabajador, otropariente, otronopariente }
//ESPECIFICAR

enum P17Perc1 { Si, No }
enum P17Perc2 { Si, No }
enum P17Perc3 { Si, No }
enum P18Perc1 { hombre, mujer }
enum P18Perc2 { hombre, mujer }
enum P18Perc3 { hombre, mujer }


enum P20Perc { Si, No }
enum P21Perc { omadep, familaires, medios, personal, yo, otro }
enum P22Perc {muybuena, buena, mala, muymala, nosabe}
enum P23Perc {bastante, suficiente, poco, nada, nosabe}
enum P24Perc { sigueigual, hamejorado, haempeorado, nosabe }

enum P25Perc {muybuena, buena, mala, muymala, nosabe}
enum P26Perc {Si, No}
enum P27Perc {Si, No}




//30,31,32,33
enum P31Perc14 {cuidador, familiar}
enum P31Perc13 {cuidador, familiar}
enum P31Perc12 {cuidador, familiar}
enum P31Perc11 {cuidador, familiar}
enum P31Perc10 {cuidador, familiar}
enum P31Perc09 {cuidador, familiar}
enum P31Perc08 {cuidador, familiar}
enum P31Perc07 {cuidador, familiar}
enum P31Perc06 {cuidador, familiar}
enum P31Perc05 {cuidador, familiar}
enum P31Perc04 {cuidador, familiar}
enum P31Perc03 {cuidador, familiar}
enum P31Perc02 {cuidador, familiar}
enum P31Perc01 {cuidador, familiar}



enum P34Perc {muysatisfecho, satisfecho, insatisfecho, muyinsatisfecho, nosabe}

enum P35Perc {nunca, algunavez, frecuente, siempre}
enum P36Perc {nunca, algunavez, frecuente, siempre}
enum P37Perc {nunca, algunavez, frecuente, siempre}
enum P38Perc {nunca, algunavez, frecuente, siempre}
enum P39Perc {nunca, algunavez, frecuente, siempre}
enum P40Perc {muysatisfecho, satisfecho, insatisfecho, muyinsatisfecho, nosabe}
enum P41Perc {sigueigual, hamejorado, haempeorado, nosabe}

enum P43Perc {Si, No}
enum P44Perc { omadep, familaires, medios, personal, banco, yo, otro}
enum P45Perc {dosmeses, masdosmeses, seismeses, nosabe, otro}
enum P46Perc {nosabiausuario, nosabiafecha, enfermo, guarde, movilidad, nosabe, otro}
enum P47Perc {independiente, cuidador, familiar, municipalidad, cobro}
enum P48Perc {mediahora, masmediahora, unoadoshoras, masdoshoras}
enum P49Perc {apie, bicicletas, caballo, mototaxi, motocicleta, automovil, taxi, colectivo, camion, otro}
//enum P50Perc MONTO EN SOLES
enum P51Perc {banco, debito, agente, pagador, pias}

//enum P52Perc {ninguno,sidistancia,sigasto,silascolas,sipersonalbanco,sipersonalprograma,sifecha,sidinero,sicobrar,siagente,sibanco,otro}

enum P53Perc {Si, No}
//enum P54Perc {} //MULTIPLES OPCIONES
enum P55Perc {Si, No}
enum P56Perc {cuidador, autorizada}
enum P57Perc {salud, ayuda, alimentacion, vestimenta, transporte, invierte, mejora, ahorra, pago, nosabe, otro}


class _MenudeOpcionesPercepcion extends State<MenudeOpcionesPercepcion> {

  //HORA
  String? horaFecha;
  String? horaFechaInicio;
  String? horaFechafinal;
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

  String PercP01 = "P01 ";
  String PercP02 = " P02 ";
  String PercP03 = " P03 ";
  String PercP04 = " P04 ";
  String PercP05 = " P05 ";
  String PercP06 = " P06 ";
  String PercP07 = " P07 ";
  String PercP08 = " P08 ";
  String PercP09 = " P09 ";
  String PercP10 = " P10 ";
  String PercP11 = " P11 ";
  String PercP12 = " P12 ";
  String PercP13 = " P13 ";
  String PercP14 = " P14 ";
  String PercP15 = " P15 ";
  String PercP16 = " P16 ";
  String PercP17 = " P17 ";
  String PercP18 = " P18 ";
  String PercP19 = " P19 ";
  String PercP20 = " P20 ";
  String PercP21 = " P21 ";
  String PercP22 = " P22 ";
  String PercP23 = " P23 ";
  String PercP24 = " P24 ";
  String PercP25 = " P25 ";
  String PercP26 = " P26 ";
  String PercP27 = " P27 ";
  String PercP28 = " P28 ";
  String PercP29 = " P29 ";
  String PercP30 = " P30 ";
  String PercP31 = " P31 ";
  String PercP32 = " P32 ";
  String PercP33 = " P33 ";
  String PercP34 = " P34 ";
  String PercP35 = " P35 ";
  String PercP36 = " P36 ";
  String PercP37 = " P37 ";
  String PercP38 = " P38 ";
  String PercP39 = " P39 ";
  String PercP40 = " P40 ";
  String PercP41 = " P41 ";
  String PercP42 = " P42 ";
  String PercP43 = " P43 ";
  String PercP44 = " P44 ";
  String PercP45 = " P45 ";
  String PercP46 = " P46 ";
  String PercP47 = " P47 ";
  String PercP48 = " P48 ";
  String PercP49 = " P49 ";
  String PercP50 = " P50 ";
  String PercP51 = " P51 ";
  String PercP52 = " P52 ";
  String PercP53 = " P53 ";
  String PercP54 = " P54 ";
  String PercP55 = " P55 ";
  String PercP56 = " P56 ";
  String PercP57 = " P57 ";


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
  List <RespuestaBACKUPpercepcion> listBackup = List.empty();

  Future<void> conseguirVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      PREFname = prefs.getString('name') ?? "ERROR";
      PREFapPaterno = prefs.getString('apPaterno') ?? "ERROR";
      PREFapMaterno = prefs.getString('apMaterno') ?? "ERROR";
      PREFnroDoc = prefs.getString('nroDoc') ?? "999999";
      PREFtypeUser = prefs.getString('typeUser') ?? "ERROR";
      PREFtoken = prefs.getString('token') ?? "ERROR";

      GPSlatitude = prefs.getString('latitude') ?? "";
      GPSlongitude = prefs.getString('longitude') ?? "";
      GPSaltitude = prefs.getString('altitude') ?? "";

      if (GPSlatitude == "") {
        print("NO COORDENADAS");
      } else {
        print("HAY COORDENADAS");
        isSatelliteGreen = true;
      }
    });
  }

  bool p09 = true;

  P05Perc? _P05Perc;
  P09Perc? _P09Perc;
  P10Perc? _P10Perc;
  P11Perc? _P11Perc;
  P12Perc? _P12Perc;
  P13Perc? _P13Perc;
  P14Perc? _P14Perc;
  P15Perc? _P15Perc;

  P16Perc1? _P16Perc1;
  P16Perc2? _P16Perc2;
  P16Perc3? _P16Perc3;

  P17Perc1? _P17Perc1;
  P17Perc2? _P17Perc2;
  P17Perc3? _P17Perc3;
  P18Perc1? _P18Perc1;
  P18Perc2? _P18Perc2;
  P18Perc3? _P18Perc3;
  P20Perc? _P20Perc;
  P21Perc? _P21Perc;
  P22Perc? _P22Perc;
  P23Perc? _P23Perc;
  P24Perc? _P24Perc;

  P25Perc? _P25Perc;
  P26Perc? _P26Perc;
  P27Perc? _P27Perc;


  P31Perc14? _P31Perc14;
  P31Perc13? _P31Perc13;
  P31Perc12? _P31Perc12;
  P31Perc11? _P31Perc11;
  P31Perc10? _P31Perc10;
  P31Perc09? _P31Perc09;
  P31Perc08? _P31Perc08;
  P31Perc07? _P31Perc07;
  P31Perc06? _P31Perc06;
  P31Perc05? _P31Perc05;
  P31Perc04? _P31Perc04;
  P31Perc03? _P31Perc03;
  P31Perc02? _P31Perc02;
  P31Perc01? _P31Perc01;


  bool P16Perc01Opcion01 = false;
  bool P16Perc02Opcion01 = false;
  bool P16Perc03Opcion01 = false;
  bool P33Perc01Opcion02 = false;
  bool P33Perc02Opcion02 = false;
  bool P33Perc03Opcion02 = false;
  bool P33Perc01Opcion03 = false;
  bool P33Perc02Opcion03 = false;
  bool P33Perc03Opcion03 = false;


  P34Perc? _P34Perc;

  P35Perc? _P35Perc;
  P36Perc? _P36Perc;
  P37Perc? _P37Perc;
  P38Perc? _P38Perc;
  P39Perc? _P39Perc;
  P40Perc? _P40Perc;
  P41Perc? _P41Perc;

  P43Perc? _P43Perc;
  P44Perc? _P44Perc;
  P45Perc? _P45Perc;
  P46Perc? _P46Perc;
  P47Perc? _P47Perc;

  P48Perc? _P48Perc;
  P49Perc? _P49Perc;

  P51Perc? _P51Perc;

  bool P42Perc01Salud = false;
  bool P42Perc02Salud = false;
  bool P42Perc03Salud = false;
  bool P42Perc01SaludF = false;
  bool P42Perc02SaludF = false;
  bool P42Perc03SaludF = false;
  bool P42Perc01Dinero = false;
  bool P42Perc02Dinero = false;
  bool P42Perc03Dinero = false;
  bool P42Perc01ProblemasF = false;
  bool P42Perc02ProblemasF = false;
  bool P42Perc03ProblemasF = false;
  bool P42Perc01Falta = false;
  bool P42Perc02Falta = false;
  bool P42Perc03Falta = false;
  bool P42Perc01ProblemasV = false;
  bool P42Perc02ProblemasV = false;
  bool P42Perc03ProblemasV = false;
  bool P42Perc01Estudio= false;
  bool P42Perc02Estudio= false;
  bool P42Perc03Estudio= false;
  bool P42Perc01Otro= false;
  bool P42Perc02Otro= false;
  bool P42Perc03Otro= false;
  bool P42Perc03SinPreocupaciones= false;

  //P52Perc? _P52Perc; ES CHECK
  bool P52Perc01 = false;
  bool P52Perc02 = false;
  bool P52Perc03 = false;
  bool P52Perc04 = false;
  bool P52Perc05 = false;
  bool P52Perc06 = false;
  bool P52Perc07 = false;
  bool P52Perc08 = false;
  bool P52Perc09 = false;
  bool P52Perc10 = false;
  bool P52Perc11 = false;
  bool P52Perc12 = false;


  P53Perc? _P53Perc;

  bool P54Perc01Distancia = false;
  bool P54Perc02Distancia = false;
  bool P54Perc03Distancia = false;
  bool P54Perc01Fisico = false;
  bool P54Perc02Fisico = false;
  bool P54Perc03Fisico = false;
  bool P54Perc01Ausencia= false;
  bool P54Perc02Ausencia= false;
  bool P54Perc03Ausencia= false;
  bool P54Perc01Requiere = false;
  bool P54Perc02Requiere = false;
  bool P54Perc03Requiere = false;
  bool P54Perc01Clima = false;
  bool P54Perc02Clima = false;
  bool P54Perc03Clima = false;
  bool P54Perc01Terreno = false;
  bool P54Perc02Terreno = false;
  bool P54Perc03Terreno = false;
  bool P54Perc01Otro = false;
  bool P54Perc02Otro = false;
  bool P54Perc03Otro = false;

  P55Perc? _P55Perc;
  P56Perc? _P56Perc;
  P57Perc? _P57Perc;


  @override
  void initState() {
    conseguirVersion();
    revisarBackup();
    ConseguirHora();

    widget.formData?.tipoencuesta = Resources.valor_percepciones;
    if (widget.formData != null) {

      if (widget.formData!.id_usuario != null) {
        setState(() {
          widget.formIdUsuario!.text = widget.formData!.id_usuario!.toString();
        });
      }

      if (widget.formData!.nombre_usuario != null) {
        setState(() {
          widget.formNombreUsuario!.text = widget.formData!.nombre_usuario!;
        });
      }

      if (widget.formData!.p01percepcion != null  && widget.formData!.p01percepcion!.isNotEmpty) {
        setState(() {
          widget.P01EspecificarPerc!.text = widget.formData!.p01percepcion!;
        });
      }

      if (widget.formData!.p02percepcion != null  && widget.formData!.p02percepcion!.isNotEmpty) {
        setState(() {
          widget.P02EspecificarPerc!.text = widget.formData!.p02percepcion!;
        });
      }

      if (widget.formData!.p03percepcion != null  && widget.formData!.p03percepcion!.isNotEmpty) {
        setState(() {
          widget.P03EspecificarPerc!.text = widget.formData!.p03percepcion!;
        });
      }

      if (widget.formData!.p04percepcion != null  && widget.formData!.p04percepcion!.isNotEmpty) {
        setState(() {
          widget.P04EspecificarPerc!.text = widget.formData!.p04percepcion!;
        });
      }

      if (widget.formData!.p05percepcion != null) {
        setState(() {
          switch (widget.formData!.p05percepcion) {
            case 0:
              _P05Perc = P05Perc.avenida;
            case 1:
              _P05Perc = P05Perc.calle;
            case 2:
              _P05Perc = P05Perc.jiron;
            case 3:
              _P05Perc = P05Perc.pasaje;
            case 4:
              _P05Perc = P05Perc.carretera;
            case 6:
              _P05Perc = P05Perc.otro;
          }
        });
      }

      if (widget.formData!.p06percepcion != null  && widget.formData!.p06percepcion!.isNotEmpty) {
        setState(() {
          widget.P06EspecificarPerc!.text = widget.formData!.p06percepcion!;
        });
      }

      if (widget.formData!.p07percepcion != null  && widget.formData!.p07percepcion!.isNotEmpty) {
        setState(() {
          widget.P07EspecificarPerc!.text = widget.formData!.p07percepcion!;
        });
      }

      if (widget.formData!.p08percepcion != null  && widget.formData!.p08percepcion!.isNotEmpty) {
        setState(() {
          widget.P08EspecificarPerc!.text = widget.formData!.p08percepcion!;
        });
      }

      if (widget.formData!.p09percepcion != null) {
        setState(() {
          switch (widget.formData!.p09percepcion) {
            case 0:
              _P09Perc = P09Perc.Si;
            case 1:
              _P09Perc = P09Perc.No;
          }
        });
      }

      if (widget.formData!.p10percepcion != null) {
        setState(() {
          switch (widget.formData!.p10percepcion) {
            case 0:
              _P10Perc = P10Perc.Si;
            case 1:
              _P10Perc = P10Perc.No;
          }
        });
      }

      if (widget.formData!.p11percepcion != null) {
        setState(() {
          widget.P11EspecificarPerc!.text = widget.formData!.p11percepcion!;
        });
      }


      if (widget.formData!.p12percepcion != null) {
        setState(() {
          switch (widget.formData!.p12percepcion) {
            case 0:
              _P12Perc = P12Perc.hombre;
            case 1:
              _P12Perc = P12Perc.mujer;
          }
        });
      }


      if (widget.formData!.p13percepcion != null) {
        setState(() {
          switch (widget.formData!.p13percepcion) {
            case 0:
              _P13Perc = P13Perc.Si;
            case 1:
              _P13Perc = P13Perc.No;
          }
        });
      }


      if (widget.formData!.p14percepcion != null) {
        setState(() {
          switch (widget.formData!.p14percepcion) {
            case 0:
              _P14Perc = P14Perc.Si;
            case 1:
              _P14Perc = P14Perc.No;
          }
        });
      }


      if (widget.formData!.p15percepcion != null) {
        setState(() {
          switch (widget.formData!.p15percepcion) {
            case 0:
              _P15Perc = P15Perc.Si;
            case 1:
              _P15Perc = P15Perc.No;
          }
        });
      }

      if (widget.formData!.p16percepcion1 != null) {
        setState(() {
          switch (widget.formData!.p16percepcion1) {
            case 0:
              _P16Perc1 = P16Perc1.esposa;
            case 1:
              _P16Perc1 = P16Perc1.conviviente;
            case 2:
              _P16Perc1 = P16Perc1.hijo;
            case 3:
              _P16Perc1 = P16Perc1.hijastro;
            case 4:
              _P16Perc1 = P16Perc1.yerno;
            case 5:
              _P16Perc1 = P16Perc1.nieto;
            case 6:
              _P16Perc1 = P16Perc1.padres;
            case 7:
              _P16Perc1 = P16Perc1.suegro;
            case 8:
              _P16Perc1 = P16Perc1.hermano;
            case 9:
              _P16Perc1 = P16Perc1.trabajador;
            case 10:
              _P16Perc1 = P16Perc1.otropariente;
            case 11:
              _P16Perc1 = P16Perc1.otronopariente;
          }
        });
      }

      if (widget.formData!.p16percepcionEspecificar1 != null  && widget.formData!.p16percepcionEspecificar1!.isNotEmpty) {
        setState(() {
          widget.P16EspecificarPerc1!.text = widget.formData!.p16percepcionEspecificar1!; //
        });
      }

      if (widget.formData!.p16percepcion2 != null) {
        setState(() {
          switch (widget.formData!.p16percepcion2) {
            case 0:
              _P16Perc2 = P16Perc2.esposa;
            case 1:
              _P16Perc2 = P16Perc2.conviviente;
            case 2:
              _P16Perc2 = P16Perc2.hijo;
            case 3:
              _P16Perc2 = P16Perc2.hijastro;
            case 4:
              _P16Perc2 = P16Perc2.yerno;
            case 5:
              _P16Perc2 = P16Perc2.nieto;
            case 6:
              _P16Perc2 = P16Perc2.padres;
            case 7:
              _P16Perc2 = P16Perc2.suegro;
            case 8:
              _P16Perc2 = P16Perc2.hermano;
            case 9:
              _P16Perc2 = P16Perc2.trabajador;
            case 10:
              _P16Perc2 = P16Perc2.otropariente;
            case 11:
              _P16Perc2 = P16Perc2.otronopariente;
          }
        });
      }

      if (widget.formData!.p16percepcionEspecificar2 != null  && widget.formData!.p16percepcionEspecificar2!.isNotEmpty) {
        setState(() {
          widget.P16EspecificarPerc2!.text = widget.formData!.p16percepcionEspecificar2!;
        });
      }

      if (widget.formData!.p16percepcion3 != null) {
        setState(() {
          switch (widget.formData!.p16percepcion3) {
            case 0:
              _P16Perc3 = P16Perc3.esposa;
            case 1:
              _P16Perc3 = P16Perc3.conviviente;
            case 2:
              _P16Perc3 = P16Perc3.hijo;
            case 3:
              _P16Perc3 = P16Perc3.hijastro;
            case 4:
              _P16Perc3 = P16Perc3.yerno;
            case 5:
              _P16Perc3 = P16Perc3.nieto;
            case 6:
              _P16Perc3 = P16Perc3.padres;
            case 7:
              _P16Perc3 = P16Perc3.suegro;
            case 8:
              _P16Perc3 = P16Perc3.hermano;
            case 9:
              _P16Perc3 = P16Perc3.trabajador;
            case 10:
              _P16Perc3 = P16Perc3.otropariente;
            case 11:
              _P16Perc3 = P16Perc3.otronopariente;
          }
        });
      }

      if (widget.formData!.p16percepcionEspecificar3 != null  && widget.formData!.p16percepcionEspecificar3!.isNotEmpty) {
        setState(() {
          widget.P16EspecificarPerc3!.text = widget.formData!.p16percepcionEspecificar3!;
        });
      }


      if (widget.formData!.p17percepcion1 != null) {
        setState(() {
          switch (widget.formData!.p17percepcion1) {
            case 0:
              _P17Perc1 = P17Perc1.Si;
            case 1:
              _P17Perc1 = P17Perc1.No;
          }
        });
      }

      if (widget.formData!.p17percepcion2 != null) {
        setState(() {
          switch (widget.formData!.p17percepcion2) {
            case 0:
              _P17Perc2 = P17Perc2.Si;
            case 1:
              _P17Perc2 = P17Perc2.No;
          }
        });
      }

      if (widget.formData!.p17percepcion3 != null) {
        setState(() {
          switch (widget.formData!.p17percepcion3) {
            case 0:
              _P17Perc3 = P17Perc3.Si;
            case 1:
              _P17Perc3 = P17Perc3.No;
          }
        });
      }

      if (widget.formData!.p18percepcion1 != null) {
        setState(() {
          switch (widget.formData!.p18percepcion1) {
            case 0:
              _P18Perc1 = P18Perc1.hombre;
            case 1:
              _P18Perc1 = P18Perc1.mujer;
          }
        });
      }

      if (widget.formData!.p18percepcion2 != null) {
        setState(() {
          switch (widget.formData!.p18percepcion2) {
            case 0:
              _P18Perc2 = P18Perc2.hombre;
            case 1:
              _P18Perc2 = P18Perc2.mujer;
          }
        });
      }

      if (widget.formData!.p18percepcion3 != null) {
        setState(() {
          switch (widget.formData!.p18percepcion3) {
            case 0:
              _P18Perc3 = P18Perc3.hombre;
            case 1:
              _P18Perc3 = P18Perc3.mujer;
          }
        });
      }

      if (widget.formData!.p19percepcion1 != null  && widget.formData!.p19percepcion1!.isNotEmpty) {
        setState(() {
          widget.P19EspecificarPerc1!.text = widget.formData!.p19percepcion1!;
        });
      }

      if (widget.formData!.p19percepcion2 != null  && widget.formData!.p19percepcion2!.isNotEmpty) {
        setState(() {
          widget.P19EspecificarPerc2!.text = widget.formData!.p19percepcion2!;
        });
      }

      if (widget.formData!.p19percepcion3 != null  && widget.formData!.p19percepcion3!.isNotEmpty) {
        setState(() {
          widget.P19EspecificarPerc3!.text = widget.formData!.p19percepcion3!;
        });
      }

      if (widget.formData!.p20percepcion != null) {
        setState(() {
          switch (widget.formData!.p20percepcion) {
            case 0:
              _P20Perc = P20Perc.Si;
            case 1:
              _P20Perc = P20Perc.No;
          }
        });
      }

      if (widget.formData!.p21percepcion != null) {
        setState(() {
          switch (widget.formData!.p21percepcion) {
            case 0:
              _P21Perc = P21Perc.omadep;
            case 1:
              _P21Perc = P21Perc.familaires;
            case 2:
              _P21Perc = P21Perc.medios;
            case 3:
              _P21Perc = P21Perc.personal;
            case 4:
              _P21Perc = P21Perc.yo;
            case 5:
              _P21Perc = P21Perc.otro;
          }
        });
      }

      if (widget.formData!.p21percepcionEspecificar != null  && widget.formData!.p21percepcionEspecificar!.isNotEmpty) {
        setState(() {
          widget.P21EspecificarPerc!.text = widget.formData!.p21percepcionEspecificar!;
        });
      }

      if (widget.formData!.p22percepcion != null) {
        setState(() {
          switch (widget.formData!.p22percepcion) {
            case 0:
              _P22Perc = P22Perc.muybuena;
            case 1:
              _P22Perc = P22Perc.buena;
            case 2:
              _P22Perc = P22Perc.mala;
            case 3:
              _P22Perc = P22Perc.muymala;
            case 4:
              _P22Perc = P22Perc.nosabe;
          }
        });
      }

      if (widget.formData!.p23percepcion != null) {
        setState(() {
          switch (widget.formData!.p23percepcion) {
            case 0:
              _P23Perc = P23Perc.bastante;
            case 1:
              _P23Perc = P23Perc.suficiente;
            case 2:
              _P23Perc = P23Perc.poco;
            case 3:
              _P23Perc = P23Perc.nada;
            case 4:
              _P23Perc = P23Perc.nosabe;
          }
        });
      }

      if (widget.formData!.p24percepcion != null) {
        setState(() {
          switch (widget.formData!.p24percepcion) {
            case 0:
              _P24Perc = P24Perc.sigueigual;
            case 1:
              _P24Perc = P24Perc.hamejorado;
            case 2:
              _P24Perc = P24Perc.haempeorado;
            case 3:
              _P24Perc = P24Perc.nosabe;
          }
        });
      }

      if (widget.formData!.p25percepcion != null) {
        setState(() {
          switch (widget.formData!.p25percepcion) {
            case 0:
              _P25Perc = P25Perc.muybuena;
            case 1:
              _P25Perc = P25Perc.buena;
            case 2:
              _P25Perc = P25Perc.mala;
            case 3:
              _P25Perc = P25Perc.muymala;
            case 4:
              _P25Perc = P25Perc.nosabe;
          }
        });
      }

      if (widget.formData!.p26percepcion != null) {
        setState(() {
          switch (widget.formData!.p26percepcion) {
            case 0:
              _P26Perc = P26Perc.Si;
            case 1:
              _P26Perc = P26Perc.No;
          }
        });
      }

      if (widget.formData!.p27percepcion != null) {
        setState(() {
          switch (widget.formData!.p27percepcion) {
            case 0:
              _P27Perc = P27Perc.Si;
            case 1:
              _P27Perc = P27Perc.No;
          }
        });
      }





      if (widget.formData!.p30percepcion != null  && widget.formData!.p30percepcion!.isNotEmpty) {
        setState(() {
          if( widget.formData!.p30percepcion!.contains('A')){isCheckedP30Opcion01 = true;}
          if( widget.formData!.p30percepcion!.contains('B')){isCheckedP30Opcion02 = true;}
          if( widget.formData!.p30percepcion!.contains('C')){isCheckedP30Opcion03 = true;}
          if( widget.formData!.p30percepcion!.contains('D')){isCheckedP30Opcion04 = true;}
          if( widget.formData!.p30percepcion!.contains('E')){isCheckedP30Opcion05 = true;}
          if( widget.formData!.p30percepcion!.contains('F')){isCheckedP30Opcion06 = true;}
          if( widget.formData!.p30percepcion!.contains('G')){isCheckedP30Opcion07 = true;}
          if( widget.formData!.p30percepcion!.contains('H')){isCheckedP30Opcion08 = true;}
          if( widget.formData!.p30percepcion!.contains('I')){isCheckedP30Opcion09 = true;}
          if( widget.formData!.p30percepcion!.contains('J')){isCheckedP30Opcion10 = true;}
          if( widget.formData!.p30percepcion!.contains('K')){isCheckedP30Opcion11 = true;}
          if( widget.formData!.p30percepcion!.contains('L')){isCheckedP30Opcion12 = true;}
          if( widget.formData!.p30percepcion!.contains('M')){isCheckedP30Opcion13 = true;}
          if( widget.formData!.p30percepcion!.contains('N')){isCheckedP30Opcion14 = true;}
        });
      }


      //30 31 32 33 is checked
      /*
      if (widget.formData!.P32Perc01 != null) {
        setState(() {
          switch (widget.formData!.p36percepcion) {
            case 0:
              _P32Perc01 = P32Perc01.esposa;
            case 1:
              _P32Perc01 = P32Perc01.conviviente;
            case 2:
              _P32Perc01 = P32Perc01.hijo;
            case 3:
              _P32Perc01 = P32Perc01.hijastro;
            case 4:
              _P32Perc01 = P32Perc01.yerno;
            case 5:
              _P32Perc01 = P32Perc01.nieto;
            case 6:
              _P32Perc01 = P32Perc01.nieto;
            case 7:
              _P32Perc01 = P32Perc01.suegro;
            case 8:
              _P32Perc01 = P32Perc01.hermano;
            case 9:
              _P32Perc01 = P32Perc01.trabajador;
            case 10:
              _P32Perc01 = P32Perc01.otropariente;
            case 11:
              _P32Perc01 = P32Perc01.otronopariente;
          }
        });
      }
*/

      if (widget.formData!.p34percepcion != null) {
        setState(() {
          switch (widget.formData!.p34percepcion) {
            case 0:
              _P34Perc = P34Perc.muysatisfecho;
            case 1:
              _P34Perc = P34Perc.satisfecho;
            case 2:
              _P34Perc = P34Perc.insatisfecho;
            case 3:
              _P34Perc = P34Perc.muyinsatisfecho;
            case 4:
              _P34Perc = P34Perc.nosabe;
          }
        });
      }

      if (widget.formData!.p35percepcion != null) {
        setState(() {
          switch (widget.formData!.p35percepcion) {
            case 0:
              _P35Perc = P35Perc.nunca;
            case 1:
              _P35Perc = P35Perc.algunavez;
            case 2:
              _P35Perc = P35Perc.frecuente;
            case 3:
              _P35Perc = P35Perc.siempre;
          }
        });
      }

      if (widget.formData!.p36percepcion != null) {
        setState(() {
          switch (widget.formData!.p36percepcion) {
            case 0:
              _P36Perc = P36Perc.nunca;
            case 1:
              _P36Perc = P36Perc.algunavez;
            case 2:
              _P36Perc = P36Perc.frecuente;
            case 3:
              _P36Perc = P36Perc.siempre;
          }
        });
      }

      if (widget.formData!.p37percepcion != null) {
        setState(() {
          switch (widget.formData!.p37percepcion) {
            case 0:
              _P37Perc = P37Perc.nunca;
            case 1:
              _P37Perc = P37Perc.algunavez;
            case 2:
              _P37Perc = P37Perc.frecuente;
            case 3:
              _P37Perc = P37Perc.siempre;
          }
        });
      }

      if (widget.formData!.p38percepcion != null) {
        setState(() {
          switch (widget.formData!.p38percepcion) {
            case 0:
              _P38Perc = P38Perc.nunca;
            case 1:
              _P38Perc = P38Perc.algunavez;
            case 2:
              _P38Perc = P38Perc.frecuente;
            case 3:
              _P38Perc = P38Perc.siempre;
          }
        });
      }

      if (widget.formData!.p39percepcion != null) {
        setState(() {
          switch (widget.formData!.p39percepcion) {
            case 0:
              _P39Perc = P39Perc.nunca;
            case 1:
              _P39Perc = P39Perc.algunavez;
            case 2:
              _P39Perc = P39Perc.frecuente;
            case 3:
              _P39Perc = P39Perc.siempre;
          }
        });
      }

      if (widget.formData!.p40percepcion != null) {
        setState(() {
          switch (widget.formData!.p40percepcion) {
            case 0:
              _P40Perc = P40Perc.muysatisfecho;
            case 1:
              _P40Perc = P40Perc.satisfecho;
            case 2:
              _P40Perc = P40Perc.insatisfecho;
            case 3:
              _P40Perc = P40Perc.muyinsatisfecho;
            case 4:
              _P40Perc = P40Perc.nosabe;
          }
        });
      }

      if (widget.formData!.p41percepcion != null) {
        setState(() {
          switch (widget.formData!.p41percepcion) {
            case 0:
              _P41Perc = P41Perc.sigueigual;
            case 1:
              _P41Perc = P41Perc.hamejorado;
            case 2:
              _P41Perc = P41Perc.haempeorado;
            case 3:
              _P41Perc = P41Perc.nosabe;
          }
        });
      }

      //42
      if (widget.formData!.p42percepcion != null  && widget.formData!.p42percepcion!.isNotEmpty) {
        setState(() {
          if( widget.formData!.p42percepcion!.contains('A1')){P42Perc01Salud = true;}
          if( widget.formData!.p42percepcion!.contains('A2')){P42Perc01Salud = true; P42Perc02Salud = true;}
          if( widget.formData!.p42percepcion!.contains('A3')){P42Perc01Salud = true; P42Perc02Salud = true; P42Perc03Salud = true;}
          if( widget.formData!.p42percepcion!.contains('B1')){P42Perc01SaludF = true;}
          if( widget.formData!.p42percepcion!.contains('B2')){P42Perc01SaludF = true; P42Perc02SaludF = true;}
          if( widget.formData!.p42percepcion!.contains('B3')){P42Perc01SaludF = true; P42Perc02SaludF = true; P42Perc03SaludF = true;}
          if( widget.formData!.p42percepcion!.contains('C1')){P42Perc01Dinero = true;}
          if( widget.formData!.p42percepcion!.contains('C2')){P42Perc01Dinero = true; P42Perc02Dinero = true;}
          if( widget.formData!.p42percepcion!.contains('C3')){P42Perc01Dinero = true; P42Perc02Dinero = true; P42Perc03Dinero = true;}
          if( widget.formData!.p42percepcion!.contains('D1')){P42Perc01ProblemasF = true;}
          if( widget.formData!.p42percepcion!.contains('D2')){P42Perc01ProblemasF = true; P42Perc02ProblemasF = true;}
          if( widget.formData!.p42percepcion!.contains('D3')){P42Perc01ProblemasF = true; P42Perc02ProblemasF = true; P42Perc03ProblemasF = true;}
          if( widget.formData!.p42percepcion!.contains('E1')){P42Perc01Falta = true;}
          if( widget.formData!.p42percepcion!.contains('E2')){P42Perc01Falta = true; P42Perc02Falta = true;}
          if( widget.formData!.p42percepcion!.contains('E3')){P42Perc01Falta = true; P42Perc02Falta = true; P42Perc03Falta = true;}
          if( widget.formData!.p42percepcion!.contains('F1')){P42Perc01ProblemasV = true;}
          if( widget.formData!.p42percepcion!.contains('F2')){P42Perc01ProblemasV = true; P42Perc02ProblemasV = true;}
          if( widget.formData!.p42percepcion!.contains('F3')){P42Perc01ProblemasV = true; P42Perc02ProblemasV = true; P42Perc03ProblemasV = true;}
          if( widget.formData!.p42percepcion!.contains('G1')){P42Perc01Estudio = true;}
          if( widget.formData!.p42percepcion!.contains('G2')){P42Perc01Estudio = true; P42Perc02Estudio = true;}
          if( widget.formData!.p42percepcion!.contains('G3')){P42Perc01Estudio = true; P42Perc02Estudio = true; P42Perc03Estudio = true;}
          if( widget.formData!.p42percepcion!.contains('H1')){P42Perc01Otro = true;}
          if( widget.formData!.p42percepcion!.contains('H2')){P42Perc01Otro = true; P42Perc02Otro = true;}
          if( widget.formData!.p42percepcion!.contains('H3')){P42Perc01Otro = true; P42Perc02Otro = true; P42Perc03Otro = true;}
          if( widget.formData!.p42percepcion!.contains('I')){P42Perc03SinPreocupaciones = true;}
        });
      }


      if (widget.formData!.p42percepcionEspecificar != null  && widget.formData!.p42percepcionEspecificar!.isNotEmpty) {
        setState(() {
          widget.P42EspecificarPerc!.text = widget.formData!.p42percepcionEspecificar!;
        });
      }

      if (widget.formData!.p43percepcion != null) {
        setState(() {
          switch (widget.formData!.p43percepcion) {
            case 0:
              _P43Perc = P43Perc.Si;
            case 1:
              _P43Perc = P43Perc.No;
          }
        });
      }

      if (widget.formData!.p44percepcion != null) {
        setState(() {
          switch (widget.formData!.p44percepcion) {
            case 0:
              _P44Perc = P44Perc.omadep;
            case 1:
              _P44Perc = P44Perc.familaires;
            case 2:
              _P44Perc = P44Perc.medios;
            case 3:
              _P44Perc = P44Perc.personal;
            case 4:
              _P44Perc = P44Perc.banco;
            case 5:
              _P44Perc = P44Perc.yo;
            case 5:
              _P44Perc = P44Perc.otro;
          }
        });
      }

      if (widget.formData!.p44percepcionEspecificar != null  && widget.formData!.p44percepcionEspecificar!.isNotEmpty) {
        setState(() {
          widget.P44EspecificarPerc!.text = widget.formData!.p44percepcionEspecificar!;
        });
      }

      if (widget.formData!.p45percepcion != null) {
        setState(() {
          switch (widget.formData!.p45percepcion) {
            case 0:
              _P45Perc = P45Perc.dosmeses;
            case 1:
              _P45Perc = P45Perc.masdosmeses;
            case 2:
              _P45Perc = P45Perc.seismeses;
            case 3:
              _P45Perc = P45Perc.nosabe;
            case 4:
              _P45Perc = P45Perc.otro;
          }
        });
      }

      if (widget.formData!.p45percepcionEspecificar != null  && widget.formData!.p45percepcionEspecificar!.isNotEmpty) {
        setState(() {
          widget.P45EspecificarPerc!.text = widget.formData!.p45percepcionEspecificar!;
        });
      }

      if (widget.formData!.p46percepcion != null) {
        setState(() {
          switch (widget.formData!.p46percepcion) {
            case 0:
              _P46Perc = P46Perc.nosabiausuario;
            case 1:
              _P46Perc = P46Perc.nosabiafecha;
            case 2:
              _P46Perc = P46Perc.enfermo;
            case 3:
              _P46Perc = P46Perc.guarde;
            case 4:
              _P46Perc = P46Perc.movilidad;
            case 5:
              _P46Perc = P46Perc.nosabe;
            case 6:
              _P46Perc = P46Perc.otro;
          }
        });
      }

      if (widget.formData!.p46percepcionEspecificar != null  && widget.formData!.p46percepcionEspecificar!.isNotEmpty) {
        setState(() {
          widget.P46EspecificarPerc!.text = widget.formData!.p46percepcionEspecificar!;
        });
      }

      if (widget.formData!.p47percepcion != null) {
        setState(() {
          switch (widget.formData!.p47percepcion) {
            case 0:
              _P47Perc = P47Perc.independiente;
            case 1:
              _P47Perc = P47Perc.cuidador;
            case 2:
              _P47Perc = P47Perc.familiar;
            case 3:
              _P47Perc = P47Perc.municipalidad;
            case 4:
              _P47Perc = P47Perc.cobro;
          }
        });
      }

      if (widget.formData!.p48percepcion != null) {
        setState(() {
          switch (widget.formData!.p48percepcion) {
            case 0:
              _P48Perc = P48Perc.mediahora;
            case 1:
              _P48Perc = P48Perc.masmediahora;
            case 2:
              _P48Perc = P48Perc.unoadoshoras;
            case 3:
              _P48Perc = P48Perc.masdoshoras;
          }
        });
      }

      if (widget.formData!.p49percepcion != null) {
        setState(() {
          switch (widget.formData!.p49percepcion) {
            case 0:
              _P49Perc = P49Perc.apie;
            case 1:
              _P49Perc = P49Perc.bicicletas;
            case 2:
              _P49Perc = P49Perc.caballo;
            case 3:
              _P49Perc = P49Perc.mototaxi;
            case 4:
              _P49Perc = P49Perc.motocicleta;
            case 5:
              _P49Perc = P49Perc.automovil;
            case 6:
              _P49Perc = P49Perc.taxi;
            case 7:
              _P49Perc = P49Perc.colectivo;
            case 8:
              _P49Perc = P49Perc.camion;
            case 9:
              _P49Perc = P49Perc.otro;
          }
        });
      }

      if (widget.formData!.p49percepcionEspecificar != null  && widget.formData!.p49percepcionEspecificar!.isNotEmpty) {
        setState(() {
          widget.P49EspecificarPerc!.text = widget.formData!.p49percepcionEspecificar!;
        });
      }

      if (widget.formData!.p50percepcion != null  && widget.formData!.p50percepcion!.isNotEmpty) {
        setState(() {
          widget.P50EspecificarPerc!.text = widget.formData!.p50percepcion!;
        });
      }


      if (widget.formData!.p51percepcion != null) {
        setState(() {
          switch (widget.formData!.p51percepcion) {
            case 0:
              _P51Perc = P51Perc.banco;
            case 1:
              _P51Perc = P51Perc.debito;
            case 2:
              _P51Perc = P51Perc.agente;
            case 3:
              _P51Perc = P51Perc.pagador;
            case 4:
              _P51Perc = P51Perc.pias;
          }
        });
      }

      //52 es un check
      if (widget.formData!.p52percepcion != null  && widget.formData!.p52percepcion!.isNotEmpty) {
        setState(() {
          if( widget.formData!.p52percepcion!.contains('A')){P52Perc01= true;}
          if( widget.formData!.p52percepcion!.contains('B')){P52Perc02= true;}
          if( widget.formData!.p52percepcion!.contains('C')){P52Perc03= true;}
          if( widget.formData!.p52percepcion!.contains('D')){P52Perc04= true;}
          if( widget.formData!.p52percepcion!.contains('E')){P52Perc05= true;}
          if( widget.formData!.p52percepcion!.contains('F')){P52Perc06= true;}
          if( widget.formData!.p52percepcion!.contains('G')){P52Perc07= true;}
          if( widget.formData!.p52percepcion!.contains('H')){P52Perc08= true;}
          if( widget.formData!.p52percepcion!.contains('I')){P52Perc09= true;}
          if( widget.formData!.p52percepcion!.contains('J')){P52Perc10= true;}
          if( widget.formData!.p52percepcion!.contains('K')){P52Perc11= true;}
          if( widget.formData!.p52percepcion!.contains('L')){P52Perc12= true;}
        });
      }


      if (widget.formData!.p52percepcionEspecificar != null  && widget.formData!.p52percepcionEspecificar!.isNotEmpty) {
        setState(() {
          widget.P52EspecificarPerc!.text = widget.formData!.p52percepcionEspecificar!;
        });
      }

      if (widget.formData!.p53percepcion != null) {
        setState(() {
          switch (widget.formData!.p53percepcion) {
            case 0:
              _P53Perc = P53Perc.Si;
            case 1:
              _P53Perc = P53Perc.No;
          }
        });
      }

      //42
      if (widget.formData!.p54percepcion != null  && widget.formData!.p54percepcion!.isNotEmpty) {
        setState(() {
          if( widget.formData!.p54percepcion!.contains('A1')){P54Perc01Distancia = true;}
          if( widget.formData!.p54percepcion!.contains('A2')){P54Perc01Distancia = true; P54Perc02Distancia = true;}
          if( widget.formData!.p54percepcion!.contains('A3')){P54Perc01Distancia = true; P54Perc02Distancia = true; P54Perc03Distancia = true;}
          if( widget.formData!.p54percepcion!.contains('B1')){P54Perc01Fisico = true;}
          if( widget.formData!.p54percepcion!.contains('B2')){P54Perc01Fisico = true; P54Perc02Fisico = true;}
          if( widget.formData!.p54percepcion!.contains('B3')){P54Perc01Fisico = true; P54Perc02Fisico = true; P54Perc03Fisico = true;}
          if( widget.formData!.p54percepcion!.contains('C1')){P54Perc01Ausencia = true;}
          if( widget.formData!.p54percepcion!.contains('C2')){P54Perc01Ausencia = true; P54Perc02Ausencia = true;}
          if( widget.formData!.p54percepcion!.contains('C3')){P54Perc01Ausencia = true; P54Perc02Ausencia = true; P54Perc03Ausencia = true;}
          if( widget.formData!.p54percepcion!.contains('D1')){P54Perc01Requiere = true;}
          if( widget.formData!.p54percepcion!.contains('D2')){P54Perc01Requiere = true; P54Perc02Requiere = true;}
          if( widget.formData!.p54percepcion!.contains('D3')){P54Perc01Requiere = true; P54Perc02Requiere = true; P54Perc03Requiere = true;}
          if( widget.formData!.p54percepcion!.contains('E1')){P54Perc01Clima = true;}
          if( widget.formData!.p54percepcion!.contains('E2')){P54Perc01Clima = true; P54Perc02Clima = true;}
          if( widget.formData!.p54percepcion!.contains('E3')){P54Perc01Clima = true; P54Perc02Clima = true; P54Perc03Clima = true;}
          if( widget.formData!.p54percepcion!.contains('F1')){P54Perc01Terreno = true;}
          if( widget.formData!.p54percepcion!.contains('F2')){P54Perc01Terreno = true; P54Perc02Terreno = true;}
          if( widget.formData!.p54percepcion!.contains('F3')){P54Perc01Terreno = true; P54Perc02Terreno = true; P54Perc03Terreno = true;}
          if( widget.formData!.p54percepcion!.contains('G1')){P54Perc01Otro = true;}
          if( widget.formData!.p54percepcion!.contains('G2')){P54Perc01Otro = true; P54Perc02Otro = true;}
          if( widget.formData!.p54percepcion!.contains('G3')){P54Perc01Otro = true; P54Perc02Otro = true; P54Perc03Otro = true;}
        });
      }

      if (widget.formData!.p54percepcionEspecificar != null  && widget.formData!.p54percepcionEspecificar!.isNotEmpty) {
        setState(() {
          widget.P54EspecificarPerc!.text = widget.formData!.p54percepcionEspecificar!;
        });
      }

      if (widget.formData!.p55percepcion != null) {
        setState(() {
          switch (widget.formData!.p55percepcion) {
            case 0:
              _P55Perc = P55Perc.Si;
            case 1:
              _P55Perc = P55Perc.No;
          }
        });
      }

      if (widget.formData!.p56percepcion != null) {
        setState(() {
          switch (widget.formData!.p56percepcion) {
            case 0:
              _P56Perc = P56Perc.cuidador;
            case 1:
              _P56Perc = P56Perc.autorizada;
          }
        });
      }

      if (widget.formData!.p57percepcion != null) {
        setState(() {
          switch (widget.formData!.p57percepcion) {
            case 0:
              _P57Perc = P57Perc.salud;
            case 1:
              _P57Perc = P57Perc.ayuda;
            case 2:
              _P57Perc = P57Perc.alimentacion;
            case 3:
              _P57Perc = P57Perc.vestimenta;
            case 4:
              _P57Perc = P57Perc.transporte;
            case 5:
              _P57Perc = P57Perc.invierte;
            case 6:
              _P57Perc = P57Perc.mejora;
            case 7:
              _P57Perc = P57Perc.ahorra;
            case 8:
              _P57Perc = P57Perc.pago;
            case 9:
              _P57Perc = P57Perc.nosabe;
            case 10:
              _P57Perc = P57Perc.otro;
          }
        });
      }

      if (widget.formData!.p57percepcionEspecificar != null  && widget.formData!.p57percepcionEspecificar!.isNotEmpty) {
        setState(() {
          widget.P57EspecificarPerc!.text = widget.formData!.p57percepcionEspecificar!;
        });
      }

    }

    // TODO: implement initState
    super.initState();
  }
  final _tip09 = SuperTooltipController();
  final _tip10 = SuperTooltipController();
  final _tip11 = SuperTooltipController();
  final _tip12 = SuperTooltipController();
  final _tip13 = SuperTooltipController();
  final _tip14 = SuperTooltipController();
  final _tip15 = SuperTooltipController();

  final _tip16 = SuperTooltipController();
  final _tip16a = SuperTooltipController();
  final _tip16b = SuperTooltipController();

  final _tip17 = SuperTooltipController();
  final _tip17a = SuperTooltipController();
  final _tip17b = SuperTooltipController();

  final _tip18 = SuperTooltipController();
  final _tip18a = SuperTooltipController();
  final _tip18b = SuperTooltipController();

  final _tip19 = SuperTooltipController();
  final _tip19a = SuperTooltipController();
  final _tip19b = SuperTooltipController();

  final _tip20 = SuperTooltipController();
  final _tip21 = SuperTooltipController();
  final _tip22 = SuperTooltipController();
  final _tip23 = SuperTooltipController();
  final _tip24 = SuperTooltipController();
  final _tip25 = SuperTooltipController();
  final _tip26 = SuperTooltipController();
  final _tip27 = SuperTooltipController();
  final _tip28 = SuperTooltipController();
  final _tip29 = SuperTooltipController();
  final _tip30 = SuperTooltipController();
  final _tip31 = SuperTooltipController();
  final _tip32 = SuperTooltipController();
  final _tip33 = SuperTooltipController();
  final _tip34 = SuperTooltipController();
  final _tip35 = SuperTooltipController();
  final _tip36 = SuperTooltipController();
  final _tip37 = SuperTooltipController();
  final _tip38 = SuperTooltipController();
  final _tip39 = SuperTooltipController();
  final _tip40 = SuperTooltipController();
  final _tip41 = SuperTooltipController();
  final _tip42 = SuperTooltipController();
  final _tip43 = SuperTooltipController();
  final _tip44 = SuperTooltipController();
  final _tip45 = SuperTooltipController();
  final _tip46 = SuperTooltipController();
  final _tip47 = SuperTooltipController();
  final _tip48 = SuperTooltipController();
  final _tip49 = SuperTooltipController();
  final _tip50 = SuperTooltipController();
  final _tip51 = SuperTooltipController();
  final _tip52 = SuperTooltipController();
  final _tip53 = SuperTooltipController();
  final _tip54 = SuperTooltipController();
  final _tip55 = SuperTooltipController();
  final _tip56 = SuperTooltipController();
  final _tip57 = SuperTooltipController();


  bool isSatelliteGreen = false;

  bool Fase1 = true;
  bool Fase2 = false;
  bool Fase3 = false;
  bool Fase4 = false;
  bool Fase5 = false;
  bool Fase6 = false;
  bool Fase7 = false;

  bool isCheckedP30Opcion01 = false;
  bool isCheckedP30Opcion02 = false;
  bool isCheckedP30Opcion03 = false;
  bool isCheckedP30Opcion04 = false;
  bool isCheckedP30Opcion05 = false;
  bool isCheckedP30Opcion06 = false;
  bool isCheckedP30Opcion07 = false;
  bool isCheckedP30Opcion08 = false;
  bool isCheckedP30Opcion09 = false;
  bool isCheckedP30Opcion10 = false;
  bool isCheckedP30Opcion11 = false;
  bool isCheckedP30Opcion12 = false;
  bool isCheckedP30Opcion13 = false;
  bool isCheckedP30Opcion14 = false;

  Future<void> revisarBackup() async {
    if (widget.formDataBACKUP != null) {
      widget.formDataBACKUP!.cod = 0;
    }


    listBackup = await widget.formDataModelDaoBackup.findAllRespuesta();
    setState(() {
      if (listBackup.isNotEmpty) {
        widget.backup = true;
        //objBackup = listBackup[0];
      } else {
        widget.backup = false;
      }
    });
  }

  void ConseguirHora() {
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
      horaFechaInicio = formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());
    });
  }



  Future<void> capturarCoordenadas() async {
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

  Future<void> guardadoFase1() async {
    //widget.formData?.tipoencuesta = Resources.valor_percepciones;
    //MODULO I
    widget.formData?.nombre_usuario =widget.formNombreUsuario!.text;
    widget.formDataBACKUP?.nombre_usuario = widget.formNombreUsuario!.text;

    widget.formData?.id_usuario =widget.formIdUsuario!.text;
    widget.formDataBACKUP?.id_usuario = widget.formIdUsuario!.text;

    PercP01 = "${PercP01}${widget.P01EspecificarPerc!.text};";
    widget.formData?.p01percepcion =widget.P01EspecificarPerc!.text;
    widget.formDataBACKUP?.p01percepcion =widget.P01EspecificarPerc!.text;

    PercP02 = "${PercP02}${widget.P02EspecificarPerc!.text};";
    widget.formData?.p02percepcion =widget.P02EspecificarPerc!.text;
    widget.formDataBACKUP?.p02percepcion =widget.P02EspecificarPerc!.text;

    PercP03 = "${PercP03}${widget.P03EspecificarPerc!.text};";
    widget.formData?.p03percepcion =widget.P03EspecificarPerc!.text;
    widget.formDataBACKUP?.p03percepcion =widget.P03EspecificarPerc!.text;

    PercP04 = "${PercP04}${widget.P04EspecificarPerc!.text};";
    widget.formData?.p04percepcion =widget.P04EspecificarPerc!.text;
    widget.formDataBACKUP?.p04percepcion =widget.P04EspecificarPerc!.text;


    if (_P05Perc == P05Perc.avenida) {PercP05 = "${PercP05}Avenida-A;";}
    if (_P05Perc == P05Perc.calle) {PercP05 = "${PercP05}Calle-B;";}
    if (_P05Perc == P05Perc.jiron) {PercP05 = "${PercP05}Jiron-C;";}
    if (_P05Perc == P05Perc.pasaje) {PercP05 = "${PercP05}Pasaje-D;";}
    if (_P05Perc == P05Perc.carretera) {PercP05 = "${PercP05}Carretera-E;";}
    if (_P05Perc == P05Perc.otro) {PercP05 = "${PercP05}Otro-F;";}

    widget.formData?.p05percepcion = _P05Perc?.index;
    widget.formDataBACKUP?.p05percepcion = _P05Perc?.index;

    PercP06 = "${PercP06}${widget.P06EspecificarPerc!.text};";
    widget.formData?.p06percepcion =widget.P06EspecificarPerc!.text;
    widget.formDataBACKUP?.p06percepcion =widget.P06EspecificarPerc!.text;

    PercP07 = "${PercP07}${widget.P07EspecificarPerc!.text};";
    widget.formData?.p07percepcion =widget.P07EspecificarPerc!.text;
    widget.formDataBACKUP?.p07percepcion =widget.P04EspecificarPerc!.text;

    PercP08 = "${PercP08}${widget.P08EspecificarPerc!.text};";
    widget.formData?.p08percepcion =widget.P08EspecificarPerc!.text;
    widget.formDataBACKUP?.p08percepcion =widget.P08EspecificarPerc!.text;

    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }


  Future<void> guardadoFase2() async {
    //MODULO II

    if (_P09Perc == P09Perc.Si) {PercP05 = "${PercP09}Sí-A;";}
    if (_P09Perc == P09Perc.No) {PercP05 = "${PercP09}No-B;";}
    widget.formData?.p09percepcion = _P09Perc?.index;
    widget.formDataBACKUP?.p09percepcion = _P09Perc?.index;

    if (_P10Perc == P10Perc.Si) {PercP10 = "${PercP10}Sí-A;";}
    if (_P10Perc == P10Perc.No) {PercP10 = "${PercP10}No-B;";}
    widget.formData?.p10percepcion = _P10Perc?.index;
    widget.formDataBACKUP?.p10percepcion = _P10Perc?.index;

    PercP12 = "${PercP11}${widget.P11EspecificarPerc!.text};";
    widget.formData?.p11percepcion =widget.P11EspecificarPerc!.text;
    widget.formDataBACKUP?.p11percepcion =widget.P11EspecificarPerc!.text;

    if (_P12Perc == P12Perc.hombre) {PercP13 = "${PercP13}Hombre-A;";}
    if (_P12Perc == P12Perc.mujer) {PercP13 = "${PercP13}Mujer-B;";}
    widget.formData?.p12percepcion = _P12Perc?.index;
    widget.formDataBACKUP?.p12percepcion = _P12Perc?.index;

    if (_P13Perc == P13Perc.Si) {PercP13 = "${PercP13}Sí-A;";}
    if (_P13Perc == P13Perc.No) {PercP13 = "${PercP13}No-B;";}
    widget.formData?.p13percepcion = _P13Perc?.index;
    widget.formDataBACKUP?.p13percepcion = _P13Perc?.index;

    if (_P14Perc == P14Perc.Si) {PercP14 = "${PercP14}Sí-A;";}
    if (_P14Perc == P14Perc.No) {PercP14 = "${PercP14}No-B;";}
    widget.formData?.p14percepcion = _P14Perc?.index;
    widget.formDataBACKUP?.p14percepcion = _P14Perc?.index;

    if (_P15Perc == P15Perc.Si) {PercP15 = "${PercP15}Sí-A;";}
    if (_P15Perc == P15Perc.No) {PercP15 = "${PercP15}No-B;";}
    widget.formData?.p15percepcion = _P15Perc?.index;
    widget.formDataBACKUP?.p15percepcion = _P15Perc?.index;

    if (_P16Perc1 == P16Perc1.esposa) {PercP16 = "${PercP16}Esposa/o-A;";} //
    if (_P16Perc1 == P16Perc1.conviviente) {PercP16 = "${PercP16}Conviviente-B;";}
    if (_P16Perc1 == P16Perc1.hijo) {PercP16 = "${PercP16}Hijo/a-C;";}
    if (_P16Perc1 == P16Perc1.hijastro) {PercP16 = "${PercP16}Hijastro/a-D;";}
    if (_P16Perc1 == P16Perc1.yerno) {PercP16 = "${PercP16}Yerno/nuera-E;";}
    if (_P16Perc1 == P16Perc1.nieto) {PercP16 = "${PercP16}Nieto/a-F;";}
    if (_P16Perc1 == P16Perc1.padres) {PercP16 = "${PercP16}Padre/madre-G;";}
    if (_P16Perc1 == P16Perc1.suegro) {PercP16 = "${PercP16}Suegro/a-H;";}
    if (_P16Perc1 == P16Perc1.hermano) {PercP16 = "${PercP16}Hermano/a-I;";}
    if (_P16Perc1 == P16Perc1.trabajador) {PercP16 = "${PercP16}Trabajador/a del hogar-J;";}
    if (_P16Perc1 == P16Perc1.otropariente) {PercP16 = "${PercP16}Otro/a pariente-K:${widget.P16EspecificarPerc1!.text};";}
    if (_P16Perc1 == P16Perc1.otronopariente) {PercP16 = "${PercP16}Otro/a no pariente-L:${widget.P16EspecificarPerc1!.text};";}
    widget.formData?.p16percepcion1 = _P16Perc1?.index;
    widget.formDataBACKUP?.p16percepcion1 = _P16Perc1?.index;
    widget.formData?.p16percepcionEspecificar1 =widget.P16EspecificarPerc1!.text;
    widget.formDataBACKUP?.p16percepcionEspecificar1 =widget.P16EspecificarPerc1!.text;

    if (_P16Perc2 == P16Perc2.esposa) {PercP16 = "${PercP16}Esposa/o-A;";} //
    if (_P16Perc2 == P16Perc2.conviviente) {PercP16 = "${PercP16}Conviviente-B;";}
    if (_P16Perc2 == P16Perc2.hijo) {PercP16 = "${PercP16}Hijo/a-C;";}
    if (_P16Perc2 == P16Perc2.hijastro) {PercP16 = "${PercP16}Hijastro/a-D;";}
    if (_P16Perc2 == P16Perc2.yerno) {PercP16 = "${PercP16}Yerno/nuera-E;";}
    if (_P16Perc2 == P16Perc2.nieto) {PercP16 = "${PercP16}Nieto/a-F;";}
    if (_P16Perc2 == P16Perc2.padres) {PercP16 = "${PercP16}Padre/madre-G;";}
    if (_P16Perc2 == P16Perc2.suegro) {PercP16 = "${PercP16}Suegro/a-H;";}
    if (_P16Perc2 == P16Perc2.hermano) {PercP16 = "${PercP16}Hermano/a-I;";}
    if (_P16Perc2 == P16Perc2.trabajador) {PercP16 = "${PercP16}Trabajador/a del hogar-J;";}
    if (_P16Perc2 == P16Perc2.otropariente) {PercP16 = "${PercP16}Otro/a pariente-K:${widget.P16EspecificarPerc2!.text};";}
    if (_P16Perc2 == P16Perc2.otronopariente) {PercP16 = "${PercP16}Otro/a no pariente-L:${widget.P16EspecificarPerc2!.text};";}
    widget.formData?.p16percepcion2 = _P16Perc2?.index;
    widget.formDataBACKUP?.p16percepcion2 = _P16Perc2?.index;
    widget.formData?.p16percepcionEspecificar2 =widget.P16EspecificarPerc2!.text;
    widget.formDataBACKUP?.p16percepcionEspecificar2 =widget.P16EspecificarPerc2!.text;

    if (_P16Perc3 == P16Perc3.esposa) {PercP16 = "${PercP16}Esposa/o-A;";} //
    if (_P16Perc3 == P16Perc3.conviviente) {PercP16 = "${PercP16}Conviviente-B;";}
    if (_P16Perc3 == P16Perc3.hijo) {PercP16 = "${PercP16}Hijo/a-C;";}
    if (_P16Perc3 == P16Perc3.hijastro) {PercP16 = "${PercP16}Hijastro/a-D;";}
    if (_P16Perc3 == P16Perc3.yerno) {PercP16 = "${PercP16}Yerno/nuera-E;";}
    if (_P16Perc3 == P16Perc3.nieto) {PercP16 = "${PercP16}Nieto/a-F;";}
    if (_P16Perc3 == P16Perc3.padres) {PercP16 = "${PercP16}Padre/madre-G;";}
    if (_P16Perc3 == P16Perc3.suegro) {PercP16 = "${PercP16}Suegro/a-H;";}
    if (_P16Perc3 == P16Perc3.hermano) {PercP16 = "${PercP16}Hermano/a-I;";}
    if (_P16Perc3 == P16Perc3.trabajador) {PercP16 = "${PercP16}Trabajador/a del hogar-J;";}
    if (_P16Perc3 == P16Perc3.otropariente) {PercP16 = "${PercP16}Otro/a pariente-K:${widget.P16EspecificarPerc3!.text};";}
    if (_P16Perc3 == P16Perc3.otronopariente) {PercP16 = "${PercP16}Otro/a no pariente-L:${widget.P16EspecificarPerc3!.text};";}
    widget.formData?.p16percepcion3 = _P16Perc3?.index;
    widget.formDataBACKUP?.p16percepcion3 = _P16Perc3?.index;
    widget.formData?.p16percepcionEspecificar3 =widget.P16EspecificarPerc3!.text;
    widget.formDataBACKUP?.p16percepcionEspecificar3 =widget.P16EspecificarPerc3!.text;

    if (_P17Perc1 == P17Perc1.Si) {PercP17 = "${PercP17}Sí-A;";}
    if (_P17Perc1 == P17Perc1.No) {PercP17 = "${PercP17}No-B;";}
    widget.formData?.p17percepcion1 = _P17Perc1?.index;
    widget.formDataBACKUP?.p17percepcion1 = _P17Perc1?.index;

    if (_P17Perc2 == P17Perc2.Si) {PercP17 = "${PercP17}Sí-A;";}
    if (_P17Perc2 == P17Perc2.No) {PercP17 = "${PercP17}No-B;";}
    widget.formData?.p17percepcion2 = _P17Perc2?.index;
    widget.formDataBACKUP?.p17percepcion2 = _P17Perc2?.index;

    if (_P17Perc3 == P17Perc3.Si) {PercP17 = "${PercP17}Sí-A;";}
    if (_P17Perc3 == P17Perc3.No) {PercP17 = "${PercP17}No-B;";}
    widget.formData?.p17percepcion3 = _P17Perc3?.index;
    widget.formDataBACKUP?.p17percepcion3 = _P17Perc3?.index;

    if (_P18Perc1 == P18Perc1.hombre) {PercP18 = "${PercP18}Hombre-A;";}
    if (_P18Perc1 == P18Perc1.mujer) {PercP18 = "${PercP18}Mujer-B;";}
    widget.formData?.p18percepcion1 = _P18Perc1?.index;
    widget.formDataBACKUP?.p18percepcion1 = _P18Perc1?.index;

    if (_P18Perc2 == P18Perc2.hombre) {PercP18 = "${PercP18}Hombre-A;";}
    if (_P18Perc2 == P18Perc2.mujer) {PercP18 = "${PercP18}Mujer-B;";}
    widget.formData?.p18percepcion2 = _P18Perc2?.index;
    widget.formDataBACKUP?.p18percepcion2 = _P18Perc2?.index;

    if (_P18Perc3 == P18Perc3.hombre) {PercP18 = "${PercP18}Hombre-A;";}
    if (_P18Perc3 == P18Perc3.mujer) {PercP18 = "${PercP18}Mujer-B;";}
    widget.formData?.p18percepcion3 = _P18Perc3?.index;
    widget.formDataBACKUP?.p18percepcion3 = _P18Perc3?.index;

    PercP19 = "${PercP19}${widget.P19EspecificarPerc1!.text};";
    widget.formData?.p19percepcion1 =widget.P19EspecificarPerc1!.text;
    widget.formDataBACKUP?.p19percepcion1 =widget.P19EspecificarPerc1!.text;

    PercP19 = "${PercP19}${widget.P19EspecificarPerc2!.text};";
    widget.formData?.p19percepcion2 =widget.P19EspecificarPerc2!.text;
    widget.formDataBACKUP?.p19percepcion2 =widget.P19EspecificarPerc2!.text;

    PercP19 = "${PercP19}${widget.P19EspecificarPerc3!.text};";
    widget.formData?.p19percepcion3 =widget.P19EspecificarPerc3!.text;
    widget.formDataBACKUP?.p19percepcion3 =widget.P19EspecificarPerc3!.text;

    if (_P20Perc == P20Perc.Si) {PercP20 = "${PercP20}Sí-A;";}
    if (_P20Perc == P20Perc.No) {PercP20 = "${PercP20}No-B;";}
    widget.formData?.p20percepcion = _P20Perc?.index;
    widget.formDataBACKUP?.p20percepcion = _P20Perc?.index;

    if (_P21Perc == P21Perc.omadep) {PercP21 = "${PercP21}Personal de la Municipalidad (OMAPED)-A;";}
    if (_P21Perc == P21Perc.familaires) {PercP21 = "${PercP21}Familiares / Vecinos / Amigos-B;";}
    if (_P21Perc == P21Perc.medios) {PercP21 = "${PercP21}Medios de comunicación (radio, televisión, perifoneo, etc.)-C;";}
    if (_P21Perc == P21Perc.personal) {PercP21 = "${PercP21}Personal del Programa CONTIGO -D;";}
    if (_P21Perc == P21Perc.yo) {PercP21 = "${PercP21}Yo mismo buscando en internet -E;";}
    if (_P21Perc == P21Perc.otro) {PercP21 = "${PercP21}Otro-F:${widget.P21EspecificarPerc!.text};";}
    widget.formData?.p21percepcion = _P21Perc?.index;
    widget.formDataBACKUP?.p21percepcion = _P21Perc?.index;
    widget.formData?.p21percepcionEspecificar =widget.P21EspecificarPerc!.text;
    widget.formDataBACKUP?.p21percepcionEspecificar =widget.P21EspecificarPerc!.text;

    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase3() async {

    if (_P22Perc == P22Perc.muybuena) {PercP22 = "${PercP22}Muy buena-A;";}
    if (_P22Perc == P22Perc.buena) {PercP22 = "${PercP22}Buena-B;";}
    if (_P22Perc == P22Perc.mala) {PercP22 = "${PercP22}Mala-C;";}
    if (_P22Perc == P22Perc.muymala) {PercP22 = "${PercP22}Muy mala-D;";}
    if (_P22Perc == P22Perc.nosabe) {PercP22 = "${PercP22}No sabe / No responde-E;";}
    widget.formData?.p22percepcion = _P22Perc?.index;
    widget.formDataBACKUP?.p22percepcion = _P22Perc?.index;

    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase4() async {
    //MODULO III parte 2



    if (_P23Perc == P23Perc.bastante) {PercP29 = "${PercP23}Bastante-A;";}
    if (_P23Perc == P23Perc.suficiente) {PercP29 = "${PercP23}Suficiente-B;";}
    if (_P23Perc == P23Perc.poco) {PercP29 = "${PercP23}Poco-C;";}
    if (_P23Perc == P23Perc.nada) {PercP29 = "${PercP23}Nada-D;";}
    if (_P23Perc == P23Perc.nosabe) {PercP29 = "${PercP23}No sabe / No responde-E;";}
    widget.formData?.p23percepcion = _P23Perc?.index;
    widget.formDataBACKUP?.p23percepcion = _P23Perc?.index;

    //30,31,32,33
    String PercP30Check="";
    if(isCheckedP30Opcion01){PercP30 = "${PercP30}A,";PercP30Check = "A,";}
    if(isCheckedP30Opcion02){PercP30 = "${PercP30}B,";PercP30Check = "B,";}
    if(isCheckedP30Opcion03){PercP30 = "${PercP30}C,";PercP30Check = "C,";}
    if(isCheckedP30Opcion04){PercP30 = "${PercP30}D,";PercP30Check = "D,";}
    if(isCheckedP30Opcion05){PercP30 = "${PercP30}E,";PercP30Check = "E,";}
    if(isCheckedP30Opcion06){PercP30 = "${PercP30}F,";PercP30Check = "F,";}
    if(isCheckedP30Opcion07){PercP30 = "${PercP30}G,";PercP30Check = "G,";}
    if(isCheckedP30Opcion08){PercP30 = "${PercP30}H,";PercP30Check = "H,";}
    if(isCheckedP30Opcion09){PercP30 = "${PercP30}I,";PercP30Check = "I,";}
    if(isCheckedP30Opcion10){PercP30 = "${PercP30}J,";PercP30Check = "J,";}
    if(isCheckedP30Opcion11){PercP30 = "${PercP30}K,";PercP30Check = "K,";}
    if(isCheckedP30Opcion12){PercP30 = "${PercP30}L,";PercP30Check = "L,";}
    if(isCheckedP30Opcion13){PercP30 = "${PercP30}M,";PercP30Check = "M,";}
    if(isCheckedP30Opcion14){PercP30 = "${PercP30}N,";PercP30Check = "N,";}
    PercP30 = "${PercP30};";
    widget.formData?.p30percepcion = PercP30Check;
    widget.formDataBACKUP?.p30percepcion = PercP30Check;

    if (_P31Perc01 == P31Perc01.cuidador) {PercP31 = "${PercP31}01-Cuidador,";}
    if (_P31Perc01 == P31Perc01.familiar) {PercP31 = "${PercP31}01-Familiar,";}
    if (_P31Perc02 == P31Perc02.cuidador) {PercP31 = "${PercP31}02-Cuidador,";}
    if (_P31Perc02 == P31Perc02.familiar) {PercP31 = "${PercP31}02-Familiar,";}
    if (_P31Perc03 == P31Perc03.cuidador) {PercP31 = "${PercP31}03-Cuidador,";}
    if (_P31Perc03 == P31Perc03.familiar) {PercP31 = "${PercP31}03-Familiar,";}
    if (_P31Perc04 == P31Perc04.cuidador) {PercP31 = "${PercP31}04-Cuidador,";}
    if (_P31Perc04 == P31Perc04.familiar) {PercP31 = "${PercP31}04-Familiar,";}
    if (_P31Perc05 == P31Perc05.cuidador) {PercP31 = "${PercP31}05-Cuidador,";}
    if (_P31Perc05 == P31Perc05.familiar) {PercP31 = "${PercP31}05-Familiar,";}
    if (_P31Perc06 == P31Perc06.cuidador) {PercP31 = "${PercP31}06-Cuidador,";}
    if (_P31Perc06 == P31Perc06.familiar) {PercP31 = "${PercP31}06-Familiar,";}
    if (_P31Perc07 == P31Perc07.cuidador) {PercP31 = "${PercP31}07-Cuidador,";}
    if (_P31Perc07 == P31Perc07.familiar) {PercP31 = "${PercP31}07-Familiar,";}
    if (_P31Perc08 == P31Perc08.cuidador) {PercP31 = "${PercP31}08-Cuidador,";}
    if (_P31Perc08 == P31Perc08.familiar) {PercP31 = "${PercP31}08-Familiar,";}
    if (_P31Perc09 == P31Perc09.cuidador) {PercP31 = "${PercP31}09-Cuidador,";}
    if (_P31Perc09 == P31Perc09.familiar) {PercP31 = "${PercP31}09-Familiar,";}
    if (_P31Perc10 == P31Perc10.cuidador) {PercP31 = "${PercP31}10-Cuidador,";}
    if (_P31Perc10 == P31Perc10.familiar) {PercP31 = "${PercP31}10-Familiar,";}
    if (_P31Perc11 == P31Perc11.cuidador) {PercP31 = "${PercP31}11-Cuidador,";}
    if (_P31Perc11 == P31Perc11.familiar) {PercP31 = "${PercP31}11-Familiar,";}
    if (_P31Perc12 == P31Perc12.cuidador) {PercP31 = "${PercP31}12-Cuidador,";}
    if (_P31Perc12 == P31Perc12.familiar) {PercP31 = "${PercP31}12-Familiar,";}
    if (_P31Perc13 == P31Perc13.cuidador) {PercP31 = "${PercP31}13-Cuidador,";}
    if (_P31Perc13 == P31Perc13.familiar) {PercP31 = "${PercP31}13-Familiar,";}
    if (_P31Perc14 == P31Perc14.cuidador) {PercP31 = "${PercP31}14-Cuidador,";}
    if (_P31Perc14 == P31Perc14.familiar) {PercP31 = "${PercP31}14-Familiar,";}
    //31?

    if (_P34Perc == P34Perc.muysatisfecho) {PercP34 = "${PercP34}Muy satisfecho/a-A;";}
    if (_P34Perc == P34Perc.satisfecho) {PercP34 = "${PercP34}Satisfecho/a-B;";}
    if (_P34Perc == P34Perc.insatisfecho) {PercP34 = "${PercP34}Insatisfecho/a-C;";}
    if (_P34Perc == P34Perc.muyinsatisfecho) {PercP34 = "${PercP34}Muy insatisfecho/a-D;";}
    if (_P34Perc == P34Perc.nosabe) {PercP34 = "${PercP34}No sabe/No responde-E;";}
    widget.formData?.p34percepcion = _P34Perc?.index;
    widget.formDataBACKUP?.p34percepcion = _P34Perc?.index;

    if (_P35Perc == P35Perc.nunca) {PercP35 = "${PercP35}Nunca-A;";}
    if (_P35Perc == P35Perc.algunavez) {PercP35 = "${PercP35}Alguna vez-B;";}
    if (_P35Perc == P35Perc.frecuente) {PercP35 = "${PercP35}Frecuentemente-C;";}
    if (_P35Perc == P35Perc.siempre) {PercP35 = "${PercP35}Siempre-D;";}
    widget.formData?.p35percepcion = _P35Perc?.index;
    widget.formDataBACKUP?.p35percepcion = _P35Perc?.index;

    if (_P36Perc == P36Perc.nunca) {PercP36 = "${PercP36}Nunca-A;";}
    if (_P36Perc == P36Perc.algunavez) {PercP36 = "${PercP36}Alguna vez-B;";}
    if (_P36Perc == P36Perc.frecuente) {PercP36 = "${PercP36}Frecuentemente-C;";}
    if (_P36Perc == P36Perc.siempre) {PercP36 = "${PercP36}Siempre-D;";}
    widget.formData?.p36percepcion = _P36Perc?.index;
    widget.formDataBACKUP?.p36percepcion = _P36Perc?.index;

    if (_P37Perc == P37Perc.nunca) {PercP37 = "${PercP37}Nunca-A;";}
    if (_P37Perc == P37Perc.algunavez) {PercP37 = "${PercP37}Alguna vez-B;";}
    if (_P37Perc == P37Perc.frecuente) {PercP37 = "${PercP37}Frecuentementeente-C;";}
    if (_P37Perc == P37Perc.siempre) {PercP37 = "${PercP37}Siempre-D;";}
    widget.formData?.p37percepcion = _P37Perc?.index;
    widget.formDataBACKUP?.p37percepcion = _P37Perc?.index;

    if (_P38Perc == P38Perc.nunca) {PercP38 = "${PercP38}Nunca-A;";}
    if (_P38Perc == P38Perc.algunavez) {PercP38 = "${PercP38}Alguna vez-B;";}
    if (_P38Perc == P38Perc.frecuente) {PercP38 = "${PercP38}Frecuentementente-C;";}
    if (_P38Perc == P38Perc.siempre) {PercP38 = "${PercP38}Siempre-D;";}
    widget.formData?.p38percepcion = _P38Perc?.index;
    widget.formDataBACKUP?.p38percepcion = _P38Perc?.index;

    if (_P39Perc == P39Perc.nunca) {PercP39 = "${PercP39}Nunca-A;";}
    if (_P39Perc == P39Perc.algunavez) {PercP39 = "${PercP39}Alguna vez-B;";}
    if (_P39Perc == P39Perc.frecuente) {PercP39 = "${PercP39}Frecuentementente-C;";}
    if (_P39Perc == P39Perc.siempre) {PercP39 = "${PercP39}Siempre-D;";}
    widget.formData?.p39percepcion = _P39Perc?.index;
    widget.formDataBACKUP?.p39percepcion = _P39Perc?.index;

    if (_P40Perc == P40Perc.muysatisfecho) {PercP40 = "${PercP40}Nunca-A;";}
    if (_P40Perc == P40Perc.satisfecho) {PercP40 = "${PercP40}Alguna vez-B;";}
    if (_P40Perc == P40Perc.insatisfecho) {PercP40 = "${PercP40}Frecuentemente-C;";}
    if (_P40Perc == P40Perc.muyinsatisfecho) {PercP40 = "${PercP40}Siempre-D;";}
    if (_P40Perc == P40Perc.nosabe) {PercP40 = "${PercP40}Siempre-E;";}
    widget.formData?.p40percepcion = _P40Perc?.index;
    widget.formDataBACKUP?.p40percepcion = _P40Perc?.index;

    if (_P41Perc == P41Perc.sigueigual) {PercP41 = "${PercP41}Sigue igual-A;";}
    if (_P41Perc == P41Perc.hamejorado) {PercP41 = "${PercP41}Ha mejorado-B;";}
    if (_P41Perc == P41Perc.haempeorado) {PercP41 = "${PercP41}Ha empeorado-C;";}
    if (_P41Perc == P41Perc.nosabe) {PercP41 = "${PercP41}No sabe/ No responde-D;";}
    widget.formData?.p41percepcion = _P41Perc?.index;
    widget.formDataBACKUP?.p41percepcion = _P41Perc?.index;

    //42
    String PercP42Check="";
    if (P42Perc03Salud) {PercP42 = "${PercP42}tres-A,";           PercP42Check = "${PercP42Check}A3,";}
    else if (P42Perc02Salud) {PercP42 = "${PercP42}dos-A,";       PercP42Check = "${PercP42Check}A2,";}
    else if (P42Perc01Salud) {PercP42 = "${PercP42}uno-A,";       PercP42Check = "${PercP42Check}A1,";}
    if (P42Perc03SaludF) {PercP42 = "${PercP42}tres-B,";          PercP42Check = "${PercP42Check}B3,";}
    else if (P42Perc02SaludF) {PercP42 = "${PercP42}dos-B,";      PercP42Check = "${PercP42Check}B2,";}
    else if (P42Perc01SaludF) {PercP42 = "${PercP42}uno-B,";      PercP42Check = "${PercP42Check}B1,";}
    if (P42Perc03Dinero) {PercP42 = "${PercP42}tres-C,";          PercP42Check = "${PercP42Check}C3,";}
    else if (P42Perc02Dinero) {PercP42 = "${PercP42}dos-C,";      PercP42Check = "${PercP42Check}C2,";}
    else if (P42Perc01Dinero) {PercP42 = "${PercP42}uno-C,";      PercP42Check = "${PercP42Check}C1,";}
    if (P42Perc03ProblemasF) {PercP42 = "${PercP42}tres-D,";      PercP42Check = "${PercP42Check}D3,";}
    else if (P42Perc02ProblemasF) {PercP42 = "${PercP42}dos-D,";  PercP42Check = "${PercP42Check}D2,";}
    else if (P42Perc01ProblemasF) {PercP42 = "${PercP42}uno-D,";  PercP42Check = "${PercP42Check}D1,";}
    if (P42Perc03Falta) {PercP42 = "${PercP42}tres-E,";           PercP42Check = "${PercP42Check}E3,";}
    else if (P42Perc02Falta) {PercP42 = "${PercP42}dos-E,";       PercP42Check = "${PercP42Check}E2,";}
    else if (P42Perc01Falta) {PercP42 = "${PercP42}uno-E,";       PercP42Check = "${PercP42Check}E1,";}
    if (P42Perc03ProblemasV) {PercP42 = "${PercP42}tres-F,";      PercP42Check = "${PercP42Check}F3,";}
  else if (P42Perc02ProblemasV) {PercP42 = "${PercP42}dos-F,";    PercP42Check = "${PercP42Check}F2,";}
  else if (P42Perc01ProblemasV) {PercP42 = "${PercP42}uno-F,";    PercP42Check = "${PercP42Check}F1,";}
    if (P42Perc03Estudio) {PercP42 = "${PercP42}tres-G,";         PercP42Check = "${PercP42Check}G3,";}
    else if (P42Perc02Estudio) {PercP42 = "${PercP42}dos-G,";     PercP42Check = "${PercP42Check}G2,";}
    else if (P42Perc01Estudio) {PercP42 = "${PercP42}uno-G,";     PercP42Check = "${PercP42Check}G1,";}
    if (P42Perc03Otro) {PercP42 = "${PercP42}tres-H,";            PercP42Check = "${PercP42Check}H3,";}
    else if (P42Perc02Otro) {PercP42 = "${PercP42}dos-H,";        PercP42Check = "${PercP42Check}H2,";}
    else if (P42Perc01Otro) {PercP42 = "${PercP42}uno-H,";        PercP42Check = "${PercP42Check}H1,";}
    if (P42Perc03SinPreocupaciones) {PercP42 = "${PercP42}I,";    PercP42Check = "${PercP42Check}I,";}
    PercP42 = "${PercP42};";
    widget.formData?.p42percepcion = PercP42Check;
    widget.formDataBACKUP?.p42percepcion = PercP42Check;
    widget.formData?.p42percepcionEspecificar =widget.P42EspecificarPerc!.text;
    widget.formDataBACKUP?.p42percepcionEspecificar =widget.P42EspecificarPerc!.text;


    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase5() async {
    //P15 - P18
    if (_P43Perc == P43Perc.Si) {PercP43 = "${PercP43}Sí-A;";}
    if (_P43Perc == P43Perc.No) {PercP43 = "${PercP43}No-B;";}
    widget.formData?.p43percepcion = _P43Perc?.index;
    widget.formDataBACKUP?.p43percepcion = _P43Perc?.index;

    if (_P44Perc == P44Perc.omadep) {PercP44 = "${PercP44}OMAPED-A;";}
    if (_P44Perc == P44Perc.familaires) {PercP44 = "${PercP44}Familiares / Vecinos / Amigos-B;";}
    if (_P44Perc == P44Perc.medios) {PercP44 = "${PercP44}Medios de comunicación (radio, televisión, perifoneo, etc.)-C;";}
    if (_P44Perc == P44Perc.personal) {PercP44 = "${PercP44}Personal del Programa CONTIGO-D;";}
    if (_P44Perc == P44Perc.banco) {PercP44 = "${PercP44}Banco de la Nación-E;";}
    if (_P44Perc == P44Perc.yo) {PercP44 = "${PercP44}Yo mismo buscando en internet-F;";}
    if (_P44Perc == P44Perc.otro) {PercP44 = "${PercP44}Otro-G:${widget.P44EspecificarPerc!.text};";}
    widget.formData?.p44percepcion = _P44Perc?.index;
    widget.formDataBACKUP?.p44percepcion = _P44Perc?.index;
    widget.formData?.p44percepcionEspecificar =widget.P44EspecificarPerc!.text;
    widget.formDataBACKUP?.p44percepcionEspecificar =widget.P44EspecificarPerc!.text;

    if (_P45Perc == P45Perc.dosmeses) {PercP45 = "${PercP45}Hace 2 meses o menos-A;";}
    if (_P45Perc == P45Perc.masdosmeses) {PercP45 = "${PercP45}Hace más de 2 a 6 meses-B;";}
    if (_P45Perc == P45Perc.seismeses) {PercP45 = "${PercP45}Hace 6 meses o más-C;";}
    if (_P45Perc == P45Perc.nosabe) {PercP45 = "${PercP45}No sabe / No responde-D;";}
    if (_P45Perc == P45Perc.otro) {PercP45 = "${PercP45}Otro-E:${widget.P45EspecificarPerc!.text};";}
    widget.formData?.p45percepcion = _P45Perc?.index;
    widget.formDataBACKUP?.p45percepcion = _P45Perc?.index;
    widget.formData?.p44percepcionEspecificar =widget.P45EspecificarPerc!.text;
    widget.formDataBACKUP?.p44percepcionEspecificar =widget.P45EspecificarPerc!.text;

    if (_P46Perc == P46Perc.nosabiausuario) {PercP46 = "${PercP46}No sabía que era usuario del Programa-A;";}
    if (_P46Perc == P46Perc.nosabiafecha)   {PercP46 = "${PercP46}No sabía de la fecha de pago-B;";}
    if (_P46Perc == P46Perc.enfermo)        {PercP46 = "${PercP46}Estuve enfermo-C;";}
    if (_P46Perc == P46Perc.guarde)         {PercP46 = "${PercP46}Guardé/junte pensiones para luego hacer el cobro-D;";}
    if (_P46Perc == P46Perc.movilidad)      {PercP46 = "${PercP46}Por la falta de movilidad-E;";}
    if (_P46Perc == P46Perc.nosabe)         {PercP46 = "${PercP46}No sabe / No responde -F;";}
    if (_P46Perc == P46Perc.otro)           {PercP46 = "${PercP46}Otro-G:${widget.P46EspecificarPerc!.text};";}
    widget.formData?.p46percepcion = _P46Perc?.index;
    widget.formDataBACKUP?.p46percepcion = _P46Perc?.index;
    widget.formData?.p46percepcionEspecificar =widget.P46EspecificarPerc!.text;
    widget.formDataBACKUP?.p46percepcionEspecificar =widget.P46EspecificarPerc!.text;

    if (_P47Perc == P47Perc.independiente)  {PercP47 = "${PercP47}Yo, de manera independiente-A;";}
    if (_P47Perc == P47Perc.cuidador)       {PercP47 = "${PercP47}Yo, acompañado de cuidador-B;";}
    if (_P47Perc == P47Perc.familiar)       {PercP47 = "${PercP47}Yo, acompañado de familiar-C;";}
    if (_P47Perc == P47Perc.municipalidad)  {PercP47 = "${PercP47}Yo, con apoyo del personal de la Municipalidad-D;";}
    if (_P47Perc == P47Perc.cobro)          {PercP47 = "${PercP47}Persona autorizada para el cobro-E;";}
    widget.formData?.p47percepcion = _P47Perc?.index;
    widget.formDataBACKUP?.p47percepcion = _P47Perc?.index;

    if (_P48Perc == P48Perc.mediahora)  {PercP48 = "${PercP48}Media hora o menos-A;";}
    if (_P48Perc == P48Perc.masmediahora)       {PercP48 = "${PercP48}Más de media hora, pero menos de 1 hora-B;";}
    if (_P48Perc == P48Perc.unoadoshoras)       {PercP48 = "${PercP48}De 1 a 2 horas-C;";}
    if (_P48Perc == P48Perc.masdoshoras)  {PercP48 = "${PercP48}Más de 2 horas-D;";}
    widget.formData?.p48percepcion = _P48Perc?.index;
    widget.formDataBACKUP?.p48percepcion = _P48Perc?.index;

    if (_P49Perc == P49Perc.apie) {PercP49 = "${PercP49}A pie-A;";}
    if (_P49Perc == P49Perc.bicicletas)   {PercP49 = "${PercP49}Bicicleta-B;";}
    if (_P49Perc == P49Perc.caballo)        {PercP49 = "${PercP49}Caballo / Acémila-C;";}
    if (_P49Perc == P49Perc.mototaxi)         {PercP49 = "${PercP49}Mototaxi-D;";}
    if (_P49Perc == P49Perc.motocicleta)      {PercP49 = "${PercP49}Motocicleta-E;";}
    if (_P49Perc == P49Perc.automovil)         {PercP49 = "${PercP49}Automóvil / Camioneta-F;";}
    if (_P49Perc == P49Perc.taxi)         {PercP49 = "${PercP49}Taxi-G;";}
    if (_P49Perc == P49Perc.colectivo)         {PercP49 = "${PercP49}Colectivo/Microbús/Coaster-H;";}
    if (_P49Perc == P49Perc.camion)         {PercP49 = "${PercP49}Camión-I;";}
    if (_P49Perc == P49Perc.otro)           {PercP49 = "${PercP49}Otro-J:${widget.P49EspecificarPerc!.text};";}
    widget.formData?.p49percepcion = _P49Perc?.index;
    widget.formDataBACKUP?.p49percepcion = _P49Perc?.index;
    widget.formData?.p49percepcionEspecificar =widget.P49EspecificarPerc!.text;
    widget.formDataBACKUP?.p49percepcionEspecificar =widget.P49EspecificarPerc!.text;

    PercP50 = "${PercP50}${widget.P50EspecificarPerc!.text};";
    widget.formData?.p50percepcion =widget.P50EspecificarPerc!.text;
    widget.formDataBACKUP?.p50percepcion =widget.P50EspecificarPerc!.text;

    if (_P51Perc == P51Perc.banco)    {PercP51 = "${PercP51}Cobro por ventanilla del Banco de la Nación-A;";}
    if (_P51Perc == P51Perc.debito) {PercP51 = "${PercP51}Cobro con tarjeta de débito (cobro por cajero)-B;";}
    if (_P51Perc == P51Perc.agente) {PercP51 = "${PercP51}Cobro por agente-C;";}
    if (_P51Perc == P51Perc.pagador)  {PercP51 = "${PercP51}Carrito pagador-D;";}
    if (_P51Perc == P51Perc.pias)  {PercP51 = "${PercP51}Plataformas itinerantes de acción social (PIAS)-E;";}
    widget.formData?.p51percepcion = _P51Perc?.index;
    widget.formDataBACKUP?.p51percepcion = _P51Perc?.index;

    String p52check = ""; //POR EL ESPECIFICA
    if (P52Perc01)     {PercP52 = "${PercP52}A,"; p52check ="${p52check}A";}
    if (P52Perc02)     {PercP52 = "${PercP52}B,"; p52check ="${p52check}B";}
    if (P52Perc03)     {PercP52 = "${PercP52}C,"; p52check ="${p52check}C";}
    if (P52Perc04)     {PercP52 = "${PercP52}D,"; p52check ="${p52check}D";}
    if (P52Perc05)     {PercP52 = "${PercP52}E,"; p52check ="${p52check}E";}
    if (P52Perc06)     {PercP52 = "${PercP52}F,"; p52check ="${p52check}F";}
    if (P52Perc07)     {PercP52 = "${PercP52}G,"; p52check ="${p52check}G";}
    if (P52Perc08)     {PercP52 = "${PercP52}H,"; p52check ="${p52check}H";}
    if (P52Perc09)     {PercP52 = "${PercP52}I,"; p52check ="${p52check}I";}
    if (P52Perc10)     {PercP52 = "${PercP52}J,"; p52check ="${p52check}J";}
    if (P52Perc11)     {PercP52 = "${PercP52}K,"; p52check ="${p52check}K";}
    if (P52Perc12)     {PercP52 = "${PercP52}L:${widget.P52EspecificarPerc!.text}";p52check ="${p52check}L";}
    PercP52 = "${PercP52};";
    widget.formData?.p52percepcion = p52check;
    widget.formDataBACKUP?.p52percepcion = p52check;
    widget.formData?.p52percepcionEspecificar =widget.P52EspecificarPerc!.text;
    widget.formDataBACKUP?.p52percepcionEspecificar =widget.P52EspecificarPerc!.text;

    if (_P53Perc == P53Perc.Si) {PercP53 = "${PercP53}Sí-A;";}
    if (_P53Perc == P53Perc.No) {PercP53 = "${PercP53}No-B;";}
    widget.formData?.p53percepcion = _P53Perc?.index;
    widget.formDataBACKUP?.p53percepcion = _P53Perc?.index;

    String PercP54Check="";
    if      (P54Perc03Distancia) {PercP54 = "${PercP54}tres-A,";  PercP54Check = "${PercP54Check}A3,";}
    else if (P54Perc02Distancia) {PercP54 = "${PercP54}dos-A,";   PercP54Check = "${PercP54Check}A2,";}
    else if (P54Perc01Distancia) {PercP54 = "${PercP54}uno-A,";   PercP54Check = "${PercP54Check}A1,";}
    if      (P54Perc03Fisico) {PercP54 = "${PercP54}tres-B,";     PercP54Check = "${PercP54Check}B3,";}
    else if (P54Perc02Fisico) {PercP54 = "${PercP54}dos-B,";      PercP54Check = "${PercP54Check}B2,";}
    else if (P54Perc01Fisico) {PercP54 = "${PercP54}uno-B,";      PercP54Check = "${PercP54Check}B1,";}
    if      (P54Perc03Ausencia) {PercP54 = "${PercP54}tres-C,";   PercP54Check = "${PercP54Check}C3,";}
    else if (P54Perc02Ausencia) {PercP54 = "${PercP54}dos-C,";    PercP54Check = "${PercP54Check}C2,";}
    else if (P54Perc01Ausencia) {PercP54 = "${PercP54}uno-C,";    PercP54Check = "${PercP54Check}C1,";}
    if      (P54Perc03Requiere) {PercP54 = "${PercP54}tres-D,";   PercP54Check = "${PercP54Check}D3,";}
    else if (P54Perc02Requiere) {PercP54 = "${PercP54}dos-D,";    PercP54Check = "${PercP54Check}D2,";}
    else if (P54Perc01Requiere) {PercP54 = "${PercP54}uno-D,";    PercP54Check = "${PercP54Check}D1,";}
    if      (P54Perc03Clima) {PercP54 = "${PercP54}tres-E,";      PercP54Check = "${PercP54Check}E3,";}
    else if (P54Perc02Clima) {PercP54 = "${PercP54}dos-E,";       PercP54Check = "${PercP54Check}E2,";}
    else if (P54Perc01Clima) {PercP54 = "${PercP54}uno-E,";       PercP54Check = "${PercP54Check}E1,";}
    if      (P54Perc03Terreno) {PercP54 = "${PercP54}tres-F,";    PercP54Check = "${PercP54Check}F3,";}
    else if (P54Perc02Terreno) {PercP54 = "${PercP54}dos-F,";     PercP54Check = "${PercP54Check}F2,";}
    else if (P54Perc01Terreno) {PercP54 = "${PercP54}uno-F,";     PercP54Check = "${PercP54Check}F1,";}
    if      (P54Perc03Otro) {PercP54 = "${PercP54}tres-G,";       PercP54Check = "${PercP54Check}G3,";}
    else if (P54Perc02Otro) {PercP54 = "${PercP54}dos-G,";        PercP54Check = "${PercP54Check}G2,";}
    else if (P54Perc01Otro) {PercP54 = "${PercP54}uno-G,";        PercP54Check = "${PercP54Check}G1,";}



    PercP54="${PercP54};";
    widget.formData?.p54percepcion = PercP54Check;
    widget.formDataBACKUP?.p54percepcion = PercP54Check;
    widget.formData?.p54percepcionEspecificar =widget.P54EspecificarPerc!.text;
    widget.formDataBACKUP?.p54percepcionEspecificar =widget.P54EspecificarPerc!.text;


    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase6() async {
    //P55 - P57
    if (_P55Perc == P55Perc.Si) {PercP55 = "${PercP55}Sí-A;";}
    if (_P55Perc == P55Perc.No) {PercP55 = "${PercP55}No-B;";}
    widget.formData?.p55percepcion = _P55Perc?.index;
    widget.formDataBACKUP?.p55percepcion = _P55Perc?.index;

    if (_P56Perc == P56Perc.cuidador) {PercP56 = "${PercP56}Cuidador/a-A;";}
    if (_P56Perc == P56Perc.autorizada) {PercP56 = "${PercP56}Persona autorizada-B;";}
    widget.formData?.p56percepcion = _P56Perc?.index;
    widget.formDataBACKUP?.p56percepcion = _P56Perc?.index;

    if (_P57Perc == P57Perc.salud) {PercP57 = "${PercP57}Salud/Medicina-A;";}
    if (_P57Perc == P57Perc.ayuda) {PercP57 = "${PercP57}Ayudas técnicas-B;";}
    if (_P57Perc == P57Perc.alimentacion) {PercP57 = "${PercP57}Alimentación-C;";}
    if (_P57Perc == P57Perc.vestimenta) {PercP57 = "${PercP57}Vestimenta o ropa-D;";}
    if (_P57Perc == P57Perc.transporte) {PercP57 = "${PercP57}Transporte-E;";}
    if (_P57Perc == P57Perc.invierte) {PercP57 = "${PercP57}Invierte/Activos-F;";}
    if (_P57Perc == P57Perc.mejora) {PercP57 = "${PercP57}Mejora Vivienda-G;";}
    if (_P57Perc == P57Perc.ahorra) {PercP57 = "${PercP57}Ahorro-H;";}
    if (_P57Perc == P57Perc.pago) {PercP57 = "${PercP57}Pago de Servicios-I;";}
    if (_P57Perc == P57Perc.nosabe) {PercP57 = "${PercP57}No Sabe-J;";}
    if (_P57Perc == P57Perc.otro) {PercP57 = "${PercP57}Otro-K:${widget.P57EspecificarPerc!.text};";}
    widget.formData?.p57percepcion = _P57Perc?.index;
    widget.formDataBACKUP?.p57percepcion = _P57Perc?.index;
    widget.formData?.p57percepcionEspecificar =widget.P57EspecificarPerc!.text;
    widget.formDataBACKUP?.p57percepcionEspecificar =widget.P57EspecificarPerc!.text;

    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);

  }

  void PedirPermiso() {
    showDialog(
        context: context,
        builder: (context) {
          //AGREGAR ESTO POR SI QUIERO QUE EL DIALOG SE REFRESQUE
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [

                      HelpersViewAlertMensajeTitulo.formItemsDesign(
                          "Se recogerá sus coordenadas actuales"),

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
  final _mostrarLoadingStreamControllerPuntaje = StreamController<
      int>.broadcast();



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
                        alignment: MainAxisAlignment.start,
                        // Alinea los botones a la izquierda
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Cierra el diálogo
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    MenudeOpcionesListado()),
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
              if (GPSlongitude != "") {
                if (!Fase7) {
                  HelpersViewAlertMensajeFaltaMSG.formItemsDesign(
                      "Faltan llenar campos", context);
                } else {
                  CargaDialog(); //INICIALIZA DIALOGO

                  String respuestas = "";


                  respuestas = ''
                      'Respuestas:'
                      '$PercP01$PercP02$PercP03$PercP04$PercP05'
                      '$PercP06$PercP07$PercP08$PercP09$PercP10'
                      '$PercP11$PercP12$PercP13$PercP14$PercP15'
                      '$PercP16$PercP17$PercP18$PercP19$PercP20'
                      '$PercP21$PercP22$PercP23$PercP24$PercP25'
                      '$PercP26$PercP27$PercP28$PercP29$PercP30'
                      '$PercP31$PercP32$PercP33$PercP34$PercP35'
                      '$PercP36$PercP37$PercP38$PercP39$PercP40'
                      '$PercP41$PercP42$PercP43$PercP44$PercP45'
                      '$PercP46$PercP47$PercP48$PercP49$PercP50'
                      '$PercP51$PercP52$PercP53$PercP54$PercP55'
                      '$PercP56$PercP57'
                      '- Nombre:$PREFname,'
                      '- Appaterno:$PREFapPaterno,'
                      '- MatMaterno:$PREFapMaterno,'
                      '- DNI:$PREFnroDoc,'
                      '- TipoUsuario:$PREFtypeUser,'
                  ;

                  //RELLENANDO

                  widget.formData?.idformato = apisResources.api_idFormato;
                  widget.formData?.id_gestor = int.parse(PREFnroDoc!);
                  widget.formData?.fecha = formatDate("dd/MM/yyyy", DateTime.now());
                  widget.formData?.fecha_hora_fin = formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());
                  widget.formData?.fecha_hora_inicio = horaFechaInicio;
                  widget.formData?.respuestas = respuestas;
                  widget.formData?.puntaje = puntaje;
                  widget.formData?.longitud = GPSlongitude;
                  widget.formData?.latitud = GPSlatitude;
                  widget.formData?.id_usuario = widget.formIdUsuario.text;
                  //widget.formData?.tipoencuesta = Resources.valor_percepciones;

                  //GPSlatitude

                  //FUNCION PARA SINCRONIZAR
                  //insertarEncuestaRSPTA rpta = await widget.apiForm.post_EnviarRspt(widget.formData!, PREFtoken);

                  //await GuardarFormulario();

                  await widget.formDataModelDaoBackup.BorrarTodo();

                  await widget.formDataModelDao.insertFormDataModel(
                      widget.formData!);

                  cleanForm();
                  _mostrarLoadingStreamController.add(true);
                  _mostrarLoadingStreamControllerPuntaje.add(puntaje);
                }
              } else {
                HelpersViewAlertMensajeFaltaMSG.formItemsDesign(
                    "Falta activar el GPS o dar permisos de ubicación y de teléfono para el correcto funcionamiento del APP",
                    context);
              }
            },
          ),

          IconButton(
            icon: Image.asset(
              isSatelliteGreen ? Resources.sateliteverde : Resources
                  .sateliterojo,
              // Usa la imagen verde si isSatelliteGreen es verdadero, de lo contrario, usa la imagen roja
            ),
            color: Colors.white,
            onPressed: () {
              if (!isSatelliteGreen) {
                PedirPermiso();
              } else {
                HelpersViewCabecera.CoordenadasGPS(context).then((value) async {
                  // Luego de recopilar la ubicación y la fecha, actualiza el estado del icono
                  SharedPreferences prefs = await SharedPreferences
                      .getInstance();
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
      body: Stack(
        children: [
          // Background element (replace with your preference)
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              Resources.backgroundAzul, // Replace with your image path
              fit: BoxFit.cover, // Adjust fit as needed
            ),
          ),

          // Existing content with Center, SingleChildScrollView, and Container
          Center(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(41.0),
                child: Form(
                  //key: widget.keyForm,
                  child: formUI(scrollController),
                ),
              ),
            ),
          ),
        ],
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

  Future<void> BorrarFoto(int index) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      HelpersViewAlertMensajeFOTO.formItemsDesign(
                          "¿En verdad desea borrar esta foto?", "Borrar Foto"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // Align row to the end
                        children: [
                          Spacer(), // Push remaining space to the left
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

                          InkWell(
                            onTap: () {
                              if (widget.listMediaPath![index].isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                        Text("No hay fotos para eliminar")));
                              } else {
                                if (widget.formData!.fotoUno ==
                                    widget.listMediaPath![index]) {
                                  widget.formData!.fotoUno = "";
                                } else if (widget.formData!.fotoDos ==
                                    widget.listMediaPath![index]) {
                                  widget.formData!.fotoDos = "";
                                } else if (widget.formData!.fotoTres ==
                                    widget.listMediaPath![index]) {
                                  widget.formData!.fotoTres = "";
                                } else if (widget.formData!.fotoCuatro ==
                                    widget.listMediaPath![index]) {
                                  widget.formData!.fotoCuatro = "";
                                }
                                setState(() {});
                                Navigator.of(context).pop();
                              }
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
                        ],
                      ),
                    ],
                  )));
        });
  }

  static String formatDate(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime).toString();
  }

  void cleanForm() {
    //SIGUIENTE
    TextEditingController formIdUsuario = TextEditingController();
    TextEditingController formNombreUsuario = TextEditingController();


    //MODULO 1 (FASE 2)
    widget.P01EspecificarPerc!.clear();
    widget.P02EspecificarPerc!.clear();
    widget.P03EspecificarPerc!.clear();
    widget.P04EspecificarPerc!.clear();
    widget.P06EspecificarPerc!.clear();
    widget.P07EspecificarPerc!.clear();
    widget.P08EspecificarPerc!.clear();
    widget.P11EspecificarPerc!.clear();
    widget.P16EspecificarPerc1!.clear();
    widget.P16EspecificarPerc2!.clear();
    widget.P16EspecificarPerc3!.clear();
    widget.P19EspecificarPerc1!.clear();
    widget.P19EspecificarPerc2!.clear();
    widget.P19EspecificarPerc3!.clear();
    widget.P50EspecificarPerc!.clear();
    widget.P16EspecificarPerc1!.clear();
    widget.P16EspecificarPerc2!.clear();
    widget.P16EspecificarPerc3!.clear();
    widget.P21EspecificarPerc!.clear();
    widget.P23EspecificarPerc!.clear();
    widget.P44EspecificarPerc!.clear();
    widget.P45EspecificarPerc!.clear();
    widget.P46EspecificarPerc!.clear();
    widget.P49EspecificarPerc!.clear();
    widget.P52EspecificarPerc!.clear();
    widget.P57EspecificarPerc!.clear();
    widget.P42EspecificarPerc!.clear();
    widget.P54EspecificarPerc!.clear();
    widget.formIdUsuario!.clear();
    widget.formNombreUsuario!.clear();


    widget.formData = RespuestaPrimeraVisita(); ////


    setState(() {

      _P31Perc01 = null;
      P16Perc03Opcion01 = false;
      P16Perc02Opcion01 = false;
      P16Perc01Opcion01 = false;
      _P31Perc02 = null;
      P33Perc03Opcion02 = false;
      P33Perc02Opcion02 = false;
      P33Perc01Opcion02 = false;
      _P31Perc03 = null;
      P33Perc03Opcion03 = false;
      P33Perc02Opcion03 = false;
      P33Perc01Opcion03 = false;
      _P31Perc04 = null;


      Fase1 = true;
      Fase2 = false;
      Fase3 = false;
      Fase4 = false;
      Fase5 = false;
      Fase6 = false;
      Fase7 = false;
      //
      P52Perc01 = false;
      P52Perc02 = false;
      P52Perc03 = false;
      P52Perc04 = false;
      P52Perc05 = false;
      P52Perc06 = false;
      P52Perc07 = false;
      P52Perc08 = false;
      P52Perc09 = false;
      P52Perc10 = false;
      P52Perc11 = false;
      P52Perc12 = false;

      _P05Perc = null;
      _P09Perc = null;
      _P10Perc = null;
      _P11Perc = null;
      _P12Perc = null;
      _P14Perc = null;
      _P15Perc = null;
      _P16Perc1 = null;
      _P16Perc2 = null;
      _P16Perc3 = null;
      _P17Perc1 = null;
      _P17Perc2 = null;
      _P17Perc3 = null;
      _P18Perc1 = null;
      _P18Perc2 = null;
      _P18Perc3 = null;
      _P20Perc = null;
      _P21Perc = null;
      _P22Perc = null;
      _P23Perc = null;
      _P24Perc = null;
      _P25Perc = null;
      _P26Perc = null;
      _P27Perc = null;
      //_P28Perc = null;
      //_P29Perc = null;
      _P34Perc = null;
      _P35Perc = null;
      _P36Perc = null;
      _P37Perc = null;
      _P38Perc = null;
      _P39Perc = null;
      _P40Perc = null;
      _P41Perc = null;
      _P43Perc = null;
      _P44Perc = null;
      _P45Perc = null;
      _P46Perc = null;
      _P47Perc = null;
      _P48Perc = null;
      _P49Perc = null;
      _P51Perc = null;
      _P53Perc = null;
      _P55Perc = null;
      _P56Perc = null;
      _P57Perc = null;
    });
  }

  void NoEncontradoDNI(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      HelpersViewAlertMensajeFOTO.formItemsDesign(
                          "No existe un padron con el DNI ingresado",
                          "DNI no encontrado"),
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

    widget.listMediaPath!.clear();

    widget.listMediaPath!.add("");
    widget.listMediaPath!.add("");
    widget.listMediaPath!.add("");
    widget.listMediaPath!.add("");

    if (widget.formData!.fotoUno != null &&
        widget.formData!.fotoUno!.isNotEmpty) {
      widget.listMediaPath[0] = widget.formData!.fotoUno!;
    }
    if (widget.formData!.fotoDos != null &&
        widget.formData!.fotoDos!.isNotEmpty) {
      widget.listMediaPath[1] = widget.formData!.fotoDos!;
    }
    if (widget.formData!.fotoTres != null &&
        widget.formData!.fotoTres!.isNotEmpty) {
      widget.listMediaPath[2] = widget.formData!.fotoTres!;
    }
    if (widget.formData!.fotoCuatro != null &&
        widget.formData!.fotoCuatro!.isNotEmpty) {
      widget.listMediaPath[3] = widget.formData!.fotoCuatro!;
    }

    return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
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
        HelpersViewLetrasSubs.formItemsDesignGris( "Hora Inicio: ${horaFecha}"),
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

        const SizedBox(height: 16.0),
        SizedBox(
            width: double.infinity,
            height: 250,
            child: Center(
              child: SizedBox(
                child: ListView.builder( // bien hasta ahi
                  itemCount: widget.listMediaPath!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var PhotoNumber = index + 1;
                    return Card(
                      child: ListTile(
                        leading: Text("Foto$PhotoNumber"),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // Center horizontally
                          children: [
                            GestureDetector(
                              onTap: () async {
                                //await GuardarFormulario(); TIENE QUE GUARDAR ANTES
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CameraApp(widget.formData, index)));
                              },
                              child: Image.asset(Resources.fotoImg,
                                  width: 48, height: 48),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02),
                            widget.listMediaPath![index].isEmpty
                                ? const Text("")
                                : GestureDetector(
                              onTap: () async {
                                if (widget.listMediaPath![index].isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Text(
                                          "No hay fotos para mostrar")));
                                } else {
                                  //await GuardarFormulario(); TIENE QUE GUARDAR ANTES
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DisplayPhoto(
                                                  widget.formData, index)));
                                }
                              },
                              child: Image.asset(Resources.fotoCam,
                                  width: 48, height: 48),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02),
                            widget.listMediaPath![index].isEmpty
                                ? const Text("")
                                : GestureDetector(
                              onTap: () async {
                                await BorrarFoto(index);
                              },
                              child: Image.asset(Resources.fotoX,
                                  width: 48, height: 48),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )),

        const SizedBox(height: 16.0),
        HelpersViewLetrasRojas.formItemsDesign( "I) IDENTIFICACIÓN DE LA VIVIENDA"),
        const SizedBox(height: 16.0),

        //PREGUNTAS INPUT
        HelpersViewLetrasSubs.formItemsDesign( "Ubicación Geografica"),

        HelpersViewLetrasSubs.formItemsDesignGris("01) Departamento"),
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

        HelpersViewLetrasSubs.formItemsDesignGris("02) Provincia"),
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

        HelpersViewLetrasSubs.formItemsDesignGris("03) Distrito"),
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

        HelpersViewLetrasSubs.formItemsDesignGris("04) Centro Poblado"),
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

        HelpersViewLetrasSubs.formItemsDesignGris("05) Nombre de la vía"),
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
                    maxLength: 200,
                  ), context),
            ]
        ),

        HelpersViewLetrasSubs.formItemsDesignGris("06) Télefono del Informante"),
        Column(
            children: <Widget>[
              HelpersViewBlancoIcon.formItemsDesign(
                  Icons.pending_actions,
                  TextFormField(
                    controller: widget.P07EspecificarPerc,
                    decoration: const InputDecoration(
                      labelText: '',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      return HelpersViewBlancoIcon.validateField(
                          value!, widget.ParamP07EspecificarPerc);
                    },
                    maxLength: 9,
                  ), context),
            ]
        ),

        HelpersViewLetrasSubs.formItemsDesignGris("07) Ubigeo"),
        Column(
            children: <Widget>[
              HelpersViewBlancoIcon.formItemsDesign(
                  Icons.pending_actions,
                  TextFormField(
                    controller: widget.P08EspecificarPerc,
                    decoration: const InputDecoration(
                      labelText: '',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      return HelpersViewBlancoIcon.validateField(
                          value!, widget.ParamP08EspecificarPerc);
                    },
                    maxLength: 6,
                  ), context),
            ]
        ),

        const SizedBox(height: 16.0),

        HelpersViewLetrasSubs.formItemsDesign( "Dirección de vivienda"),
        HelpersViewLetrasSubs.formItemsDesignGris("Tipo de Vía Avenida"),

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

        const SizedBox(height: 16.0),

        //BOTON PARA PRESEGUIR

        GestureDetector(
            onTap: ()  async {

              scrollController.animateTo(
                0.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );

              if(

                  (widget.formIdUsuario.text      == null || widget.formIdUsuario.text.isEmpty) ||
                  (widget.P01EspecificarPerc.text == null || widget.P01EspecificarPerc.text.isEmpty) ||
                  (widget.P02EspecificarPerc.text == null || widget.P02EspecificarPerc.text.isEmpty) ||
                  (widget.P03EspecificarPerc.text == null || widget.P03EspecificarPerc.text.isEmpty) ||
                  (widget.P04EspecificarPerc.text == null || widget.P04EspecificarPerc.text.isEmpty) ||
                  (_P05Perc == null) ||
                  (widget.P06EspecificarPerc.text == null || widget.P06EspecificarPerc.text.isEmpty) ||
                  (widget.P07EspecificarPerc.text == null || widget.P07EspecificarPerc.text.isEmpty) ||
                  (widget.P08EspecificarPerc.text == null || widget.P08EspecificarPerc.text.isEmpty)
              ){
                showDialogValidFields(Constants.faltanCampos);
              } else {
                await guardadoFase1();
                setState(() {
                  Fase1 = false;
                  Fase2 = true;
                });
                scrollController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
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


        ]
    )),


              Visibility(
                visible: Fase2,
                child:Column(
                  children: <Widget>[

                    HelpersViewLetrasRojas.formItemsDesign( "II)  IDENTIFICACIÓN DEL USUARIO, CUIDADOR Y PERSONA AUTORIZADA"),
                    const SizedBox(height: 16.0),
                    HelpersViewLetrasRojas.formItemsDesign( "Datos de la persona con discapacidad"),
                    const SizedBox(height: 16.0),



                    //OCULTAR
                    Visibility(
                        visible: ( (_P10Perc == P10Perc.Si || _P10Perc == null) ),
                        child:Column(
                            children: <Widget>[

                              HelpersViewLetrasToolTip(message: "●	Realizar la pregunta al informante del hogar y solicitar entrevistar a la persona con discapacidad, consultar si la está en condiciones de responder, caso contrario solicitar que esté presente el cuidador/a para apoyar en la entrevista.",
                                  controller: _tip09),
                              HelpersViewLetrasSubs.formItemsDesign( "09) ¿Hay alguna persona con discapacidad en este hogar?"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

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
                                        _P11Perc = null;
                                        widget.P11EspecificarPerc!.clear();
                                        _P12Perc = null;
                                        _P14Perc = null;
                                        _P15Perc = null;
                                        _P16Perc1 = null;
                                        _P16Perc2 = null;
                                        _P16Perc3 = null;
                                        _P17Perc1 = null;
                                        _P17Perc2 = null;
                                        _P17Perc3 = null;
                                        _P18Perc1 = null;
                                        _P18Perc2 = null;
                                        _P18Perc3 = null;
                                        widget.P19EspecificarPerc1!.clear();
                                        widget.P19EspecificarPerc2!.clear();
                                        widget.P19EspecificarPerc3!.clear();
                                        _P20Perc = null;
                                        _P21Perc = null;
                                        _P22Perc = null;
                                      });
                                    },),],
                              ),
                            ] )),


                    const SizedBox(height: 16.0),


                    Visibility(
                        visible: ( (_P09Perc == P09Perc.Si || _P09Perc == null) ),
                        child:Column(
                            children: <Widget>[
                              HelpersViewLetrasToolTip(message: "●	Realizar la pregunta a la persona con discapacidad o cuidador/a.\n"
                                  "●Finalizar la encuesta si la persona señala que no es usuario/a del programa.",
                                  controller: _tip10),
                              HelpersViewLetrasSubs.formItemsDesign( "10) ¿La persona con discapacidad es usuario/a del Programa CONTIGO?"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),


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
                                        _P11Perc = null;
                                        widget.P11EspecificarPerc!.clear();
                                        _P12Perc = null;
                                        _P14Perc = null;
                                        _P15Perc = null;
                                        _P16Perc1 = null;
                                        _P16Perc2 = null;
                                        _P16Perc3 = null;
                                        _P17Perc1 = null;
                                        _P17Perc2 = null;
                                        _P17Perc3 = null;
                                        _P18Perc1 = null;
                                        _P18Perc2 = null;
                                        _P18Perc3 = null;
                                        widget.P19EspecificarPerc1!.clear();
                                        widget.P19EspecificarPerc2!.clear();
                                        widget.P19EspecificarPerc3!.clear();
                                        _P20Perc = null;
                                        _P21Perc = null;
                                        _P22Perc = null;
                                      });
                                    },),],
                              ),
                            ] )),



                    Visibility(
                        visible: ( (_P09Perc == P09Perc.Si || _P09Perc == null) && (_P10Perc == P10Perc.Si || _P10Perc == null) ),
                        child:Column(
                            children: <Widget>[

                              const SizedBox(height: 16.0),
                              HelpersViewLetrasToolTip(message: "●	Realizar la pregunta al usuario/a o cuidador/a.",
                                  controller: _tip12),
                              HelpersViewLetrasSubs.formItemsDesign( "11) El/la usuario/a del programa ¿Qué edad tiene en años cumplidos?"),

                              Row(
                                children: [
                                  const Text('Años:', style: TextStyle(
                                    fontSize: 12.0,
                                    //color: Colors.white,
                                  ),),

                                  HelpersViewBlancoIcon.formItemsDesignDNI(
                                      TextFormField(
                                        controller: widget.P11EspecificarPerc,
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
                              HelpersViewLetrasToolTip(message: "●	Registrar por observación. De ser el caso realizar la pregunta al usuario/a o cuidador/a. ",
                                  controller: _tip13),
                              HelpersViewLetrasSubs.formItemsDesign( "12) Sexo del usuario/a del programa"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                              Row(
                                children: [
                                  const Text(
                                    'Hombre',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P12Perc>(
                                    value: P12Perc.hombre,
                                    groupValue: _P12Perc,
                                    onChanged: (P12Perc? value) {
                                      setState(() {
                                        _P12Perc = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Mujer',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P12Perc>(
                                    value: P12Perc.mujer,
                                    groupValue: _P12Perc,
                                    onChanged: (P12Perc? value) {
                                      setState(() {
                                        _P12Perc = value;
                                      });
                                    },),],
                              ),

                              const SizedBox(height: 16.0),
                              HelpersViewLetrasRojas.formItemsDesign( "Datos del cuidador"),

                              const SizedBox(height: 16.0),
                              HelpersViewLetrasToolTip(message: "●	Antes de realizar la pregunta, brindar el siguiente enunciado: \n"
                                  "El Cuidador/a es la persona que cumple con la función de facilitar y/o proporcionar cuidados en las actividades de la vida cotidiana que la persona con discapacidad"
                                  " no pueda realizar o en la que requiera algún tipo de apoyo debido a su incapacidad.",
                                  controller: _tip13),
                              HelpersViewLetrasSubs.formItemsDesign( "13) ¿El usuario/a del programa CONTIGO cuenta con cuidador/a?"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                              Row(
                                children: [
                                  const Text(
                                    'Sí',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P13Perc>(
                                    value: P13Perc.Si,
                                    groupValue: _P13Perc,
                                    onChanged: (P13Perc? value) {
                                      setState(() {
                                        _P13Perc = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'No',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P13Perc>(
                                    value: P13Perc.No,
                                    groupValue: _P13Perc,
                                    onChanged: (P13Perc? value) {
                                      setState(() {
                                        _P13Perc = value;
                                      });
                                    },),],
                              ),

                              const SizedBox(height: 16.0),
                              HelpersViewLetrasToolTip(message: "●	Antes de realizar la pregunta, brindar el siguiente enunciado: \n"
                                  "El Autorizado/a del cobro es la persona designada y autorizada para que realice los cobros de la pensión no contributiva.",
                                  controller: _tip14),
                              HelpersViewLetrasSubs.formItemsDesign( "14) ¿El usuario/a del programa CONTIGO cuenta con una persona autorizado/a para el cobro de la pensión?"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

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

                              const SizedBox(height: 16.0),
                              HelpersViewLetrasToolTip(message: "●	Realizar la pregunta al usuario/a o cuidador/a, o al familiar autorizado/a para el cobro.\n"
                                  "●	Si el usuario/a indica que él solo realiza el cobro, marcar la opción 2. Recordar que el cuidador/a no necesariamente es la persona autorizada para el cobro.",
                                  controller: _tip15),
                              HelpersViewLetrasSubs.formItemsDesign( "15) ¿El/la cuidador/a es el autorizado/a para realizar el cobro de la pensión del Programa CONTIGO?"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

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
                              HelpersViewLetrasRojas.formItemsDesign( "Usuario/a del programa"),

                                Column(
                                  children: <Widget>[
                                    const SizedBox(height: 16.0),
                                    HelpersViewLetrasToolTip(message: "●	Leer alternativas."
                                        "● Registrar para cada miembro si es que lo hubiera.",
                                        controller: _tip16),
                                    HelpersViewLetrasSubs.formItemsDesign( "16) ¿Cuál es la relación de parentesco del 'Usuario/a del programa' con el jefe/a del hogar?"),
                                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Esposa/o"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc1>(
                                            value: P16Perc1.esposa,
                                            groupValue: _P16Perc1,
                                            onChanged: (P16Perc1? value) {
                                              setState(() {
                                                _P16Perc1 = value;
                                                widget.P16EspecificarPerc1!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Conviviente"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc1>(
                                            value: P16Perc1.conviviente,
                                            groupValue: _P16Perc1,
                                            onChanged: (P16Perc1? value) {
                                              setState(() {
                                                _P16Perc1 = value;
                                                widget.P16EspecificarPerc1!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Hijo/a"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc1>(
                                            value: P16Perc1.hijo,
                                            groupValue: _P16Perc1,
                                            onChanged: (P16Perc1? value) {
                                              setState(() {
                                                _P16Perc1 = value;
                                                widget.P16EspecificarPerc1!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Hijastro/a"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc1>(
                                            value: P16Perc1.hijastro,
                                            groupValue: _P16Perc1,
                                            onChanged: (P16Perc1? value) {
                                              setState(() {
                                                _P16Perc1 = value;
                                                widget.P16EspecificarPerc1!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Yerno/Nuera"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc1>(
                                            value: P16Perc1.yerno,
                                            groupValue: _P16Perc1,
                                            onChanged: (P16Perc1? value) {
                                              setState(() {
                                                _P16Perc1 = value;
                                                widget.P16EspecificarPerc1!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Nieto/a"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc1>(
                                            value: P16Perc1.nieto,
                                            groupValue: _P16Perc1,
                                            onChanged: (P16Perc1? value) {
                                              setState(() {
                                                _P16Perc1 = value;
                                                widget.P16EspecificarPerc1!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Padre/Madrea"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc1>(
                                            value: P16Perc1.padres,
                                            groupValue: _P16Perc1,
                                            onChanged: (P16Perc1? value) {
                                              setState(() {
                                                _P16Perc1 = value;
                                                widget.P16EspecificarPerc1!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Suegro/a"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc1>(
                                            value: P16Perc1.suegro,
                                            groupValue: _P16Perc1,
                                            onChanged: (P16Perc1? value) {
                                              setState(() {
                                                _P16Perc1 = value;
                                                widget.P16EspecificarPerc1!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Hermano/a"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc1>(
                                            value: P16Perc1.hermano,
                                            groupValue: _P16Perc1,
                                            onChanged: (P16Perc1? value) {
                                              setState(() {
                                                _P16Perc1 = value;
                                                widget.P16EspecificarPerc1!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Trabajador/a del Hogar"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc1>(
                                            value: P16Perc1.trabajador,
                                            groupValue: _P16Perc1,
                                            onChanged: (P16Perc1? value) {
                                              setState(() {
                                                _P16Perc1 = value;
                                                widget.P16EspecificarPerc1!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro/a pariente (especificar)"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc1>(
                                            value: P16Perc1.otropariente,
                                            groupValue: _P16Perc1,
                                            onChanged: (P16Perc1? value) {
                                              setState(() {
                                                _P16Perc1 = value;
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro/a no pariente (especificar)"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc1>(
                                            value: P16Perc1.otronopariente,
                                            groupValue: _P16Perc1,
                                            onChanged: (P16Perc1? value) {
                                              setState(() {
                                                _P16Perc1 = value;
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    //OTRO ESPECIFICAR
                                    Visibility(
                                        visible: (_P16Perc1 == P16Perc1.otronopariente || _P16Perc1 == P16Perc1.otropariente),
                                        child:Column(
                                            children: <Widget>[
                                              HelpersViewBlancoIcon.formItemsDesign(
                                                  Icons.pending_actions,
                                                  TextFormField(
                                                    controller: widget.P16EspecificarPerc1 ,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Especifique',
                                                    ),
                                                    validator: (value) {
                                                      return HelpersViewBlancoIcon.validateField(
                                                          value!, widget.ParamP16EspecificarPerc1 );
                                                    },
                                                    maxLength: 100,
                                                  ), context),
                                            ]
                                        )),

                                     //SECUNADARIO 17
                                    const SizedBox(height: 16.0),
                                    HelpersViewLetrasToolTip(message: "●	No leer alternativas: \n"
                                        "Miembro del hogar: Es la persona pariente o no que reside en la vivienda, comparten al menos las comidas principales y/o "
                                        "tienen en común otras necesidades básicas, con cargo a un presupuesto común (comen de una misma olla).",
                                        controller: _tip17),
                                    HelpersViewLetrasSubs.formItemsDesign( "17) ¿El usuario/a del programa CONTIGO cuenta con cuidador/a?"),
                                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                                    Row(
                                      children: [
                                        const Text(
                                          'Sí',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Radio<P17Perc1>(
                                          value: P17Perc1.Si,
                                          groupValue: _P17Perc1,
                                          onChanged: (P17Perc1? value) {
                                            setState(() {
                                              _P17Perc1 = value;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'No',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Radio<P17Perc1>(
                                          value: P17Perc1.No,
                                          groupValue: _P17Perc1,
                                          onChanged: (P17Perc1? value) {
                                            setState(() {
                                              _P17Perc1 = value;
                                            });
                                          },),],
                                    ),

                                    const SizedBox(height: 16.0),
                                    HelpersViewLetrasToolTip(message: "●	Registrar por observación"
                                        "De ser el caso realizar la pregunta al usuario/a o cuidador/a, o persona autorizada para el cobro.",
                                        controller: _tip18),
                                    HelpersViewLetrasSubs.formItemsDesign( "18) Sexo del cuidador/a"),
                                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                                    Row(
                                      children: [
                                        const Text(
                                          'Hombre',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Radio<P18Perc1>(
                                          value: P18Perc1.hombre,
                                          groupValue: _P18Perc1,
                                          onChanged: (P18Perc1? value) {
                                            setState(() {
                                              _P18Perc1 = value;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'Mujer',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Radio<P18Perc1>(
                                          value: P18Perc1.mujer,
                                          groupValue: _P18Perc1,
                                          onChanged: (P18Perc1? value) {
                                            setState(() {
                                              _P18Perc1 = value;
                                            });
                                          },),],
                                    ),

                                    const SizedBox(height: 16.0),
                                    HelpersViewLetrasToolTip(message: "●	Realizar la pregunta al usuario/a o cuidador/a, o al familiar autorizado/a para el cobro.",
                                        controller: _tip19),
                                    HelpersViewLetrasSubs.formItemsDesign( "19) ¿Qué edad tiene en años cumplidos?"),
                                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                                    Row(
                                      children: [
                                        const Text('Años:', style: TextStyle(
                                          fontSize: 12.0,
                                          //color: Colors.white,
                                        ),),

                                        HelpersViewBlancoIcon.formItemsDesignDNI(
                                            TextFormField(
                                              controller: widget.P19EspecificarPerc1,
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
                                    HelpersViewLetrasRojas.formItemsDesign( "Cuidador/a"),

                                     //CLONES
                                    const SizedBox(height: 16.0),
                                    HelpersViewLetrasToolTip(message: "●	Leer alternativas."
                                        "● Registrar para cada miembro si es que lo hubiera.",
                                        controller: _tip16a),
                                    HelpersViewLetrasSubs.formItemsDesign( "16) ¿Cuál es la relación de parentesco del 'Cuidador/a' con el jefe/a del hogar?"),
                                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),
                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Esposa/o"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc2>(
                                            value: P16Perc2.esposa,
                                            groupValue: _P16Perc2,
                                            onChanged: (P16Perc2? value) {
                                              setState(() {
                                                _P16Perc2 = value;
                                                widget.P16EspecificarPerc2!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Conviviente"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc2>(
                                            value: P16Perc2.conviviente,
                                            groupValue: _P16Perc2,
                                            onChanged: (P16Perc2? value) {
                                              setState(() {
                                                _P16Perc2 = value;
                                                widget.P16EspecificarPerc2!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Hijo/a"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc2>(
                                            value: P16Perc2.hijo,
                                            groupValue: _P16Perc2,
                                            onChanged: (P16Perc2? value) {
                                              setState(() {
                                                _P16Perc2 = value;
                                                widget.P16EspecificarPerc2!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Hijastro/a"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc2>(
                                            value: P16Perc2.hijastro,
                                            groupValue: _P16Perc2,
                                            onChanged: (P16Perc2? value) {
                                              setState(() {
                                                _P16Perc2 = value;
                                                widget.P16EspecificarPerc2!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Yerno/Nuera"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc2>(
                                            value: P16Perc2.yerno,
                                            groupValue: _P16Perc2,
                                            onChanged: (P16Perc2? value) {
                                              setState(() {
                                                _P16Perc2 = value;
                                                widget.P16EspecificarPerc2!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Nieto/a"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc2>(
                                            value: P16Perc2.nieto,
                                            groupValue: _P16Perc2,
                                            onChanged: (P16Perc2? value) {
                                              setState(() {
                                                _P16Perc2 = value;
                                                widget.P16EspecificarPerc2!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Padre/Madrea"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc2>(
                                            value: P16Perc2.padres,
                                            groupValue: _P16Perc2,
                                            onChanged: (P16Perc2? value) {
                                              setState(() {
                                                _P16Perc2 = value;
                                                widget.P16EspecificarPerc2!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Suegro/a"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc2>(
                                            value: P16Perc2.suegro,
                                            groupValue: _P16Perc2,
                                            onChanged: (P16Perc2? value) {
                                              setState(() {
                                                _P16Perc2 = value;
                                                widget.P16EspecificarPerc2!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Hermano/a"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc2>(
                                            value: P16Perc2.hermano,
                                            groupValue: _P16Perc2,
                                            onChanged: (P16Perc2? value) {
                                              setState(() {
                                                _P16Perc2 = value;
                                                widget.P16EspecificarPerc2!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Trabajador/a del Hogar"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc2>(
                                            value: P16Perc2.trabajador,
                                            groupValue: _P16Perc2,
                                            onChanged: (P16Perc2? value) {
                                              setState(() {
                                                _P16Perc2 = value;
                                                widget.P16EspecificarPerc2!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro/a pariente (especificar)"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc2>(
                                            value: P16Perc2.otropariente,
                                            groupValue: _P16Perc2,
                                            onChanged: (P16Perc2? value) {
                                              setState(() {
                                                _P16Perc2 = value;
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro/a no pariente (especificar)"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc2>(
                                            value: P16Perc2.otronopariente,
                                            groupValue: _P16Perc2,
                                            onChanged: (P16Perc2? value) {
                                              setState(() {
                                                _P16Perc2 = value;
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    //OTRO ESPECIFICAR
                                    Visibility(
                                        visible: (_P16Perc2 == P16Perc2.otronopariente || _P16Perc2 == P16Perc2.otropariente),
                                        child:Column(
                                            children: <Widget>[
                                              HelpersViewBlancoIcon.formItemsDesign(
                                                  Icons.pending_actions,
                                                  TextFormField(
                                                    controller: widget.P16EspecificarPerc2 ,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Especifique',
                                                    ),
                                                    validator: (value) {
                                                      return HelpersViewBlancoIcon.validateField(
                                                          value!, widget.ParamP16EspecificarPerc2 );
                                                    },
                                                    maxLength: 100,
                                                  ), context),
                                            ]
                                        )),

                                    const SizedBox(height: 16.0),
                                    HelpersViewLetrasToolTip(message: "●	No leer alternativas: \n"
                                        "Miembro del hogar: Es la persona pariente o no que reside en la vivienda, comparten al menos las comidas principales y/o "
                                        "tienen en común otras necesidades básicas, con cargo a un presupuesto común (comen de una misma olla).",
                                        controller: _tip17a),
                                    HelpersViewLetrasSubs.formItemsDesign( "17) ¿El usuario/a del programa CONTIGO cuenta con cuidador/a?"),
                                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                                    Row(
                                      children: [
                                        const Text(
                                          'Sí',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Radio<P17Perc2>(
                                          value: P17Perc2.Si,
                                          groupValue: _P17Perc2,
                                          onChanged: (P17Perc2? value) {
                                            setState(() {
                                              _P17Perc2 = value;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'No',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Radio<P17Perc2>(
                                          value: P17Perc2.No,
                                          groupValue: _P17Perc2,
                                          onChanged: (P17Perc2? value) {
                                            setState(() {
                                              _P17Perc2 = value;
                                            });
                                          },),],
                                    ),

                                    const SizedBox(height: 16.0),
                                    HelpersViewLetrasToolTip(message: "●	Registrar por observación"
                                        "De ser el caso realizar la pregunta al usuario/a o cuidador/a, o persona autorizada para el cobro.",
                                        controller: _tip18),
                                    HelpersViewLetrasSubs.formItemsDesign( "18) Sexo del cuidador/a"),
                                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                                    Row(
                                      children: [
                                        const Text(
                                          'Hombre',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Radio<P18Perc2>(
                                          value: P18Perc2.hombre,
                                          groupValue: _P18Perc2,
                                          onChanged: (P18Perc2? value) {
                                            setState(() {
                                              _P18Perc2 = value;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'Mujer',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Radio<P18Perc2>(
                                          value: P18Perc2.mujer,
                                          groupValue: _P18Perc2,
                                          onChanged: (P18Perc2? value) {
                                            setState(() {
                                              _P18Perc2 = value;
                                            });
                                          },),],
                                    ),

                                    const SizedBox(height: 16.0),
                                    HelpersViewLetrasToolTip(message: "●	Realizar la pregunta al usuario/a o cuidador/a, o al familiar autorizado/a para el cobro.",
                                        controller: _tip19a),
                                    HelpersViewLetrasSubs.formItemsDesign( "19) ¿Qué edad tiene en años cumplidos?"),
                                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                                    Row(
                                      children: [
                                        const Text('Años:', style: TextStyle(
                                          fontSize: 12.0,
                                          //color: Colors.white,
                                        ),),

                                        HelpersViewBlancoIcon.formItemsDesignDNI(
                                            TextFormField(
                                              controller: widget.P19EspecificarPerc2,
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
                                    HelpersViewLetrasRojas.formItemsDesign( "Autorizado/a para el cobro"),

                                    const SizedBox(height: 16.0),
                                    HelpersViewLetrasToolTip(message: "●	Leer alternativas."
                                        "● Registrar para cada miembro si es que lo hubiera.",
                                        controller: _tip16b),
                                    HelpersViewLetrasSubs.formItemsDesign( "16) ¿Cuál es la relación de parentesco del 'Autorizado/a para el cobro' con el jefe/a del hogar?"),
                                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Esposa/o"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc3>(
                                            value: P16Perc3.esposa,
                                            groupValue: _P16Perc3,
                                            onChanged: (P16Perc3? value) {
                                              setState(() {
                                                _P16Perc3 = value;
                                                widget.P16EspecificarPerc3!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Conviviente"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc3>(
                                            value: P16Perc3.conviviente,
                                            groupValue: _P16Perc3,
                                            onChanged: (P16Perc3? value) {
                                              setState(() {
                                                _P16Perc3 = value;
                                                widget.P16EspecificarPerc3!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Hijo/a"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc3>(
                                            value: P16Perc3.hijo,
                                            groupValue: _P16Perc3,
                                            onChanged: (P16Perc3? value) {
                                              setState(() {
                                                _P16Perc3 = value;
                                                widget.P16EspecificarPerc3!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Hijastro/a"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc3>(
                                            value: P16Perc3.hijastro,
                                            groupValue: _P16Perc3,
                                            onChanged: (P16Perc3? value) {
                                              setState(() {
                                                _P16Perc3 = value;
                                                widget.P16EspecificarPerc3!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Yerno/Nuera"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc3>(
                                            value: P16Perc3.yerno,
                                            groupValue: _P16Perc3,
                                            onChanged: (P16Perc3? value) {
                                              setState(() {
                                                _P16Perc3 = value;
                                                widget.P16EspecificarPerc3!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Nieto/a"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc3>(
                                            value: P16Perc3.nieto,
                                            groupValue: _P16Perc3,
                                            onChanged: (P16Perc3? value) {
                                              setState(() {
                                                _P16Perc3 = value;
                                                widget.P16EspecificarPerc3!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Padre/Madrea"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc3>(
                                            value: P16Perc3.padres,
                                            groupValue: _P16Perc3,
                                            onChanged: (P16Perc3? value) {
                                              setState(() {
                                                _P16Perc3 = value;
                                                widget.P16EspecificarPerc3!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Suegro/a"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc3>(
                                            value: P16Perc3.suegro,
                                            groupValue: _P16Perc3,
                                            onChanged: (P16Perc3? value) {
                                              setState(() {
                                                _P16Perc3 = value;
                                                widget.P16EspecificarPerc3!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Hermano/a"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc3>(
                                            value: P16Perc3.hermano,
                                            groupValue: _P16Perc3,
                                            onChanged: (P16Perc3? value) {
                                              setState(() {
                                                _P16Perc3 = value;
                                                widget.P16EspecificarPerc3!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Trabajador/a del Hogar"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc3>(
                                            value: P16Perc3.trabajador,
                                            groupValue: _P16Perc3,
                                            onChanged: (P16Perc3? value) {
                                              setState(() {
                                                _P16Perc3 = value;
                                                widget.P16EspecificarPerc3!.clear();
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro/a pariente (especificar)"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc3>(
                                            value: P16Perc3.otropariente,
                                            groupValue: _P16Perc3,
                                            onChanged: (P16Perc3? value) {
                                              setState(() {
                                                _P16Perc3 = value;
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro/a no pariente (especificar)"),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Radio<P16Perc3>(
                                            value: P16Perc3.otronopariente,
                                            groupValue: _P16Perc3,
                                            onChanged: (P16Perc3? value) {
                                              setState(() {
                                                _P16Perc3 = value;
                                              });
                                            },),
                                        ),
                                      ],
                                    ),

                                    //OTRO ESPECIFICAR
                                    Visibility(
                                        visible: (_P16Perc3 == P16Perc3.otronopariente || _P16Perc3 == P16Perc3.otropariente),
                                        child:Column(
                                            children: <Widget>[
                                              HelpersViewBlancoIcon.formItemsDesign(
                                                  Icons.pending_actions,
                                                  TextFormField(
                                                    controller: widget.P16EspecificarPerc3 ,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Especifique',
                                                    ),
                                                    validator: (value) {
                                                      return HelpersViewBlancoIcon.validateField(
                                                          value!, widget.ParamP16EspecificarPerc3 );
                                                    },
                                                    maxLength: 100,
                                                  ), context),
                                            ]
                                        )),


                                    const SizedBox(height: 16.0),
                                    HelpersViewLetrasToolTip(message: "●	No leer alternativas: \n"
                                        "Miembro del hogar: Es la persona pariente o no que reside en la vivienda, comparten al menos las comidas principales y/o "
                                        "tienen en común otras necesidades básicas, con cargo a un presupuesto común (comen de una misma olla).",
                                        controller: _tip17b),
                                    HelpersViewLetrasSubs.formItemsDesign( "17) ¿El usuario/a del programa CONTIGO cuenta con cuidador/a?"),
                                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                                    Row(
                                      children: [
                                        const Text(
                                          'Sí',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Radio<P17Perc3>(
                                          value: P17Perc3.Si,
                                          groupValue: _P17Perc3,
                                          onChanged: (P17Perc3? value) {
                                            setState(() {
                                              _P17Perc3 = value;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'No',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Radio<P17Perc3>(
                                          value: P17Perc3.No,
                                          groupValue: _P17Perc3,
                                          onChanged: (P17Perc3? value) {
                                            setState(() {
                                              _P17Perc3 = value;
                                            });
                                          },),],
                                    ),


                                    const SizedBox(height: 16.0),
                                    HelpersViewLetrasToolTip(message: "●	Registrar por observación"
                                        "De ser el caso realizar la pregunta al usuario/a o cuidador/a, o persona autorizada para el cobro.",
                                        controller: _tip18),
                                    HelpersViewLetrasSubs.formItemsDesign( "18) Sexo del cuidador/a"),
                                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                                    Row(
                                      children: [
                                        const Text(
                                          'Hombre',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Radio<P18Perc3>(
                                          value: P18Perc3.hombre,
                                          groupValue: _P18Perc3,
                                          onChanged: (P18Perc3? value) {
                                            setState(() {
                                              _P18Perc3 = value;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'Mujer',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Radio<P18Perc3>(
                                          value: P18Perc3.mujer,
                                          groupValue: _P18Perc3,
                                          onChanged: (P18Perc3? value) {
                                            setState(() {
                                              _P18Perc3 = value;
                                            });
                                          },),],
                                    ),


                                    const SizedBox(height: 16.0),
                                    HelpersViewLetrasToolTip(message: "●	Realizar la pregunta al usuario/a o cuidador/a, o al familiar autorizado/a para el cobro.",
                                        controller: _tip19b),
                                    HelpersViewLetrasSubs.formItemsDesign( "19) ¿Qué edad tiene en años cumplidos?"),
                                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                                    Row(
                                      children: [
                                        const Text('Años:', style: TextStyle(
                                          fontSize: 12.0,
                                          //color: Colors.white,
                                        ),),

                                        HelpersViewBlancoIcon.formItemsDesignDNI(
                                            TextFormField(
                                              controller: widget.P19EspecificarPerc3,
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
                                    HelpersViewLetrasToolTip(message: "●	Realizar la pregunta al usuario/a o cuidador/a, o al familiar autorizado/a para el cobro.",
                                        controller: _tip20),
                                    HelpersViewLetrasSubs.formItemsDesign( "20) ¿El cuidador ha recibido capacitación en prácticas de cuidado, atención y trato adecuado a las personas con discapacidad?"),
                                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                                    Row(
                                      children: [
                                        const Text(
                                          'Sí',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Radio<P20Perc>(
                                          value: P20Perc.Si,
                                          groupValue: _P20Perc,
                                          onChanged: (P20Perc? value) {
                                            setState(() {
                                              _P20Perc = value;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'No',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        Radio<P20Perc>(
                                          value: P20Perc.No,
                                          groupValue: _P20Perc,
                                          onChanged: (P20Perc? value) {
                                            setState(() {
                                              _P20Perc = value;
                                              _P21Perc = null;
                                            });
                                          },
                                        ),
                                      ],
                                    ),

                                    Visibility(
                                        visible: (_P20Perc == P20Perc.Si || _P20Perc ==null),
                                        child:Column(
                                            children: <Widget>[

                                              const SizedBox(height: 16.0),
                                              HelpersViewLetrasToolTip(message: "●	Realizar la pregunta al usuario/a o cuidador/a, o al familiar autorizado/a para el cobro."
                                                  "●	El/la encuestador/a debe leer las alternativas del 1 al 5. Si menciona otra opción marcar la alternativa 6 y especificar. ",
                                                  controller: _tip20),
                                              HelpersViewLetrasSubs.formItemsDesign("21) ¿De quién recibió la capacitación?"),
                                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                                              Row(
                                                children: [
                                                  HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Personal de la Municipalidad (OMAPED)"),
                                                  const Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Radio<P21Perc>(
                                                      value: P21Perc.omadep,
                                                      groupValue: _P21Perc,
                                                      onChanged: (P21Perc? value) {
                                                        setState(() {
                                                          _P21Perc = value;
                                                        });
                                                      },),
                                                  ),
                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Familiares / Vecinos / Amigos"),
                                                  const Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Radio<P21Perc>(
                                                      value: P21Perc.familaires,
                                                      groupValue: _P21Perc,
                                                      onChanged: (P21Perc? value) {
                                                        setState(() {
                                                          _P21Perc = value;
                                                        });
                                                      },),
                                                  ),
                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Medios de comunicación (radio, televisión, perifoneo, etc.)"),
                                                  const Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Radio<P21Perc>(
                                                      value: P21Perc.medios,
                                                      groupValue: _P21Perc,
                                                      onChanged: (P21Perc? value) {
                                                        setState(() {
                                                          _P21Perc = value;
                                                        });
                                                      },),
                                                  ),
                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Personal del Programa CONTIGO"),
                                                  const Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Radio<P21Perc>(
                                                      value: P21Perc.personal,
                                                      groupValue: _P21Perc,
                                                      onChanged: (P21Perc? value) {
                                                        setState(() {
                                                          _P21Perc = value;
                                                        });
                                                      },),
                                                  ),
                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Yo mismo buscando en internet"),
                                                  const Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Radio<P21Perc>(
                                                      value: P21Perc.yo,
                                                      groupValue: _P21Perc,
                                                      onChanged: (P21Perc? value) {
                                                        setState(() {
                                                          _P21Perc = value;
                                                        });
                                                      },),
                                                  ),
                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro (especifique)"),
                                                  const Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Radio<P21Perc>(
                                                      value: P21Perc.otro,
                                                      groupValue: _P21Perc,
                                                      onChanged: (P21Perc? value) {
                                                        setState(() {
                                                          _P21Perc = value;
                                                        });
                                                      },),
                                                  ),
                                                ],
                                              ),

                                              //OTRO ESPECIFICAR
                                              Visibility(
                                                  visible: (_P21Perc == P21Perc.otro),
                                                  child:Column(
                                                      children: <Widget>[
                                                        HelpersViewBlancoIcon.formItemsDesign(
                                                            Icons.pending_actions,
                                                            TextFormField(
                                                              controller: widget.P21EspecificarPerc ,
                                                              decoration: const InputDecoration(
                                                                labelText: 'Especifique',
                                                              ),
                                                              validator: (value) {
                                                                return HelpersViewBlancoIcon.validateField(
                                                                    value!, widget.ParamP22EspecificarPerc );
                                                              },
                                                              maxLength: 100,
                                                            ), context),
                                                      ]
                                                  )),

                                              const SizedBox(height: 16.0),

                                              //BOTON PARA PRESEGUIR

                                            ]
                                        )),


                                            ]
                                        ),



                              const SizedBox(height: 16.0),

                              GestureDetector(
                                  onTap: ()  async {

                                    if(
                                      (_P09Perc == null) ||
                                      (_P10Perc == null) ||
                                      //(_P11Perc == null) ||
                                      (widget.P11EspecificarPerc.text == null || widget.P11EspecificarPerc.text.isEmpty) ||
                                      (_P12Perc == null) ||
                                      (_P13Perc == null) ||
                                      (_P14Perc == null) ||
                                    //SI LA 15 es no los demas hasta la 21 se vuelven opcionales
                                      (_P15Perc == null) ||
                                      (_P16Perc1 == null) ||
                                      (_P16Perc2 == null) ||
                                      (_P16Perc3 == null) ||
                                      (_P20Perc == null)

                                    ){
                                      showDialogValidFields(Constants.faltanCampos);
                                    } else {
                                      await guardadoFase2();
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


                            ]
                        )),


                    Visibility(
                        visible: (_P09Perc == P09Perc.No || _P10Perc == P10Perc.No),
                        child:Column(
                            children: <Widget>[

                              GestureDetector(
                                  onTap: ()  async {

                                    if(
                                    1==2
                                    ){
                                      showDialogValidFields(Constants.faltanCampos);
                                    } else {
                                      await guardadoFase2();
                                      setState(() {
                                        Fase2 = false;
                                        Fase7 = true;
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
                                    child: const Text("TERMINAR FORMULARIO",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                  )),

                            ]
                        )),




                  ],),
              ),

              Visibility(
                visible: Fase3,
                child:Column(
                  children: <Widget>[

                    HelpersViewLetrasRojas.formItemsDesign( "III) PERCEPCIÓN DE LA CALIDAD DE VIDA"),
                    const SizedBox(height: 16.0),

                    HelpersViewLetrasRojas.formItemsDesign( "IV) ACCESO A LA PENSIÓN NO CONTRIBUTIVA"),
                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:"
                        "Calidad de vida es tener cubiertas las necesidades básicas, sentirse bien física y emocionalmente y poder participar en actividades sociales y comunitarias de manera plena y satisfactoria.\n"
                        "●	El/la encuestador/a debe leer solo las alternativas del 1 al 4. Si el/la usuario/a no sabe o no responde debe marcar la alternativa 5.",
                        controller: _tip22),
                    HelpersViewLetrasSubs.formItemsDesign( "22) ¿Cómo crees que ha sido tu calidad de vida en los últimos 30 días? (la del usuario/a)"), //
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Muy buena"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P22Perc>(
                            value: P22Perc.muybuena,
                            groupValue: _P22Perc,
                            onChanged: (P22Perc? value) {
                              setState(() {
                                _P22Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Buena"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P22Perc>(
                            value: P22Perc.buena,
                            groupValue: _P22Perc,
                            onChanged: (P22Perc? value) {
                              setState(() {
                                _P22Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Mala"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P22Perc>(
                            value: P22Perc.mala,
                            groupValue: _P22Perc,
                            onChanged: (P22Perc? value) {
                              setState(() {
                                _P22Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Muy mala"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P22Perc>(
                            value: P22Perc.muymala,
                            groupValue: _P22Perc,
                            onChanged: (P22Perc? value) {
                              setState(() {
                                _P22Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("No sabe / No responde"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P22Perc>(
                            value: P22Perc.nosabe,
                            groupValue: _P22Perc,
                            onChanged: (P22Perc? value) {
                              setState(() {
                                _P22Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    //22.1

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”.\n"
                        "●	El/la encuestador/a debe leer solo las alternativas del 1 al 4. Si el/la usuario/a no sabe o no responde debe marcar la alternativa 5."
                        "●	La respuesta debe ser brindada por el usuario del Programa; sin embargo, en caso el usuario/a sea menor de 18 años, "
                        "no pueda manifestar su voluntad, o requiera ser asistido por su cuidador/a y/o familiar autorizado/a "
                        "para el cobro, ellos podrán apoyar en las respuestas. En ese sentido, el encuestador debe marcar la opción de quién brindó la respuesta.",
                        controller: _tip29),
                    HelpersViewLetrasSubs.formItemsDesign( "23) ¿Cuánto ha contribuido el Programa CONTIGO a tu bienestar?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Bastante"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P23Perc>(
                            value: P23Perc.bastante,
                            groupValue: _P23Perc,
                            onChanged: (P23Perc? value) {
                              setState(() {
                                _P23Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Suficiente"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P23Perc>(
                            value: P23Perc.suficiente,
                            groupValue: _P23Perc,
                            onChanged: (P23Perc? value) {
                              setState(() {
                                _P23Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Poco"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P23Perc>(
                            value: P23Perc.poco,
                            groupValue: _P23Perc,
                            onChanged: (P23Perc? value) {
                              setState(() {
                                _P23Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Nada"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P23Perc>(
                            value: P23Perc.nada,
                            groupValue: _P23Perc,
                            onChanged: (P23Perc? value) {
                              setState(() {
                                _P23Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("No sabe/No responde"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P23Perc>(
                            value: P23Perc.nosabe,
                            groupValue: _P23Perc,
                            onChanged: (P23Perc? value) {
                              setState(() {
                                _P23Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    //23.1

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”.\n"
                        "●	El/la encuestador/a debe leer solo las alternativas del 1 al 3. Si el/la usuario/a no sabe o no responde debe marcar la alternativa 4."
                        "●	La respuesta debe ser brindada por el usuario del Programa; sin embargo, en caso el usuario/a sea menor de 18 años, "
                        "no pueda manifestar su voluntad, o requiera ser asistido por su cuidador/a y/o familiar autorizado/a "
                        "para el cobro, ellos podrán apoyar en las respuestas. En ese sentido, el encuestador debe marcar la opción de quién brindó la respuesta.",
                        controller: _tip29),
                    HelpersViewLetrasSubs.formItemsDesign( "24) Desde que estás en el Programa CONTIGO, consideras que tu situación económica"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Sigue igual"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P24Perc>(
                            value: P24Perc.sigueigual,
                            groupValue: _P24Perc,
                            onChanged: (P24Perc? value) {
                              setState(() {
                                _P24Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Ha mejorado"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P24Perc>(
                            value: P24Perc.hamejorado,
                            groupValue: _P24Perc,
                            onChanged: (P24Perc? value) {
                              setState(() {
                                _P24Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Ha empeorado"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P24Perc>(
                            value: P24Perc.haempeorado,
                            groupValue: _P24Perc,
                            onChanged: (P24Perc? value) {
                              setState(() {
                                _P24Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("No sabe/No responde"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P24Perc>(
                            value: P24Perc.nosabe,
                            groupValue: _P24Perc,
                            onChanged: (P24Perc? value) {
                              setState(() {
                                _P24Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),
                    
                    //24.1

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”.\n"
                        "●	El/la encuestador/a debe leer solo las alternativas del 1 al 4. Si el/la usuario/a no sabe o no responde debe marcar la alternativa 5."
                        "●	La respuesta debe ser brindada por el usuario del Programa; sin embargo, en caso el usuario/a sea menor de 18 años, "
                        "no pueda manifestar su voluntad, o requiera ser asistido por su cuidador/a y/o familiar autorizado/a "
                        "para el cobro, ellos podrán apoyar en las respuestas. En ese sentido, el encuestador debe marcar la opción de quién brindó la respuesta.",
                        controller: _tip29),
                    HelpersViewLetrasSubs.formItemsDesign( "25) Desde que estás en el Programa CONTIGO, consideras que tu situación económica"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Muy buena"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P25Perc>(
                            value: P25Perc.muybuena,
                            groupValue: _P25Perc,
                            onChanged: (P25Perc? value) {
                              setState(() {
                                _P25Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Buena"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P25Perc>(
                            value: P25Perc.buena,
                            groupValue: _P25Perc,
                            onChanged: (P25Perc? value) {
                              setState(() {
                                _P25Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Mala"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P25Perc>(
                            value: P25Perc.mala,
                            groupValue: _P25Perc,
                            onChanged: (P25Perc? value) {
                              setState(() {
                                _P25Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Muy mala"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P25Perc>(
                            value: P25Perc.muymala,
                            groupValue: _P25Perc,
                            onChanged: (P25Perc? value) {
                              setState(() {
                                _P25Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("No sabe/No responde"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P25Perc>(
                            value: P25Perc.nosabe,
                            groupValue: _P25Perc,
                            onChanged: (P25Perc? value) {
                              setState(() {
                                _P25Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),
                    
                    


                    const SizedBox(height: 16.0),
                    GestureDetector(
                        onTap: ()  async {
                          if(

                              (_P22Perc == null) ||
                              (_P23Perc == null) ||
                              (_P24Perc == null) ||
                              (_P25Perc == null)  //||
                              //(_P26Perc == null) ||
                              //(_P27Perc == null) ||
                              //(_P28Perc == null) ||
                              //(_P29Perc == null) //||
                              //(_P30Perc == null) ||
                              //(_P31Perc == null) ||
                              //(_P32Perc == null) ||
                              //(_P33Perc == null)
                                  //26 y 27 dependen de lo marcado en 25

                          ){
                            showDialogValidFields(Constants.faltanCampos);
                          } else {
                            await guardadoFase3();
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
                          child: const Text("Continuar",
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
                    
                    HelpersViewLetrasRojas.formItemsDesign( "IV) ACCESO A LA PENSIÓN NO CONTRIBUTIVA"),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Antes de realizar la pregunta, brindar el siguiente "
                        "enunciado al Usuario:“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”.\n"
                        "●	El/la encuestador/a debe leer solo las alternativas del 1 al 4. Si el/la usuario/a no sabe o no responde debe marcar la alternativa 5.",
                        controller: _tip34),
                    HelpersViewLetrasSubs.formItemsDesign( "34) ¿Qué tan satisfecho/a estás con el apoyo que tienes de tus familiares?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Muy satisfecho"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P34Perc>(
                            value: P34Perc.muysatisfecho,
                            groupValue: _P34Perc,
                            onChanged: (P34Perc? value) {
                              setState(() {
                                _P34Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Satisfecho"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P34Perc>(
                            value: P34Perc.satisfecho,
                            groupValue: _P34Perc,
                            onChanged: (P34Perc? value) {
                              setState(() {
                                _P34Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Insatisfecho/a "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P34Perc>(
                            value: P34Perc.insatisfecho,
                            groupValue: _P34Perc,
                            onChanged: (P34Perc? value) {
                              setState(() {
                                _P34Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Muy insatisfecho/a "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P34Perc>(
                            value: P34Perc.muyinsatisfecho,
                            groupValue: _P34Perc,
                            onChanged: (P34Perc? value) {
                              setState(() {
                                _P34Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("No sabe/No responde"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P34Perc>(
                            value: P34Perc.nosabe,
                            groupValue: _P34Perc,
                            onChanged: (P34Perc? value) {
                              setState(() {
                                _P34Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                        "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”.",
                        controller: _tip35),
                    HelpersViewLetrasSubs.formItemsDesign( "35) ¿Tiene amigos que lo visitan en su casa?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Nunca"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P35Perc>(
                            value: P35Perc.nunca,
                            groupValue: _P35Perc,
                            onChanged: (P35Perc? value) {
                              setState(() {
                                _P35Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Alguna vez"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P35Perc>(
                            value: P35Perc.algunavez,
                            groupValue: _P35Perc,
                            onChanged: (P35Perc? value) {
                              setState(() {
                                _P35Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Frecuentemente"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P35Perc>(
                            value: P35Perc.frecuente,
                            groupValue: _P35Perc,
                            onChanged: (P35Perc? value) {
                              setState(() {
                                _P35Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Siempre"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P35Perc>(
                            value: P35Perc.siempre,
                            groupValue: _P35Perc,
                            onChanged: (P35Perc? value) {
                              setState(() {
                                _P35Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                        "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”.",
                        controller: _tip36),
                    HelpersViewLetrasSubs.formItemsDesign( "36) ¿Sientes que tienes alguna persona que te exprese afecto y ánimo?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Nunca"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P36Perc>(
                            value: P36Perc.nunca,
                            groupValue: _P36Perc,
                            onChanged: (P36Perc? value) {
                              setState(() {
                                _P36Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Alguna vez"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P36Perc>(
                            value: P36Perc.algunavez,
                            groupValue: _P36Perc,
                            onChanged: (P36Perc? value) {
                              setState(() {
                                _P36Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Frecuentemnete"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P36Perc>(
                            value: P36Perc.frecuente,
                            groupValue: _P36Perc,
                            onChanged: (P36Perc? value) {
                              setState(() {
                                _P36Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Siempre"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P36Perc>(
                            value: P36Perc.siempre,
                            groupValue: _P36Perc,
                            onChanged: (P36Perc? value) {
                              setState(() {
                                _P36Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                        "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”.",
                        controller: _tip37),
                    HelpersViewLetrasSubs.formItemsDesign( "37) ¿Sientes que tienes alguna persona que te aliente a expresar tus ideas y pensamientos?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Nunca"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P37Perc>(
                            value: P37Perc.nunca,
                            groupValue: _P37Perc,
                            onChanged: (P37Perc? value) {
                              setState(() {
                                _P37Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Alguna vez"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P37Perc>(
                            value: P37Perc.algunavez,
                            groupValue: _P37Perc,
                            onChanged: (P37Perc? value) {
                              setState(() {
                                _P37Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Frecuentemnete"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P37Perc>(
                            value: P37Perc.frecuente,
                            groupValue: _P37Perc,
                            onChanged: (P37Perc? value) {
                              setState(() {
                                _P37Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Siempre"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P37Perc>(
                            value: P37Perc.siempre,
                            groupValue: _P37Perc,
                            onChanged: (P37Perc? value) {
                              setState(() {
                                _P37Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                        "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”.",
                        controller: _tip38),
                    HelpersViewLetrasSubs.formItemsDesign( "38) ¿Sientes que tienes alguna persona que te pueda prestar ayuda económica?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Nunca"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P38Perc>(
                            value: P38Perc.nunca,
                            groupValue: _P38Perc,
                            onChanged: (P38Perc? value) {
                              setState(() {
                                _P38Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Alguna vez"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P38Perc>(
                            value: P38Perc.algunavez,
                            groupValue: _P38Perc,
                            onChanged: (P38Perc? value) {
                              setState(() {
                                _P38Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Frecuentemnete"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P38Perc>(
                            value: P38Perc.frecuente,
                            groupValue: _P38Perc,
                            onChanged: (P38Perc? value) {
                              setState(() {
                                _P38Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Siempre"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P38Perc>(
                            value: P38Perc.siempre,
                            groupValue: _P38Perc,
                            onChanged: (P38Perc? value) {
                              setState(() {
                                _P38Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                        "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”.",
                        controller: _tip39),
                    HelpersViewLetrasSubs.formItemsDesign( "39) ¿Sientes que tienes alguna persona a la cual le puedas contarle tus problemas?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Nunca"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P39Perc>(
                            value: P39Perc.nunca,
                            groupValue: _P39Perc,
                            onChanged: (P39Perc? value) {
                              setState(() {
                                _P39Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Alguna vez"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P39Perc>(
                            value: P39Perc.algunavez,
                            groupValue: _P39Perc,
                            onChanged: (P39Perc? value) {
                              setState(() {
                                _P39Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Frecuentemnete"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P39Perc>(
                            value: P39Perc.frecuente,
                            groupValue: _P39Perc,
                            onChanged: (P39Perc? value) {
                              setState(() {
                                _P39Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Siempre"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P39Perc>(
                            value: P39Perc.siempre,
                            groupValue: _P39Perc,
                            onChanged: (P39Perc? value) {
                              setState(() {
                                _P39Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message:"●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                        "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”.\n"
                        "●	El/la encuestador/a debe leer solo las alternativas del 1 al 4. Si el/la usuario/a no sabe o no responde debe marcar la alternativa 5.",
                        controller: _tip40),
                    HelpersViewLetrasSubs.formItemsDesign( "40) ¿Qué tan satisfecho/a estás contigo mismo(a)?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Muy satisfecho/a"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P40Perc>(
                            value: P40Perc.muysatisfecho,
                            groupValue: _P40Perc,
                            onChanged: (P40Perc? value) {
                              setState(() {
                                _P40Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Satisfecho/a"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P40Perc>(
                            value: P40Perc.satisfecho,
                            groupValue: _P40Perc,
                            onChanged: (P40Perc? value) {
                              setState(() {
                                _P40Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Insatisfecho/a"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P40Perc>(
                            value: P40Perc.insatisfecho,
                            groupValue: _P40Perc,
                            onChanged: (P40Perc? value) {
                              setState(() {
                                _P40Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Muy insatisfecho/a"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P40Perc>(
                            value: P40Perc.muyinsatisfecho,
                            groupValue: _P40Perc,
                            onChanged: (P40Perc? value) {
                              setState(() {
                                _P40Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("No sabe / No responde"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P40Perc>(
                            value: P40Perc.nosabe,
                            groupValue: _P40Perc,
                            onChanged: (P40Perc? value) {
                              setState(() {
                                _P40Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "● Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”.\n"
                        "●	El/la encuestador/a debe leer solo las alternativas del 1 al 3. Si el/la usuario/a no sabe o no responde debe marcar la alternativa 4.",
                        controller: _tip41),
                    HelpersViewLetrasSubs.formItemsDesign( "41) Desde que estás en el Programa CONTIGO, consideras que tu situación económica"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Sigue igual"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P41Perc>(
                            value: P41Perc.sigueigual,
                            groupValue: _P41Perc,
                            onChanged: (P41Perc? value) {
                              setState(() {
                                _P41Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Ha mejorado"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P41Perc>(
                            value: P41Perc.hamejorado,
                            groupValue: _P41Perc,
                            onChanged: (P41Perc? value) {
                              setState(() {
                                _P41Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Ha empeorado"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P41Perc>(
                            value: P41Perc.haempeorado,
                            groupValue: _P41Perc,
                            onChanged: (P41Perc? value) {
                              setState(() {
                                _P41Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("No sabe/ No responde"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P41Perc>(
                            value: P41Perc.nosabe,
                            groupValue: _P41Perc,
                            onChanged: (P41Perc? value) {
                              setState(() {
                                _P41Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Dejar que el Usuario se tome su tiempo para pensar en la respuesta y de ser "
                        "necesario repetirle la pregunta. Recuerde que no debe leer las alternativas.\n"
                        "●	No debe de inducir o sugerir respuestas a la pregunta formulada, como darle ejemplos. Solo si es necesario podría precisar al usuario/a que se le pregunta"
                        " sobre el principal problema en su hogar que lo ha tenido preocupado en este año.\n"
                        "● Si la respuesta es distinta a las presentadas, seleccione “Otro” (Especifique) y registre la información correspondiente.\n"
                        "●	Se debe indagar en la respuesta brindada y de acuerdo a orden de importancia marcar las tres principales preocupaciones.\n"
                        "●	Puede haber 3, 2, 1 o ninguna preocupación. ",
                        controller: _tip42),
                    HelpersViewLetrasSubs.formItemsDesign( "42) ¿Cuáles han sido las mayores preocupaciones que han afectado tu bienestar durante el transcurso de este año 2024?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAvisoVarios),
                    HelpersViewLetrasSubs.formItemsDesign("Mi estado de salud (física, psicológica)"),
                    Row(
                      children: [
                        const Text(
                          '1',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc01Salud ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03Salud  = false;
                              P42Perc02Salud  = false;
                              P42Perc01Salud =  value!;
                            });
                          },
                        ),
                        const Text(
                          '2',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc02Salud ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03Salud  = false;
                              P42Perc02Salud  = value!;
                              P42Perc01Salud =  true;
                            });
                          },
                        ),
                        const Text(
                          '3',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc03Salud ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03Salud  = value!;
                              P42Perc02Salud  = true;
                              P42Perc01Salud  = true;
                            });
                          },
                        ),
                        ],
                    ),

                    HelpersViewLetrasSubs.formItemsDesign("La salud de mis familiares"),
                    Row(
                      children: [
                        const Text(
                          '1',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc01SaludF ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03SaludF  = false;
                              P42Perc02SaludF  = false;
                              P42Perc01SaludF =  value!;
                            });
                          },
                        ),
                        const Text(
                          '2',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc02SaludF ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03SaludF  = false;
                              P42Perc02SaludF  = value!;
                              P42Perc01SaludF =  true;
                            });
                          },
                        ),
                        const Text(
                          '3',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc03SaludF ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03SaludF  = value!;
                              P42Perc02SaludF  = true;
                              P42Perc01SaludF  = true;
                            });
                          },
                        ),
                      ],
                    ),

                    HelpersViewLetrasSubs.formItemsDesign("No tener el suficiente dinero los alimentos de mi hogar"),
                    Row(
                      children: [
                        const Text(
                          '1',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc01Dinero ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03Dinero  = false;
                              P42Perc02Dinero  = false;
                              P42Perc01Dinero =  value!;
                            });
                          },
                        ),
                        const Text(
                          '2',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc02Dinero ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03Dinero  = false;
                              P42Perc02Dinero  = value!;
                              P42Perc01Dinero =  true;
                            });
                          },
                        ),
                        const Text(
                          '3',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc03Dinero ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03Dinero  = value!;
                              P42Perc02Dinero  = true;
                              P42Perc01Dinero  = true;
                            });
                          },
                        ),
                      ],
                    ),

                    HelpersViewLetrasSubs.formItemsDesign("Los problemas familiares"),
                    Row(
                      children: [
                        const Text(
                          '1',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc01ProblemasF ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03ProblemasF  = false;
                              P42Perc02ProblemasF  = false;
                              P42Perc01ProblemasF =  value!;
                            });
                          },
                        ),
                        const Text(
                          '2',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc02ProblemasF ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03ProblemasF  = false;
                              P42Perc02ProblemasF  = value!;
                              P42Perc01ProblemasF =  true;
                            });
                          },
                        ),
                        const Text(
                          '3',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc03ProblemasF ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03ProblemasF  = value!;
                              P42Perc02ProblemasF  = true;
                              P42Perc01ProblemasF  = true;
                            });
                          },
                        ),
                      ],
                    ),

                    HelpersViewLetrasSubs.formItemsDesign("La falta de trabajo o negocio"),
                    Row(
                      children: [
                        const Text(
                          '1',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc01Falta ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03Falta  = false;
                              P42Perc02Falta  = false;
                              P42Perc01Falta =  value!;
                            });
                          },
                        ),
                        const Text(
                          '2',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc02Falta ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03Falta  = false;
                              P42Perc02Falta  = value!;
                              P42Perc01Falta =  true;
                            });
                          },
                        ),
                        const Text(
                          '3',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc03Falta ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03Falta  = value!;
                              P42Perc02Falta  = true;
                              P42Perc01Falta  = true;
                            });
                          },
                        ),
                      ],
                    ),

                    HelpersViewLetrasSubs.formItemsDesign("Problemas con mis vecinos/comunidad"),
                    Row(
                      children: [
                        const Text(
                          '1',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc01ProblemasV ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03ProblemasV  = false;
                              P42Perc02ProblemasV  = false;
                              P42Perc01ProblemasV =  value!;
                            });
                          },
                        ),
                        const Text(
                          '2',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc02ProblemasV ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03ProblemasV  = false;
                              P42Perc02ProblemasV  = value!;
                              P42Perc01ProblemasV =  true;
                            });
                          },
                        ),
                        const Text(
                          '3',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc03ProblemasV ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03ProblemasV  = value!;
                              P42Perc02ProblemasV  = true;
                              P42Perc01ProblemasV  = true;
                            });
                          },
                        ),
                      ],
                    ),

                    HelpersViewLetrasSubs.formItemsDesign("No estudiar (en el colegio, instituto o universidad)"),
                    Row(
                      children: [
                        const Text(
                          '1',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc01Estudio ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03Estudio = false;
                              P42Perc02Estudio = false;
                              P42Perc01Estudio=  value!;
                            });
                          },
                        ),
                        const Text(
                          '2',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc02Estudio ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03Estudio  = false;
                              P42Perc02Estudio  = value!;
                              P42Perc01Estudio =  true;
                            });
                          },
                        ),
                        const Text(
                          '3',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc03Estudio ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03Estudio  = value!;
                              P42Perc02Estudio  = true;
                              P42Perc01Estudio  = true;
                            });
                          },
                        ),
                      ],
                    ),

                    HelpersViewLetrasSubs.formItemsDesign("Otro (especifique): "),
                    Row(
                      children: [
                        const Text(
                          '1',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc01Otro ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03Otro = false;
                              P42Perc02Otro = false;
                              P42Perc01Otro=  value!;
                            });
                          },
                        ),
                        const Text(
                          '2',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc02Otro ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03Otro  = false;
                              P42Perc02Otro  = value!;
                              P42Perc01Otro =  true;
                            });
                          },
                        ),
                        const Text(
                          '3',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc03Otro ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03Otro  = value!;
                              P42Perc02Otro  = true;
                              P42Perc01Otro  = true;
                            });
                          },
                        ),
                      ],
                    ),
                    Visibility(
                        visible: (P42Perc01Otro || P42Perc02Otro || P42Perc03Otro),
                        child:Column(
                            children: <Widget>[
                              HelpersViewBlancoIcon.formItemsDesign(
                                  Icons.pending_actions,
                                  TextFormField(
                                    controller: widget.P42EspecificarPerc ,
                                    decoration: const InputDecoration(
                                      labelText: 'Especifique',
                                    ),
                                    validator: (value) {
                                      return HelpersViewBlancoIcon.validateField(
                                          value!, widget.ParamP42EspecificarPerc );
                                    },
                                    maxLength: 100,
                                  ), context),
                            ]
                        )),

                    HelpersViewLetrasSubs.formItemsDesign("No tengo preocupaciones, todo me ha ido bien"),
                    Row(
                      children: [
                        const Text(
                          '1',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Checkbox(
                          value: P42Perc03SinPreocupaciones ,
                          onChanged: (bool? value) {
                            setState(() {
                              P42Perc03SinPreocupaciones=  value!;
                            });
                          },
                        ),
                      ],
                    ),

                    //BOTON DE SUBIR
                    GestureDetector(
                        onTap: ()  async {
                          if(

                              (1 == 2) //||


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

                    //MODULO IV

                    HelpersViewLetrasRojas.formItemsDesign( "V) USO DEL DINERO"),
                    HelpersViewLetrasToolTip(message: "●	Realizar la pregunta al usuario/a o cuidador/a.",
                        controller: _tip43),
                    const SizedBox(height: 16.0),
                    HelpersViewLetrasSubs.formItemsDesign( "43) ¿Conoce la última fecha de pago o cronograma de pagos de la pensión del Programa CONTIGO?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAvisoNO),

                    Row(
                      children: [
                        const Text(
                          'Sí',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Radio<P43Perc>(
                          value: P43Perc.Si,
                          groupValue: _P43Perc,
                          onChanged: (P43Perc? value) {
                            setState(() {
                              _P43Perc = value;
                            });
                          },
                        ),
                        const Text(
                          'No',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Radio<P43Perc>(
                          value: P43Perc.No,
                          groupValue: _P43Perc,
                          onChanged: (P43Perc? value) {
                            setState(() {
                              _P43Perc = value;
                            });
                          },),],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                        "●	Indagar sobre la respuesta brindada y marcar la que más se asemeje.",
                        controller: _tip44),
                    HelpersViewLetrasSubs.formItemsDesign( "44) ¿Cómo se informó para saber la última fecha de pago o el cronograma de pagos de la Pensión del Programa CONTIGO?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAvisoNO),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Personal de la Municipalidad (OMAPED) "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P44Perc>(
                            value: P44Perc.omadep,
                            groupValue: _P44Perc,
                            onChanged: (P44Perc? value) {
                              setState(() {
                                _P44Perc = value;
                                widget.P44EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Familiares / Vecinos / Amigos "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P44Perc>(
                            value: P44Perc.familaires,
                            groupValue: _P44Perc,
                            onChanged: (P44Perc? value) {
                              setState(() {
                                _P44Perc = value;
                                widget.P44EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Medios de comunicación (radio, televisión, perifoneo, etc.)"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P44Perc>(
                            value: P44Perc.medios,
                            groupValue: _P44Perc,
                            onChanged: (P44Perc? value) {
                              setState(() {
                                _P44Perc = value;
                                widget.P44EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Personal del Programa CONTIGO"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P44Perc>(
                            value: P44Perc.personal,
                            groupValue: _P44Perc,
                            onChanged: (P44Perc? value) {
                              setState(() {
                                _P44Perc = value;
                                widget.P44EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Banco de la Nación "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P44Perc>(
                            value: P44Perc.banco,
                            groupValue: _P44Perc,
                            onChanged: (P44Perc? value) {
                              setState(() {
                                _P44Perc = value;
                                widget.P44EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Yo mismo buscando en internet"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P44Perc>(
                            value: P44Perc.yo,
                            groupValue: _P44Perc,
                            onChanged: (P44Perc? value) {
                              setState(() {
                                _P44Perc = value;
                                widget.P44EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro (especifique):"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P44Perc>(
                            value: P44Perc.otro,
                            groupValue: _P44Perc,
                            onChanged: (P44Perc? value) {
                              setState(() {
                                _P44Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    //OTRO ESPECIFICAR
                    Visibility(
                        visible: (_P44Perc == P44Perc.otro),
                        child:Column(
                            children: <Widget>[
                              HelpersViewBlancoIcon.formItemsDesign(
                                  Icons.pending_actions,
                                  TextFormField(
                                    controller: widget.P44EspecificarPerc ,
                                    decoration: const InputDecoration(
                                      labelText: 'Especifique',
                                    ),
                                    validator: (value) {
                                      return HelpersViewBlancoIcon.validateField(
                                          value!, widget.ParamP44EspecificarPerc );
                                    },
                                    maxLength: 100,
                                  ), context),
                            ]
                        )),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Si la respuesta del Usuario/a es diferente a las alternativas comprendidas entre el código 1 y el 4, "
                        "seleccione el código 5 “Otro” (Especifique) y registre la información correspondiente.\n"
                        "●	En el caso que el Usuario responda con el nombre de un mes en particular, marcar según la opción que corresponda.\n"
                        "●	Recuerde realizar el cálculo (en meses) según la respuesta que brinde el usuario/a.",
                        controller: _tip45),
                    HelpersViewLetrasSubs.formItemsDesign( "45) ¿Cuándo fue la última vez que cobraste tu pensión del Programa CONTIGO?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAvisoNO),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Hace 2 meses o menos"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P45Perc>(
                            value: P45Perc.dosmeses,
                            groupValue: _P45Perc,
                            onChanged: (P45Perc? value) {
                              setState(() {
                                _P45Perc = value;
                                widget.P45EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Hace más de 2 a 6 meses"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P45Perc>(
                            value: P45Perc.masdosmeses,
                            groupValue: _P45Perc,
                            onChanged: (P45Perc? value) {
                              setState(() {
                                _P45Perc = value;
                                widget.P45EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Hace 6 meses o más"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P45Perc>(
                            value: P45Perc.seismeses,
                            groupValue: _P45Perc,
                            onChanged: (P45Perc? value) {
                              setState(() {
                                _P45Perc = value;
                                widget.P45EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("No sabe / No responde"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P45Perc>(
                            value: P45Perc.nosabe,
                            groupValue: _P45Perc,
                            onChanged: (P45Perc? value) {
                              setState(() {
                                _P45Perc = value;
                                widget.P45EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro (especifique):"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P45Perc>(
                            value: P45Perc.otro,
                            groupValue: _P45Perc,
                            onChanged: (P45Perc? value) {
                              setState(() {
                                _P45Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    //OTRO ESPECIFICAR
                    Visibility(
                        visible: (_P45Perc == P45Perc.otro),
                        child:Column(
                            children: <Widget>[
                              HelpersViewBlancoIcon.formItemsDesign(
                                  Icons.pending_actions,
                                  TextFormField(
                                    controller: widget.P45EspecificarPerc ,
                                    decoration: const InputDecoration(
                                      labelText: 'Especifique',
                                    ),
                                    validator: (value) {
                                      return HelpersViewBlancoIcon.validateField(
                                          value!, widget.ParamP45EspecificarPerc );
                                    },
                                    maxLength: 100,
                                  ), context),
                            ]
                        )),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Si es necesario, al realizar la pregunta precisar que la última fecha de pago se refiere a los últimos 2 meses o menos.\n"
                        "● Si la respuesta del Usuario es diferente a las alternativas comprendidas entre el código 1 y el 6, seleccione el código 7 “Otro” (Especifique) y registre la información correspondiente.",
                        controller: _tip46),
                    HelpersViewLetrasSubs.formItemsDesign( "46) ¿Por qué razón no cobraste tu pensión del Programa CONTIGO en la última fecha de pago?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAvisoNO),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("No sabía que era usuario del Programa"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P46Perc>(
                            value: P46Perc.nosabiausuario,
                            groupValue: _P46Perc,
                            onChanged: (P46Perc? value) {
                              setState(() {
                                _P46Perc = value;
                                widget.P46EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("No sabía de la fecha de pago"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P46Perc>(
                            value: P46Perc.nosabiafecha,
                            groupValue: _P46Perc,
                            onChanged: (P46Perc? value) {
                              setState(() {
                                _P46Perc = value;
                                widget.P46EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Estuve enfermo"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P46Perc>(
                            value: P46Perc.enfermo,
                            groupValue: _P46Perc,
                            onChanged: (P46Perc? value) {
                              setState(() {
                                _P46Perc = value;
                                widget.P46EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Guardé/junte pensiones para luego hacer el cobro"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P46Perc>(
                            value: P46Perc.guarde,
                            groupValue: _P46Perc,
                            onChanged: (P46Perc? value) {
                              setState(() {
                                _P46Perc = value;
                                widget.P46EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Por la falta de movilidad"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P46Perc>(
                            value: P46Perc.movilidad,
                            groupValue: _P46Perc,
                            onChanged: (P46Perc? value) {
                              setState(() {
                                _P46Perc = value;
                                widget.P46EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("No sabe / No responde"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P46Perc>(
                            value: P46Perc.nosabe,
                            groupValue: _P46Perc,
                            onChanged: (P46Perc? value) {
                              setState(() {
                                _P46Perc = value;
                                widget.P46EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro (especifique):"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P46Perc>(
                            value: P46Perc.otro,
                            groupValue: _P46Perc,
                            onChanged: (P46Perc? value) {
                              setState(() {
                                _P46Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    //OTRO ESPECIFICAR
                    Visibility(
                        visible: (_P46Perc == P46Perc.otro),
                        child:Column(
                            children: <Widget>[
                              HelpersViewBlancoIcon.formItemsDesign(
                                  Icons.pending_actions,
                                  TextFormField(
                                    controller: widget.P46EspecificarPerc ,
                                    decoration: const InputDecoration(
                                      labelText: 'Especifique',
                                    ),
                                    validator: (value) {
                                      return HelpersViewBlancoIcon.validateField(
                                          value!, widget.ParamP46EspecificarPerc );
                                    },
                                    maxLength: 100,
                                  ), context),
                            ]
                        )),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	La respuesta la puede brindar el usuario del programa, su cuidador o familiar autorizado para el cobro.",
                        controller: _tip47),
                    HelpersViewLetrasSubs.formItemsDesign( "47) ¿Quién realiza el cobro de su pensión del Programa CONTIGO?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Yo, de manera independiente"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P47Perc>(
                            value: P47Perc.independiente,
                            groupValue: _P47Perc,
                            onChanged: (P47Perc? value) {
                              setState(() {
                                _P47Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Yo, acompañado de cuidador"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P47Perc>(
                            value: P47Perc.cuidador,
                            groupValue: _P47Perc,
                            onChanged: (P47Perc? value) {
                              setState(() {
                                _P47Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Yo, acompañado de familiar"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P47Perc>(
                            value: P47Perc.familiar,
                            groupValue: _P47Perc,
                            onChanged: (P47Perc? value) {
                              setState(() {
                                _P47Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Yo, con apoyo del personal de la Municipalidad"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P47Perc>(
                            value: P47Perc.municipalidad,
                            groupValue: _P47Perc,
                            onChanged: (P47Perc? value) {
                              setState(() {
                                _P47Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Persona autorizada\npara el cobro"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P47Perc>(
                            value: P47Perc.cobro,
                            groupValue: _P47Perc,
                            onChanged: (P47Perc? value) {
                              setState(() {
                                _P47Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Si en el último pago tuvo contratiempos (problemas en las vías u otro) deberá de repreguntar por el tiempo que suele "
                        "demorarse normalmente, donde no se da dichos contratiempos.\n"
                        "●	Sondear el tiempo y marcar la respuesta más idónea.",
                        controller: _tip48),
                    HelpersViewLetrasSubs.formItemsDesign( "48) La última vez que cobraste tu pensión del Programa, ya sea de manera personal o a través de tu "
                        "familiar autorizado, o con el apoyo de otra persona ¿Cuánto tiempo demoró para llegar al lugar de pago?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAvisoIDA),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Media hora o menos "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P48Perc>(
                            value: P48Perc.mediahora,
                            groupValue: _P48Perc,
                            onChanged: (P48Perc? value) {
                              setState(() {
                                _P48Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Más de media hora, pero menos de 1 hora"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P48Perc>(
                            value: P48Perc.masmediahora,
                            groupValue: _P48Perc,
                            onChanged: (P48Perc? value) {
                              setState(() {
                                _P48Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("De 1 a 2 horas"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P48Perc>(
                            value: P48Perc.unoadoshoras,
                            groupValue: _P48Perc,
                            onChanged: (P48Perc? value) {
                              setState(() {
                                _P48Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Más de 2 horas"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P48Perc>(
                            value: P48Perc.masdoshoras,
                            groupValue: _P48Perc,
                            onChanged: (P48Perc? value) {
                              setState(() {
                                _P48Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	De mencionar el usuario dos o más medios de movilización, deberá precisar que responda solo el "
                        "medio de transporte donde viaja más tiempo. "
                        "●	Si la respuesta del Usuario es diferente a las alternativas comprendidas entre el código 1 y el 10, seleccione el código 11 “Otro” "
                        "(Especifique) y registre la información correspondiente.\n"
                        "●	Sondear el tiempo y marcar la respuesta más idónea.",
                        controller: _tip49),
                    HelpersViewLetrasSubs.formItemsDesign( "49) La última vez que cobraste tu pensión del Programa ya sea de manera "
                        "personal o a través de tu familiar autorizado, o con el apoyo de otra persona, "
                        "¿Cómo te movilizaste o cómo se movilizó tu familiar o cómo se movilizaron para llegar al lugar de pago? "),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAvisoMEDIO),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("A pie"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P49Perc>(
                            value: P49Perc.apie,
                            groupValue: _P49Perc,
                            onChanged: (P49Perc? value) {
                              setState(() {
                                _P49Perc = value;
                                widget.P49EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Bicicleta"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P49Perc>(
                            value: P49Perc.bicicletas,
                            groupValue: _P49Perc,
                            onChanged: (P49Perc? value) {
                              setState(() {
                                _P49Perc = value;
                                widget.P49EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Caballo / Acémila"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P49Perc>(
                            value: P49Perc.caballo,
                            groupValue: _P49Perc,
                            onChanged: (P49Perc? value) {
                              setState(() {
                                _P49Perc = value;
                                widget.P49EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Mototaxi"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P49Perc>(
                            value: P49Perc.mototaxi,
                            groupValue: _P49Perc,
                            onChanged: (P49Perc? value) {
                              setState(() {
                                _P49Perc = value;
                                widget.P49EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Motocicleta"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P49Perc>(
                            value: P49Perc.motocicleta,
                            groupValue: _P49Perc,
                            onChanged: (P49Perc? value) {
                              setState(() {
                                _P49Perc = value;
                                widget.P49EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Automóvil / Camioneta"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P49Perc>(
                            value: P49Perc.automovil,
                            groupValue: _P49Perc,
                            onChanged: (P49Perc? value) {
                              setState(() {
                                _P49Perc = value;
                                widget.P49EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Taxi"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P49Perc>(
                            value: P49Perc.taxi,
                            groupValue: _P49Perc,
                            onChanged: (P49Perc? value) {
                              setState(() {
                                _P49Perc = value;
                                widget.P49EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Colectivo/Microbús/Coaster"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P49Perc>(
                            value: P49Perc.colectivo,
                            groupValue: _P49Perc,
                            onChanged: (P49Perc? value) {
                              setState(() {
                                _P49Perc = value;
                                widget.P49EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Camión"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P49Perc>(
                            value: P49Perc.camion,
                            groupValue: _P49Perc,
                            onChanged: (P49Perc? value) {
                              setState(() {
                                _P49Perc = value;
                                widget.P49EspecificarPerc!.clear();
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro (especifique):"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P49Perc>(
                            value: P49Perc.otro,
                            groupValue: _P49Perc,
                            onChanged: (P49Perc? value) {
                              setState(() {
                                _P49Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    //OTRO ESPECIFICAR
                    Visibility(
                        visible: (_P49Perc == P49Perc.otro),
                        child:Column(
                            children: <Widget>[
                              HelpersViewBlancoIcon.formItemsDesign(
                                  Icons.pending_actions,
                                  TextFormField(
                                    controller: widget.P49EspecificarPerc ,
                                    decoration: const InputDecoration(
                                      labelText: 'Especifique',
                                    ),
                                    validator: (value) {
                                      return HelpersViewBlancoIcon.validateField(
                                          value!, widget.ParamP49EspecificarPerc );
                                    },
                                    maxLength: 100,
                                  ), context),
                            ]
                        )),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Considerar todos los medios de transporte que tuvieron algún costo "
                        "para el Usuario/a, tanto de ida como de retorno a su vivienda.\n"
                        "●	Recuerde registrar: Si no realiza gasto alguno anote en la respuesta cero “0”. "
                        "Si no recuerda el monto gastado en la última vez registre “9999”.\n"
                        "●	Si la persona va a pie al lugar de pago, debe registrar cero “0”.",
                        controller: _tip50),
                    HelpersViewLetrasSubs.formItemsDesign( "50) ¿Cuánto gastaste o cuanto gastó tu familiar o cuánto gastaron en transporte de manera conjunta la última vez que "
                        "acudieron a cobrar el dinero del Programa?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAvisoPasaje),

                    Column(
                        children: <Widget>[
                          HelpersViewBlancoIcon.formItemsDesign(
                              Icons.pending_actions,
                              TextFormField(
                                controller: widget.P50EspecificarPerc,
                                decoration: const InputDecoration(
                                  labelText: '',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                validator: (value) {
                                  return HelpersViewBlancoIcon.validateField(
                                      value!, widget.ParamP50EspecificarPerc);
                                },
                                maxLength: 5,
                              ), context),
                        ]
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	La respuesta la puede brindar el usuario del programa, su cuidador o familiar autorizado para el cobro.",
                        controller: _tip51),
                    HelpersViewLetrasSubs.formItemsDesign( "51) ¿Bajo qué modalidad cobró la última vez el dinero otorgado por el Programa?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.checkAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Cobro por ventanilla del Banco de la Nación"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P51Perc>(
                            value: P51Perc.banco,
                            groupValue: _P51Perc,
                            onChanged: (P51Perc? value) {
                              setState(() {
                                _P51Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Cobro con tarjeta de débito (cobro por cajero)"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P51Perc>(
                            value: P51Perc.debito,
                            groupValue: _P51Perc,
                            onChanged: (P51Perc? value) {
                              setState(() {
                                _P51Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Cobro por agente "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P51Perc>(
                            value: P51Perc.agente,
                            groupValue: _P51Perc,
                            onChanged: (P51Perc? value) {
                              setState(() {
                                _P51Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Carrito pagador "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P51Perc>(
                            value: P51Perc.pagador,
                            groupValue: _P51Perc,
                            onChanged: (P51Perc? value) {
                              setState(() {
                                _P51Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Plataformas itinerantes de acción social (PIAS)"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P51Perc>(
                            value: P51Perc.pias,
                            groupValue: _P51Perc,
                            onChanged: (P51Perc? value) {
                              setState(() {
                                _P51Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	Dejar que el Usuario se tome su tiempo para pensar en la respuesta y de ser "
                        "necesario repetirle la pregunta. Recuerde que no debe leer las alternativas.\n"
                        "●	No debe de inducir o sugerir respuestas a la pregunta formulada, ni brindarle algunas alternativas como ejemplo.\n"
                        "●	Si la respuesta del Usuario es diferente a las alternativas comprendidas entre el código 1 y el 11, seleccione el código 12 "
                        "“Otro” (Especifique) y registre la información correspondiente.",
                        controller: _tip52),
                    HelpersViewLetrasSubs.formItemsDesign( "52) De acuerdo a la modalidad que cobra el dinero del Programa, actualmente, "
                        "¿Se presenta algún problema cada vez que cobra su pensión?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.checkAvisoNo),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("No, ninguno / Todo bien"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: P52Perc01 ,
                            onChanged: (bool? value) {
                              setState(() {
                                P52Perc01  = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Sí, la distancia al lugar de pago"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: P52Perc02 ,
                            onChanged: (bool? value) {
                              setState(() {
                                P52Perc02  = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Sí, gasto mucho en transporte"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: P52Perc03 ,
                            onChanged: (bool? value) {
                              setState(() {
                                P52Perc03  = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Sí, las colas en el banco que demora mucho"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: P52Perc04,
                            onChanged: (bool? value) {
                              setState(() {
                                P52Perc04 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Sí, no recibimos un buen trato del personal del banco "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: P52Perc05,
                            onChanged: (bool? value) {
                              setState(() {
                                P52Perc05 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Sí, no recibimos un buen trato del personal del Programa"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: P52Perc06,
                            onChanged: (bool? value) {
                              setState(() {
                                P52Perc06 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Sí, no nos pagan en la fecha programada "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: P52Perc07,
                            onChanged: (bool? value) {
                              setState(() {
                                P52Perc07 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Sí, no nos entregan todo el dinero de la pensión"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: P52Perc08,
                            onChanged: (bool? value) {
                              setState(() {
                                P52Perc08 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Sí, mi familiar autorizado no puede cobrar"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: P52Perc09,
                            onChanged: (bool? value) {
                              setState(() {
                                P52Perc09 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Sí, el agente multired no nos atiende "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: P52Perc10,
                            onChanged: (bool? value) {
                              setState(() {
                                P52Perc10 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Sí, en el banco no reconocen mi huella"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: P52Perc11,
                            onChanged: (bool? value) {
                              setState(() {
                                P52Perc11 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro (especifique):"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: P52Perc12,
                            onChanged: (bool? value) {
                              setState(() {
                                P52Perc12 = value!;
                                widget.P52EspecificarPerc!.clear();
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    //OTRO ESPECIFICAR
                    Visibility(
                        visible: (P52Perc12),
                        child:Column(
                            children: <Widget>[
                              HelpersViewBlancoIcon.formItemsDesign(
                                  Icons.pending_actions,
                                  TextFormField(
                                    controller: widget.P52EspecificarPerc ,
                                    decoration: const InputDecoration(
                                      labelText: 'Especifique',
                                    ),
                                    validator: (value) {
                                      return HelpersViewBlancoIcon.validateField(
                                          value!, widget.ParamP52EspecificarPerc );
                                    },
                                    maxLength: 100,
                                  ), context),
                            ]
                        )),


                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	La respuesta la puede brindar el usuario del programa, "
                        "su cuidador o familiar autorizado para el cobro.",
                        controller: _tip53),
                    HelpersViewLetrasSubs.formItemsDesign( "53) Cada vez que vas a cobrar tu dinero del Programa, ¿Se te hace difícil, o "
                        "se le hace difícil a tu familiar, o se les hace difícil llegar al lugar de pago?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        const Text(
                          'Sí',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Radio<P53Perc>(
                          value: P53Perc.Si,
                          groupValue: _P53Perc,
                          onChanged: (P53Perc? value) {
                            setState(() {
                              _P53Perc = value;
                            });
                          },
                        ),
                        const Text(
                          'No',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Radio<P53Perc>(
                          value: P53Perc.No,
                          groupValue: _P53Perc,
                          onChanged: (P53Perc? value) {
                            setState(() {
                              _P53Perc = value;
                            });
                          },),],
                    ),
                    
                    //53 no saltea 54
                    Visibility(
                        visible: (_P53Perc == P53Perc.Si || _P53Perc == null),
                        child:Column(
                            children: <Widget>[

                              const SizedBox(height: 16.0),
                              HelpersViewLetrasToolTip(message: "●	Dejar que el Usuario se tome su tiempo para pensar en la respuesta y de ser "
                                  "necesario repetirle la pregunta. Recuerde que no debe leer las alternativas.\n"
                                  "●	Si la respuesta es distinta a las presentadas, seleccione “Otro” (Especifique) y registre la información correspondiente.\n"
                                  "●	Se debe indagar en la respuesta brindada y de acuerdo a orden de importancia marcar los tres principales motivos.\n"
                                  "●	Precisar que la dificultad debe estar referida al traslado del usuario/a al lugar de pago.\n"
                                  "●	Puede haber 3, 2, 1 o ninguna preocupación.",
                                  controller: _tip54),
                              HelpersViewLetrasSubs.formItemsDesign( "54) ¿Cuáles son los tres principales motivos por los que se le hace difícil llegar al lugar de pago?"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.checkAviso),

                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAvisoVarios),
                              HelpersViewLetrasSubs.formItemsDesign("Por la distancia y/o tiempo de traslado"),
                              Row(
                                children: [
                                  const Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc01Distancia  ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Distancia = false;
                                        P54Perc02Distancia = false;
                                        P54Perc01Distancia=  value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc02Distancia ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Distancia  = false;
                                        P54Perc02Distancia  = value!;
                                        P54Perc01Distancia =  true;
                                      });
                                    },
                                  ),
                                  const Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc03Distancia ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Distancia  = value!;
                                        P54Perc02Distancia  = true;
                                        P54Perc01Distancia  = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              HelpersViewLetrasSubs.formItemsDesign("Por su estado físico o enfermedad "),
                              Row(
                                children: [
                                  const Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc01Fisico  ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Fisico = false;
                                        P54Perc02Fisico = false;
                                        P54Perc01Fisico=  value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc02Fisico ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Fisico  = false;
                                        P54Perc02Fisico  = value!;
                                        P54Perc01Fisico =  true;
                                      });
                                    },
                                  ),
                                  const Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc03Fisico ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Fisico  = value!;
                                        P54Perc02Fisico  = true;
                                        P54Perc01Fisico  = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              HelpersViewLetrasSubs.formItemsDesign("Por la ausencia de medios de transporte"),
                              Row(
                                children: [
                                  const Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc01Ausencia  ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Ausencia = false;
                                        P54Perc02Ausencia = false;
                                        P54Perc01Ausencia=  value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc02Ausencia ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Ausencia  = false;
                                        P54Perc02Ausencia  = value!;
                                        P54Perc01Ausencia =  true;
                                      });
                                    },
                                  ),
                                  const Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc03Ausencia ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Ausencia  = value!;
                                        P54Perc02Ausencia  = true;
                                        P54Perc01Ausencia  = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              HelpersViewLetrasSubs.formItemsDesign("Porque requiere que alguien lo acompañe"),
                              Row(
                                children: [
                                  const Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc01Requiere  ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Requiere = false;
                                        P54Perc02Requiere = false;
                                        P54Perc01Requiere=  value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc02Requiere ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Requiere  = false;
                                        P54Perc02Requiere  = value!;
                                        P54Perc01Requiere =  true;
                                      });
                                    },
                                  ),
                                  const Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc03Requiere ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Requiere = value!;
                                        P54Perc02Requiere = true;
                                        P54Perc01Requiere = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              HelpersViewLetrasSubs.formItemsDesign("Por el clima / ambiente"),
                              Row(
                                children: [
                                  const Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc01Clima  ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Clima = false;
                                        P54Perc02Clima = false;
                                        P54Perc01Clima=  value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc02Clima ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Clima  = false;
                                        P54Perc02Clima  = value!;
                                        P54Perc01Clima =  true;
                                      });
                                    },
                                  ),
                                  const Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc03Clima ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Clima = value!;
                                        P54Perc02Clima = true;
                                        P54Perc01Clima = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              HelpersViewLetrasSubs.formItemsDesign("Por el terreno / accesibilidad"),
                              Row(
                                children: [
                                  const Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc01Terreno  ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Terreno = false;
                                        P54Perc02Terreno = false;
                                        P54Perc01Terreno=  value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc02Terreno ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Terreno  = false;
                                        P54Perc02Terreno  = value!;
                                        P54Perc01Terreno =  true;
                                      });
                                    },
                                  ),
                                  const Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc03Terreno ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Terreno = value!;
                                        P54Perc02Terreno = true;
                                        P54Perc01Terreno = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              HelpersViewLetrasSubs.formItemsDesign("Otro (especifique): "),
                              Row(
                                children: [
                                  const Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc01Otro  ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Otro = false;
                                        P54Perc02Otro = false;
                                        P54Perc01Otro=  value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc02Otro ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Otro  = false;
                                        P54Perc02Otro  = value!;
                                        P54Perc01Otro =  true;
                                      });
                                    },
                                  ),
                                  const Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: P54Perc03Otro ,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        P54Perc03Otro = value!;
                                        P54Perc02Otro = true;
                                        P54Perc01Otro = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Visibility(
                                  visible: (P54Perc01Otro || P54Perc02Otro || P54Perc03Otro),
                                  child:Column(
                                      children: <Widget>[
                                        HelpersViewBlancoIcon.formItemsDesign(
                                            Icons.pending_actions,
                                            TextFormField(
                                              controller: widget.P54EspecificarPerc ,
                                              decoration: const InputDecoration(
                                                labelText: 'Especifique',
                                              ),
                                              validator: (value) {
                                                return HelpersViewBlancoIcon.validateField(
                                                    value!, widget.ParamP54EspecificarPerc );
                                              },
                                              maxLength: 100,
                                            ), context),
                                      ]
                                  )),
                            ]
                        )),



                    const SizedBox(height: 16.0),
                    GestureDetector(
                        onTap: ()  async {
                          if(
                              (1 == 2) //||

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
                          child: const Text("Continuar",
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

                    HelpersViewLetrasRojas.formItemsDesign( "VI) RIESGO SOCIAL"),
                    HelpersViewLetrasToolTip(message: "●	La respuesta la puede brindar el usuario del programa, su cuidador o familiar autorizado para el cobro.",
                        controller: _tip55),
                    const SizedBox(height: 16.0),
                    HelpersViewLetrasSubs.formItemsDesign( "55) Normalmente, usted (usuario del Programa) decide sobre el uso o destino del cobro del dinero del Programa"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        const Text(
                          'Sí',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Radio<P55Perc>(
                          value: P55Perc.Si,
                          groupValue: _P55Perc,
                          onChanged: (P55Perc? value) {
                            setState(() {
                              _P55Perc = value;
                            });
                          },
                        ),
                        const Text(
                          'No',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Radio<P55Perc>(
                          value: P55Perc.No,
                          groupValue: _P55Perc,
                          onChanged: (P55Perc? value) {
                            setState(() {
                              _P55Perc = value;
                            });
                          },),],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	La respuesta la puede brindar el usuario del programa, su cuidador o familiar autorizado para el cobro.",
                        controller: _tip56),
                    HelpersViewLetrasSubs.formItemsDesign( "56) En caso que usted no administre ni participa en el uso del dinero ¿Quién lo realiza?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        const Text(
                          'Cuidador/a',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Radio<P56Perc>(
                          value: P56Perc.cuidador,
                          groupValue: _P56Perc,
                          onChanged: (P56Perc? value) {
                            setState(() {
                              _P56Perc = value;
                            });
                          },
                        ),
                        const Text(
                          'Persona autorizada\npara el cobro',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Radio<P56Perc>(
                          value: P56Perc.autorizada,
                          groupValue: _P56Perc,
                          onChanged: (P56Perc? value) {
                            setState(() {
                              _P56Perc = value;
                            });
                          },),],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasToolTip(message: "●	La respuesta la puede brindar el usuario del programa, su cuidador o familiar autorizado para el cobro.\n"
                        "●	Es importante recalcar al Usuario/a que la pregunta se refiere al gasto que normalmente realiza con la pensión que cobró.\n"
                        "●	Si la respuesta del Usuario es diferente a las alternativas comprendidas entre el código 1 y el 9, "
                        "seleccione el código 10 “Otro” (Especifique) y registre la información correspondiente.\n"
                        "●	La alternativa de “Invierte en negocio / activos productivos” considera el inicio de un "
                        "emprendimiento o la compra de herramientas, semillas o animales que le sirva de insumos para una actividad productiva.",
                        controller: _tip57),
                    HelpersViewLetrasSubs.formItemsDesign( "57) Normalmente, ¿En qué se gasta principalmente el dinero que recibes del Programa?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAvisoPrincipal),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Salud/Medicinas como tratamientos, pastillas, inyecciones o exámenes, etc."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P57Perc>(
                            value: P57Perc.salud,
                            groupValue: _P57Perc,
                            onChanged: (P57Perc? value) {
                              setState(() {
                                _P57Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Ayudas técnicas como andador, bastón, cojín, anti escara, muletas, etc."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P57Perc>(
                            value: P57Perc.ayuda,
                            groupValue: _P57Perc,
                            onChanged: (P57Perc? value) {
                              setState(() {
                                _P57Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Alimentación (leche, azúcar, fideos, panes, frutas, etc.)"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P57Perc>(
                            value: P57Perc.alimentacion,
                            groupValue: _P57Perc,
                            onChanged: (P57Perc? value) {
                              setState(() {
                                _P57Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Vestimenta o ropa"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P57Perc>(
                            value: P57Perc.vestimenta,
                            groupValue: _P57Perc,
                            onChanged: (P57Perc? value) {
                              setState(() {
                                _P57Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Transporte"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P57Perc>(
                            value: P57Perc.transporte,
                            groupValue: _P57Perc,
                            onChanged: (P57Perc? value) {
                              setState(() {
                                _P57Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Invierte en negocio / activos productivos"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P57Perc>(
                            value: P57Perc.invierte,
                            groupValue: _P57Perc,
                            onChanged: (P57Perc? value) {
                              setState(() {
                                _P57Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Mejora de vivienda "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P57Perc>(
                            value: P57Perc.mejora,
                            groupValue: _P57Perc,
                            onChanged: (P57Perc? value) {
                              setState(() {
                                _P57Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Ahorro"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P57Perc>(
                            value: P57Perc.ahorra,
                            groupValue: _P57Perc,
                            onChanged: (P57Perc? value) {
                              setState(() {
                                _P57Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Pago de servicios del hogar: Luz, agua, alquiler"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P57Perc>(
                            value: P57Perc.pago,
                            groupValue: _P57Perc,
                            onChanged: (P57Perc? value) {
                              setState(() {
                                _P57Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("No Sabe en qué se gasta"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P57Perc>(
                            value: P57Perc.nosabe,
                            groupValue: _P57Perc,
                            onChanged: (P57Perc? value) {
                              setState(() {
                                _P57Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro (especifique):"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P57Perc>(
                            value: P57Perc.otro,
                            groupValue: _P57Perc,
                            onChanged: (P57Perc? value) {
                              setState(() {
                                _P57Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    //OTRO ESPECIFICAR
                    Visibility(
                        visible: (_P57Perc == P57Perc.otro),
                        child:Column(
                            children: <Widget>[
                              HelpersViewBlancoIcon.formItemsDesign(
                                  Icons.pending_actions,
                                  TextFormField(
                                    controller: widget.P57EspecificarPerc ,
                                    decoration: const InputDecoration(
                                      labelText: 'Especifique',
                                    ),
                                    validator: (value) {
                                      return HelpersViewBlancoIcon.validateField(
                                          value!, widget.ParamP57EspecificarPerc );
                                    },
                                    maxLength: 100,
                                  ), context),
                            ]
                        )),


                    GestureDetector(
                        onTap: ()  async {
                          if(
                              (1 == 2) //||

                          ){
                            showDialogValidFields(Constants.faltanCampos);
                          } else {
                            await guardadoFase6();
                            setState(()  {
                              Fase6 = false;
                              Fase7 = true;
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
                          child: const Text("Finalizar Cuestionario",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        )),


                  ],),
              ),

              Visibility(
                visible: Fase7,
                child:Column(
                  children: <Widget>[



                    HelpersViewLetrasSubs.formItemsDesign( "Para mejorar la precisión de la coordenada presioné icono del satélite, luego guarde su cuestionario presionando el icono diskette."),

                  ],),
              ),



            ]
        ));
  }

}