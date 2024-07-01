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
  TextEditingController P06EspecificarPerc = TextEditingController();
  final ParamP06EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P07EspecificarPerc = TextEditingController();
  final ParamP07EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P08EspecificarPerc = TextEditingController();
  final ParamP08EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P12EspecificarPerc = TextEditingController();
  final ParamP12EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P19EspecificarPerc = TextEditingController();
  final ParamP19EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P50EspecificarPerc = TextEditingController();
  final ParamP50EspecificarPerc = List.filled(3, "", growable: false);
  //ESPECIFICAR OTROS
  TextEditingController P16EspecificarPerc = TextEditingController();
  final ParamP16EspecificarPerc = List.filled(3, "", growable: false);
  TextEditingController P22EspecificarPerc = TextEditingController();
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
enum P16Perc { esposa, conviviente, hijo, hijastro, yerno, nieto, padres, suegro, hermano, trabajador, otropariente, otronopariente }
//ESPECIFICAR

enum P17Perc { Si, No }
enum P18Perc { Si, No }

enum P20Perc { hombre, mujer }
enum P21Perc { Si, No }
enum P22Perc { omadep, familaires, medios, personal, yo, otro}
enum P23Perc { jefe, esposa, hijo, yerno, nieto, padres, hermano, trabajador, otropariente }
enum P24Perc { hombre, mujer }

enum P25Perc {solo, esposohijos, esposo, padreshermanos, padres}
enum P26Perc {Si, No}
enum P27Perc {Si, No}

enum P28Perc {muybuena, buena, mala, muymala, nosabe}
enum P29Perc {muybuena, buena, mala, muymala, nosabe}

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

      if (GPSlatitude == "") {
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
  P16Perc? _P16Perc;
  P17Perc? _P17Perc;
  P18Perc? _P18Perc;
  P20Perc? _P20Perc;
  P21Perc? _P21Perc;
  P22Perc? _P22Perc;
  P23Perc? _P23Perc;
  P24Perc? _P24Perc;

  P25Perc? _P25Perc;
  P26Perc? _P26Perc;
  P27Perc? _P27Perc;

  P28Perc? _P28Perc;
  P29Perc? _P29Perc;

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

  P55Perc? _P55Perc;
  P56Perc? _P56Perc;
  P57Perc? _P57Perc;


  @override
  void initState() {
    conseguirVersion();
    revisarBackup();
    ConseguirHora();


    if (widget.formData != null) {

    }

    // TODO: implement initState
    super.initState();
  }

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
    //MODULO I
    widget.formData?.id_usuario = int.parse(widget.formIdUsuario!.text);

    PercP01 = "${PercP01}${widget.P01EspecificarPerc!.text};";
    PercP02 = "${PercP02}${widget.P02EspecificarPerc!.text};";
    PercP03 = "${PercP03}${widget.P03EspecificarPerc!.text};";
    PercP04 = "${PercP04}${widget.P04EspecificarPerc!.text};";


    if (_P05Perc == P05Perc.avenida) {
      PercP05 = "${PercP05}Avenida-A;";
    }
    if (_P05Perc == P05Perc.calle) {
      PercP05 = "${PercP05}Calle-B;";
    }
    if (_P05Perc == P05Perc.jiron) {
      PercP05 = "${PercP05}Jiron-C;";
    }
    if (_P05Perc == P05Perc.pasaje) {
      PercP05 = "${PercP05}Pasaje-D;";
    }
    if (_P05Perc == P05Perc.carretera) {
      PercP05 = "${PercP05}Carretera-E;";
    }
    if (_P05Perc == P05Perc.otro) {
      PercP05 = "${PercP05}Otro-F;";
    }

    PercP06 = "${PercP04}${widget.P06EspecificarPerc!.text};";
    PercP07 = "${PercP04}${widget.P07EspecificarPerc!.text};";
    PercP08 = "${PercP04}${widget.P08EspecificarPerc!.text};";

    //await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }


  Future<void> guardadoFase2() async {
    //MODULO II

    if (_P09Perc == P09Perc.Si) {
      PercP05 = "${PercP09}Sí-A;";
    }
    if (_P09Perc == P09Perc.No) {
      PercP05 = "${PercP09}No-B;";
    }

    if (_P10Perc == P10Perc.Si) {
      PercP10 = "${PercP10}Sí-A;";
    }
    if (_P10Perc == P10Perc.No) {
      PercP10 = "${PercP10}No-B;";
    }

    if (_P11Perc == P11Perc.Si) {
      PercP11 = "${PercP11}Sí-A;";
    }
    if (_P11Perc == P11Perc.No) {
      PercP11 = "${PercP11}No-B;";
    }

    PercP12 = "${PercP12}${widget.P12EspecificarPerc!.text};";

    if (_P13Perc == P13Perc.hombre) {
      PercP13 = "${PercP13}Hombre-A;";
    }
    if (_P13Perc == P13Perc.mujer) {
      PercP13 = "${PercP13}Mujer-B;";
    }

    if (_P14Perc == P14Perc.Si) {
      PercP14 = "${PercP14}Sí-A;";
    }
    if (_P14Perc == P14Perc.No) {
      PercP14 = "${PercP14}No-B;";
    }

    if (_P15Perc == P15Perc.Si) {
      PercP15 = "${PercP15}Sí-A;";
    }
    if (_P15Perc == P15Perc.No) {
      PercP15 = "${PercP15}No-B;";
    }

    if (_P16Perc == P16Perc.esposa) {
      PercP16 = "${PercP16}Esposa/o-A;";
    }
    if (_P16Perc == P16Perc.conviviente) {
      PercP16 = "${PercP16}Conviviente-B;";
    }
    if (_P16Perc == P16Perc.hijo) {
      PercP16 = "${PercP16}Hijo/a-C;";
    }
    if (_P16Perc == P16Perc.hijastro) {
      PercP16 = "${PercP16}Hijastro/a-D;";
    }
    if (_P16Perc == P16Perc.yerno) {
      PercP16 = "${PercP16}Yerno/nuera-E;";
    }
    if (_P16Perc == P16Perc.nieto) {
      PercP16 = "${PercP16}Nieto/a-F;";
    }
    if (_P16Perc == P16Perc.padres) {
      PercP16 = "${PercP16}Padre/madre-G;";
    }
    if (_P16Perc == P16Perc.suegro) {
      PercP16 = "${PercP16}Suegro/a-H;";
    }
    if (_P16Perc == P16Perc.hermano) {
      PercP16 = "${PercP16}Hermano/a-I;";
    }
    if (_P16Perc == P16Perc.trabajador) {
      PercP16 = "${PercP16}Trabajador/a del hogar-J;";
    }
    if (_P16Perc == P16Perc.otropariente) {
      PercP16 =
      "${PercP16}Otro/a pariente-K:${widget.P16EspecificarPerc!.text};";
    }
    if (_P16Perc == P16Perc.otronopariente) {
      PercP16 =
      "${PercP16}Otro/a no pariente-L:${widget.P16EspecificarPerc!.text};";
    }

    if (_P17Perc == P17Perc.Si) {
      PercP17 = "${PercP17}Sí-A;";
    }
    if (_P17Perc == P17Perc.No) {
      PercP17 = "${PercP17}No-B;";
    }

    if (_P18Perc == P18Perc.Si) {
      PercP18 = "${PercP18}Sí-A;";
    }
    if (_P18Perc == P18Perc.No) {
      PercP18 = "${PercP18}No-B;";
    }

    PercP19 = "${PercP19}${widget.P19EspecificarPerc!.text};";

    if (_P20Perc == P20Perc.hombre) {
      PercP20 = "${PercP20}hombre-A;";
    }
    if (_P20Perc == P20Perc.mujer) {
      PercP20 = "${PercP20}mujer-B;";
    }

    if (_P21Perc == P21Perc.Si) {
      PercP21 = "${PercP21}Sí-A;";
    }
    if (_P21Perc == P21Perc.No) {
      PercP21 = "${PercP21}No-B;";
    }

    if (_P22Perc == P22Perc.omadep) {
      PercP22 = "${PercP22}Personal de la Municipalidad (OMAPED)-A;";
    }
    if (_P22Perc == P22Perc.familaires) {
      PercP22 = "${PercP22}Familiares / Vecinos / Amigos-B;";
    }
    if (_P22Perc == P22Perc.medios) {
      PercP22 =
      "${PercP22}Medios de comunicación (radio, televisión, perifoneo, etc.)-C;";
    }
    if (_P22Perc == P22Perc.personal) {
      PercP22 = "${PercP22}Personal del Programa CONTIGO -D;";
    }
    if (_P22Perc == P22Perc.yo) {
      PercP22 = "${PercP22}Yo mismo buscando en internet -E;";
    }
    if (_P22Perc == P22Perc.otro) {
      PercP22 = "${PercP22}Otro-F:${widget.P22EspecificarPerc!.text};";
    }

    //await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase3() async {
    if (_P23Perc == P23Perc.jefe) {
      PercP23 = "${PercP23}Jefe/a del hogar-A;";
    }
    if (_P23Perc == P23Perc.esposa) {
      PercP23 = "${PercP23}Esposo/a o compañero/a-B;";
    }
    if (_P23Perc == P23Perc.hijo) {
      PercP23 = "${PercP23}Hijo/a / Hijastro/a-C;";
    }
    if (_P23Perc == P23Perc.yerno) {
      PercP23 = "${PercP23}Yerno / nuera-D;";
    }
    if (_P23Perc == P23Perc.nieto) {
      PercP23 = "${PercP23}Nieto/a-E;";
    }
    if (_P23Perc == P23Perc.padres) {
      PercP23 = "${PercP23}Padre/ madre / suegro/a-F;";
    }
    if (_P23Perc == P23Perc.hermano) {
      PercP23 = "${PercP23}Hermano/a-G;";
    }
    if (_P23Perc == P23Perc.trabajador) {
      PercP23 = "${PercP23}Trabajador/a del hogar-H;";
    }
    if (_P23Perc == P23Perc.otropariente) {
      PercP23 =
      "${PercP23}Otro/a pariente-I:${widget.P23EspecificarPerc!.text};";
    }

    if (_P24Perc == P24Perc.hombre) {
      PercP24 = "${PercP24}hombre-A;";
    }
    if (_P24Perc == P24Perc.mujer) {
      PercP24 = "${PercP24}mujer-B;";
    }

    //25, 26 y 27


    //await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase4() async {
    //MODULO III parte 2

    if (_P28Perc == P28Perc.muybuena) {
      PercP28 = "${PercP28}Muy buena-A;";
    }
    if (_P28Perc == P28Perc.buena) {
      PercP28 = "${PercP28}Buena-B;";
    }
    if (_P28Perc == P28Perc.mala) {
      PercP28 = "${PercP28}Mala-C;";
    }
    if (_P28Perc == P28Perc.muymala) {
      PercP28 = "${PercP28}Muy mala-D;";
    }
    if (_P28Perc == P28Perc.nosabe) {
      PercP28 = "${PercP28}No sabe / No responde-E;";
    }

    if (_P29Perc == P29Perc.muybuena) {
      PercP29 = "${PercP29}Muy buena-A;";
    }
    if (_P29Perc == P29Perc.buena) {
      PercP29 = "${PercP29}Buena-B;";
    }
    if (_P29Perc == P29Perc.mala) {
      PercP29 = "${PercP29}Mala-C;";
    }
    if (_P29Perc == P29Perc.muymala) {
      PercP29 = "${PercP29}Muy mala-D;";
    }
    if (_P29Perc == P29Perc.nosabe) {
      PercP29 = "${PercP29}No sabe / No responde-E;";
    }

    //30,31,32,33

    if (_P34Perc == P34Perc.muysatisfecho) {
      PercP34 = "${PercP34}Muy satisfecho/a-A;";
    }
    if (_P34Perc == P34Perc.satisfecho) {
      PercP34 = "${PercP34}Satisfecho/a-B;";
    }
    if (_P34Perc == P34Perc.insatisfecho) {
      PercP34 = "${PercP34}Insatisfecho/a-C;";
    }
    if (_P34Perc == P34Perc.muyinsatisfecho) {
      PercP34 = "${PercP34}Muy insatisfecho/a-D;";
    }
    if (_P34Perc == P34Perc.nosabe) {
      PercP34 = "${PercP34}No sabe/No responde-E;";
    }

    if (_P35Perc == P35Perc.nunca) {
      PercP35 = "${PercP35}Nunca-A;";
    }
    if (_P35Perc == P35Perc.algunavez) {
      PercP35 = "${PercP35}Alguna vez-B;";
    }
    if (_P35Perc == P35Perc.frecuente) {
      PercP35 = "${PercP35}Frecuentemente-C;";
    }
    if (_P35Perc == P35Perc.siempre) {
      PercP35 = "${PercP35}Siempre-D;";
    }

    if (_P36Perc == P36Perc.nunca) {
      PercP36 = "${PercP36}Nunca-A;";
    }
    if (_P36Perc == P36Perc.algunavez) {
      PercP36 = "${PercP36}Alguna vez-B;";
    }
    if (_P36Perc == P36Perc.frecuente) {
      PercP36 = "${PercP36}Frecuentemente-C;";
    }
    if (_P36Perc == P36Perc.siempre) {
      PercP36 = "${PercP36}Siempre-D;";
    }

    if (_P37Perc == P37Perc.nunca) {
      PercP37 = "${PercP37}Nunca-A;";
    }
    if (_P37Perc == P37Perc.algunavez) {
      PercP37 = "${PercP37}Alguna vez-B;";
    }
    if (_P37Perc == P37Perc.frecuente) {
      PercP37 = "${PercP37}Frecuentementeente-C;";
    }
    if (_P37Perc == P37Perc.siempre) {
      PercP37 = "${PercP37}Siempre-D;";
    }

    if (_P38Perc == P38Perc.nunca) {
      PercP38 = "${PercP38}Nunca-A;";
    }
    if (_P38Perc == P38Perc.algunavez) {
      PercP38 = "${PercP38}Alguna vez-B;";
    }
    if (_P38Perc == P38Perc.frecuente) {
      PercP38 = "${PercP38}Frecuentementente-C;";
    }
    if (_P38Perc == P38Perc.siempre) {
      PercP38 = "${PercP38}Siempre-D;";
    }

    if (_P39Perc == P39Perc.nunca) {
      PercP39 = "${PercP39}Nunca-A;";
    }
    if (_P39Perc == P39Perc.algunavez) {
      PercP39 = "${PercP39}Alguna vez-B;";
    }
    if (_P39Perc == P39Perc.frecuente) {
      PercP39 = "${PercP39}Frecuentementente-C;";
    }
    if (_P39Perc == P39Perc.siempre) {
      PercP39 = "${PercP39}Siempre-D;";
    }

    if (_P40Perc == P40Perc.muysatisfecho) {
      PercP40 = "${PercP40}Nunca-A;";
    }
    if (_P40Perc == P40Perc.satisfecho) {
      PercP40 = "${PercP40}Alguna vez-B;";
    }
    if (_P40Perc == P40Perc.insatisfecho) {
      PercP40 = "${PercP40}Frecuentemente-C;";
    }
    if (_P40Perc == P40Perc.muyinsatisfecho) {
      PercP40 = "${PercP40}Siempre-D;";
    }
    if (_P40Perc == P40Perc.nosabe) {
      PercP40 = "${PercP40}Siempre-E;";
    }

    if (_P41Perc == P41Perc.sigueigual) {
      PercP41 = "${PercP41}Sigue igual-A;";
    }
    if (_P41Perc == P41Perc.hamejorado) {
      PercP41 = "${PercP41}Ha mejorado-B;";
    }
    if (_P41Perc == P41Perc.haempeorado) {
      PercP41 = "${PercP41}Ha empeorado-C;";
    }
    if (_P41Perc == P41Perc.nosabe) {
      PercP41 = "${PercP41}No sabe/ No responde-D;";
    }

    //42

    // await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase5() async {
    //P15 - P18
    if (_P43Perc == P43Perc.Si) {
      PercP43 = "${PercP43}Sí-A;";
    }
    if (_P43Perc == P43Perc.No) {
      PercP43 = "${PercP43}No-B;";
    }

    if (_P44Perc == P44Perc.omadep) {
      PercP44 = "${PercP44}OMAPED-A;";
    }
    if (_P44Perc == P44Perc.familaires) {
      PercP44 = "${PercP44}Familiares / Vecinos / Amigos-B;";
    }
    if (_P44Perc == P44Perc.medios) {
      PercP44 =
      "${PercP44}Medios de comunicación (radio, televisión, perifoneo, etc.)-C;";
    }
    if (_P44Perc == P44Perc.personal) {
      PercP44 = "${PercP44}Personal del Programa CONTIGO-D;";
    }
    if (_P44Perc == P44Perc.banco) {
      PercP44 = "${PercP44}Banco de la Nación-E;";
    }
    if (_P44Perc == P44Perc.yo) {
      PercP44 = "${PercP44}Yo mismo buscando en internet-F;";
    }
    if (_P44Perc == P44Perc.otro) {
      PercP44 = "${PercP44}Otro-G:${widget.P44EspecificarPerc!.text};";
    }
    //await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase6() async {
    //P55 - P57
    if (_P55Perc == P55Perc.Si) {
      PercP55 = "${PercP55}Sí-A;";
    }
    if (_P55Perc == P55Perc.No) {
      PercP55 = "${PercP55}No-B;";
    }

    if (_P56Perc == P56Perc.cuidador) {
      PercP56 = "${PercP56}Cuidador/a-A;";
    }
    if (_P56Perc == P56Perc.autorizada) {
      PercP56 = "${PercP56}Persona autorizada-B;";
    }

    if (_P57Perc == P57Perc.salud) {
      PercP57 = "${PercP57}Salud/Medicina-A;";
    }
    if (_P57Perc == P57Perc.ayuda) {
      PercP57 = "${PercP57}Ayudas técnicas-B;";
    }
    if (_P57Perc == P57Perc.alimentacion) {
      PercP57 = "${PercP57}Alimentación-C;";
    }
    if (_P57Perc == P57Perc.vestimenta) {
      PercP57 = "${PercP57}Vestimenta o ropa-D;";
    }
    if (_P57Perc == P57Perc.transporte) {
      PercP57 = "${PercP57}Transporte-E;";
    }
    if (_P57Perc == P57Perc.invierte) {
      PercP57 = "${PercP57}Invierte/Activos-F;";
    }
    if (_P57Perc == P57Perc.mejora) {
      PercP57 = "${PercP57}Mejora Vivienda-G;";
    }
    if (_P57Perc == P57Perc.ahorra) {
      PercP57 = "${PercP57}Ahorro-H;";
    }
    if (_P57Perc == P57Perc.pago) {
      PercP57 = "${PercP57}Pago de Servicios-I;";
    }
    if (_P57Perc == P57Perc.nosabe) {
      PercP57 = "${PercP57}No Sabe-J;";
    }
    if (_P57Perc == P57Perc.otro) {
      PercP57 = "${PercP57}Otro-K:${widget.P57EspecificarPerc!.text};";
    }
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
                  widget.formData?.fecha =
                      formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());
                  widget.formData?.respuestas = respuestas;
                  widget.formData?.puntaje = puntaje;
                  widget.formData?.longitud = GPSlongitude;
                  widget.formData?.latitud = GPSlatitude;
                  widget.formData?.id_usuario =
                      int.parse(widget.formIdUsuario.text);
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.95,
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
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
    widget.P12EspecificarPerc!.clear();
    widget.P19EspecificarPerc!.clear();
    widget.P50EspecificarPerc!.clear();
    widget.P16EspecificarPerc!.clear();
    widget.P22EspecificarPerc!.clear();
    widget.P23EspecificarPerc!.clear();
    widget.P44EspecificarPerc!.clear();
    widget.P45EspecificarPerc!.clear();
    widget.P46EspecificarPerc!.clear();
    widget.P49EspecificarPerc!.clear();
    widget.P52EspecificarPerc!.clear();
    widget.P57EspecificarPerc!.clear();
    widget.formIdUsuario!.clear();
    widget.formNombreUsuario!.clear();


    widget.formData = Respuesta(); ////


    setState(() {
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
      _P13Perc = null;
      _P14Perc = null;
      _P15Perc = null;
      _P16Perc = null;
      _P17Perc = null;
      _P18Perc = null;
      _P20Perc = null;
      _P21Perc = null;
      _P22Perc = null;
      _P23Perc = null;
      _P24Perc = null;
      _P25Perc = null;
      _P26Perc = null;
      _P27Perc = null;
      _P28Perc = null;
      _P29Perc = null;
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
        HelpersViewLetrasRojas.formItemsDesign( "I) Identificación de Vivienda"),
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
                    maxLength: 100,
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
                    validator: (value) {
                      return HelpersViewBlancoIcon.validateField(
                          value!, widget.ParamP07EspecificarPerc);
                    },
                    maxLength: 100,
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
                    maxLength: 100,
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


        ]
    )),


              Visibility(
                visible: Fase2,
                child:Column(
                  children: <Widget>[

                    HelpersViewLetrasRojas.formItemsDesign( "II) Identificación del Usuario y Cuidador"),
                    const SizedBox(height: 16.0),
                    HelpersViewLetrasRojas.formItemsDesign( "Datos de la persona con discapacidad"),
                    const SizedBox(height: 16.0),



                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al informante del hogar y solicitar entrevistar a la persona con discapacidad, consultar si la está en condiciones de responder, caso contrario solicitar que esté presente el cuidador/a para apoyar en la entrevista."),
                    HelpersViewLetrasSubs.formItemsDesign( "08) ¿Hay alguna persona con discapacidad en este hogar?"),
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
                              widget.P12EspecificarPerc!.clear();
                              _P13Perc = null;
                              _P14Perc = null;
                              _P15Perc = null;
                              _P16Perc = null;
                              _P17Perc = null;
                              _P18Perc = null;
                              widget.P19EspecificarPerc!.clear();
                              _P20Perc = null;
                              _P21Perc = null;
                              _P22Perc = null;
                            });
                          },),],
                    ),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta a la persona con discapacidad o cuidador/a.\n"
                        "●Finalizar la encuesta si la persona señala que no es usuario/a del programa."),
                    HelpersViewLetrasSubs.formItemsDesign( "¿La persona con discapacidad es usuario/a del Programa CONTIGO?"),
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
                              widget.P12EspecificarPerc!.clear();
                              _P13Perc = null;
                              _P14Perc = null;
                              _P15Perc = null;
                              _P16Perc = null;
                              _P17Perc = null;
                              _P18Perc = null;
                              widget.P19EspecificarPerc!.clear();
                              _P20Perc = null;
                              _P21Perc = null;
                              _P22Perc = null;
                            });
                          },),],
                    ),

                    Visibility(
                        visible: ( (_P09Perc == P09Perc.Si || _P09Perc == null) && (_P10Perc == P10Perc.Si || _P10Perc == null) ),
                        child:Column(
                            children: <Widget>[
                              //LA ENCUESTA SE OCULTA SI SE PRESIONA NO


                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                                  "●	Miembro del hogar: Es la persona pariente o no que reside en la vivienda, comparten al menos las comidas principales y/o "
                                  "tienen en común otras necesidades básicas, con cargo a un presupuesto común (comen de una misma olla)."),
                              HelpersViewLetrasSubs.formItemsDesign( "¿El/la usuario/a del programa es miembro del hogar?"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

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
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

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

                              HelpersViewLetrasRojas.formItemsDesign( "Datos del cuidador"),

                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a."),
                              HelpersViewLetrasSubs.formItemsDesign( "¿La persona con discapacidad tiene cuidador?"),
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

                              HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a y leer las alternativas."),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Cuál es la relación de parentesco del/de la cuidador/a con e/la usuario/a del Programa CONTIGO?"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                              Row(
                                children: [
                                  HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Esposa/o"),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Radio<P16Perc>(
                                      value: P16Perc.esposa,
                                      groupValue: _P16Perc,
                                      onChanged: (P16Perc? value) {
                                        setState(() {
                                          _P16Perc = value;
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
                                    child: Radio<P16Perc>(
                                      value: P16Perc.conviviente,
                                      groupValue: _P16Perc,
                                      onChanged: (P16Perc? value) {
                                        setState(() {
                                          _P16Perc = value;
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
                                    child: Radio<P16Perc>(
                                      value: P16Perc.hijo,
                                      groupValue: _P16Perc,
                                      onChanged: (P16Perc? value) {
                                        setState(() {
                                          _P16Perc = value;
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
                                    child: Radio<P16Perc>(
                                      value: P16Perc.hijastro,
                                      groupValue: _P16Perc,
                                      onChanged: (P16Perc? value) {
                                        setState(() {
                                          _P16Perc = value;
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
                                    child: Radio<P16Perc>(
                                      value: P16Perc.yerno,
                                      groupValue: _P16Perc,
                                      onChanged: (P16Perc? value) {
                                        setState(() {
                                          _P16Perc = value;
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
                                    child: Radio<P16Perc>(
                                      value: P16Perc.nieto,
                                      groupValue: _P16Perc,
                                      onChanged: (P16Perc? value) {
                                        setState(() {
                                          _P16Perc = value;
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
                                    child: Radio<P16Perc>(
                                      value: P16Perc.padres,
                                      groupValue: _P16Perc,
                                      onChanged: (P16Perc? value) {
                                        setState(() {
                                          _P16Perc = value;
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
                                    child: Radio<P16Perc>(
                                      value: P16Perc.suegro,
                                      groupValue: _P16Perc,
                                      onChanged: (P16Perc? value) {
                                        setState(() {
                                          _P16Perc = value;
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
                                    child: Radio<P16Perc>(
                                      value: P16Perc.hermano,
                                      groupValue: _P16Perc,
                                      onChanged: (P16Perc? value) {
                                        setState(() {
                                          _P16Perc = value;
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
                                    child: Radio<P16Perc>(
                                      value: P16Perc.trabajador,
                                      groupValue: _P16Perc,
                                      onChanged: (P16Perc? value) {
                                        setState(() {
                                          _P16Perc = value;
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
                                    child: Radio<P16Perc>(
                                      value: P16Perc.otropariente,
                                      groupValue: _P16Perc,
                                      onChanged: (P16Perc? value) {
                                        setState(() {
                                          _P16Perc = value;
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
                                    child: Radio<P16Perc>(
                                      value: P16Perc.otronopariente,
                                      groupValue: _P16Perc,
                                      onChanged: (P16Perc? value) {
                                        setState(() {
                                          _P16Perc = value;
                                        });
                                      },),
                                  ),
                                ],
                              ),

                              //OTRO ESPECIFICAR
                              Visibility(
                                  visible: (_P16Perc == P16Perc.otronopariente || _P16Perc == P16Perc.otropariente),
                                  child:Column(
                                      children: <Widget>[
                                        HelpersViewBlancoIcon.formItemsDesign(
                                            Icons.pending_actions,
                                            TextFormField(
                                              controller: widget.P16EspecificarPerc ,
                                              decoration: const InputDecoration(
                                                labelText: 'Especifique',
                                              ),
                                              validator: (value) {
                                                return HelpersViewBlancoIcon.validateField(
                                                    value!, widget.ParamP16EspecificarPerc );
                                              },
                                              maxLength: 100,
                                            ), context),
                                      ]
                                  )),

                              const SizedBox(height: 16.0),

                              HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a\n"
                                  "●	Miembro del hogar: Es la persona pariente o no que reside en la vivienda, comparten al menos "
                                  "las comidas principales y/o tienen en común otras necesidades básicas, con cargo a un presupuesto común (comen de una misma olla)."
                              ),
                              HelpersViewLetrasSubs.formItemsDesign( "¿El/la cuidador/a es miembro del hogar?"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                              Row(
                                children: [
                                  const Text(
                                    'Sí',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P17Perc>(
                                    value: P17Perc.Si,
                                    groupValue: _P17Perc,
                                    onChanged: (P17Perc? value) {
                                      setState(() {
                                        _P17Perc = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'No',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P17Perc>(
                                    value: P17Perc.No,
                                    groupValue: _P17Perc,
                                    onChanged: (P17Perc? value) {
                                      setState(() {
                                        _P17Perc = value;
                                      });
                                    },
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16.0),

                              HelpersViewLetrasSubs.formItemsDesignBLUE( "● Realizar la pregunta al usuario/a o cuidador/a. \n"
                                  "●	Si el usuario/a indica que él solo realiza el cobro, marcar la opción 2. Recordar que el cuidador/a no necesariamente es la persona autorizada para el cobro. "
                              ),
                              HelpersViewLetrasSubs.formItemsDesign( "¿El/la cuidador/a es el autorizado para realizar el cobro del dinero del Programa CONTIGO?"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                              Row(
                                children: [
                                  const Text(
                                    'Sí',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P18Perc>(
                                    value: P18Perc.Si,
                                    groupValue: _P18Perc,
                                    onChanged: (P18Perc? value) {
                                      setState(() {
                                        _P18Perc = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'No',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P18Perc>(
                                    value: P18Perc.No,
                                    groupValue: _P18Perc,
                                    onChanged: (P18Perc? value) {
                                      setState(() {
                                        _P18Perc = value;
                                      });
                                    },
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16.0),

                              HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a."),
                              HelpersViewLetrasSubs.formItemsDesign( "El/la cuidador/a ¿Qué edad tiene en años cumplidos?"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                              Row(
                                children: [
                                  const Text('Años:', style: TextStyle(
                                    fontSize: 12.0,
                                    //color: Colors.white,
                                  ),),

                                  HelpersViewBlancoIcon.formItemsDesignDNI(
                                      TextFormField(
                                        controller: widget.P19EspecificarPerc,
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

                              HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Registrar por observación, de ser el caso realizar la pregunta al usuario/a o cuidador/a. "),
                              HelpersViewLetrasSubs.formItemsDesign( "Sexo del cuidador/a"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                              Row(
                                children: [
                                  const Text(
                                    'Hombre',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P20Perc>(
                                    value: P20Perc.hombre,
                                    groupValue: _P20Perc,
                                    onChanged: (P20Perc? value) {
                                      setState(() {
                                        _P20Perc = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Mujer',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P20Perc>(
                                    value: P20Perc.mujer,
                                    groupValue: _P20Perc,
                                    onChanged: (P20Perc? value) {
                                      setState(() {
                                        _P20Perc = value;
                                      });
                                    },),],
                              ),

                              const SizedBox(height: 16.0),

                              HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a."),
                              HelpersViewLetrasSubs.formItemsDesign( "¿El cuidador ha recibido capacitación en prácticas de cuidado, atención y trato adecuado a las personas con discapacidad?"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                              Row(
                                children: [
                                  const Text(
                                    'Sí',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P21Perc>(
                                    value: P21Perc.Si,
                                    groupValue: _P21Perc,
                                    onChanged: (P21Perc? value) {
                                      setState(() {
                                        _P21Perc = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'No',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P21Perc>(
                                    value: P21Perc.No,
                                    groupValue: _P21Perc,
                                    onChanged: (P21Perc? value) {
                                      setState(() {
                                        _P21Perc = value;
                                      });
                                    },
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16.0),

                              HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a."),
                              HelpersViewLetrasSubs.formItemsDesign("¿De quién recibió la capacitación?"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                              Row(
                                children: [
                                  HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Personal de la Municipalidad (OMAPED)"),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Radio<P22Perc>(
                                      value: P22Perc.omadep,
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
                                  HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Familiares / Vecinos / Amigos"),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Radio<P22Perc>(
                                      value: P22Perc.familaires,
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
                                  HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Medios de comunicación (radio, televisión, perifoneo, etc.)"),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Radio<P22Perc>(
                                      value: P22Perc.medios,
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
                                  HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Personal del Programa CONTIGO"),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Radio<P22Perc>(
                                      value: P22Perc.personal,
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
                                  HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Yo mismo buscando en internet"),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Radio<P22Perc>(
                                      value: P22Perc.yo,
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
                                  HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro (especifique)"),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Radio<P22Perc>(
                                      value: P22Perc.otro,
                                      groupValue: _P22Perc,
                                      onChanged: (P22Perc? value) {
                                        setState(() {
                                          _P22Perc = value;
                                        });
                                      },),
                                  ),
                                ],
                              ),

                              //OTRO ESPECIFICAR
                              Visibility(
                                  visible: (_P22Perc == P22Perc.otro),
                                  child:Column(
                                      children: <Widget>[
                                        HelpersViewBlancoIcon.formItemsDesign(
                                            Icons.pending_actions,
                                            TextFormField(
                                              controller: widget.P22EspecificarPerc ,
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
                                      //await guardadoFase2();
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

                    HelpersViewLetrasRojas.formItemsDesign( "III) Características del Hogar"),
                    const SizedBox(height: 16.0),
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a y leer las alternativas.\n"
                        "●	Jefe del hogar: Es la persona, a quien los miembros del hogar reconocen como tal y reside habitualmente en la vivienda, usualmente es la persona mayor de 18 años,"
                        " sostén económico del hogar y/o responsable de las decisiones y administración de este."),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Cuál es la relación de parentesco del usuario/a del Programa CONTIGO con el jefe o jefa del hogar?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Jefe/a del hogar "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P23Perc>(
                            value: P23Perc.jefe,
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
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Esposo/a o compañero/a "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P23Perc>(
                            value: P23Perc.esposa,
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
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Hijo/a / Hijastro/a"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P23Perc>(
                            value: P23Perc.hijo,
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
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Yerno / nuera"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P23Perc>(
                            value: P23Perc.yerno,
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
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Nieto/a"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P23Perc>(
                            value: P23Perc.nieto,
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
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Padre/ madre / suegro/a"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P23Perc>(
                            value: P23Perc.padres,
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
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Hermano/a"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P23Perc>(
                            value: P23Perc.hermano,
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
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Trabajador/a del hogar"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P23Perc>(
                            value: P23Perc.trabajador,
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
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Otro/a pariente (especificar):"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P23Perc>(
                            value: P23Perc.otropariente,
                            groupValue: _P23Perc,
                            onChanged: (P23Perc? value) {
                              setState(() {
                                _P23Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    //OTRO ESPECIFICAR
                    Visibility(
                        visible: (_P23Perc == P23Perc.otropariente),
                        child:Column(
                            children: <Widget>[
                              HelpersViewBlancoIcon.formItemsDesign(
                                  Icons.pending_actions,
                                  TextFormField(
                                    controller: widget.P23EspecificarPerc ,
                                    decoration: const InputDecoration(
                                      labelText: 'Especifique',
                                    ),
                                    validator: (value) {
                                      return HelpersViewBlancoIcon.validateField(
                                          value!, widget.ParamP23EspecificarPerc );
                                    },
                                    maxLength: 100,
                                  ), context),
                            ]
                        )),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a y leer las alternativas. "),
                    HelpersViewLetrasSubs.formItemsDesign( "Sexo del jefe/a del hogar"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        const Text(
                          'Hombre',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Radio<P24Perc>(
                          value: P24Perc.hombre,
                          groupValue: _P24Perc,
                          onChanged: (P24Perc? value) {
                            setState(() {
                              _P24Perc = value;
                            });
                          },
                        ),
                        const Text(
                          'Mujer',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Radio<P24Perc>(
                          value: P24Perc.mujer,
                          groupValue: _P24Perc,
                          onChanged: (P24Perc? value) {
                            setState(() {
                              _P24Perc = value;
                            });
                          },),],
                    ),

                    //COMBO DE PREGUNTA 25,26,27

                    const SizedBox(height: 16.0),
                    //HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a y leer las alternativas. "),
                    HelpersViewLetrasSubs.formItemsDesign( "En los últimos 6 meses ¿Con quién vive el usuario/a del Programa CONTIGO?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Solo/a"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P25Perc>(
                            value: P25Perc.solo,
                            groupValue: _P25Perc,
                            onChanged: (P25Perc? value) {
                              setState(() {
                                _P25Perc = value;
                                _P26Perc = null;
                                _P27Perc = null;

                              });
                            },),
                        ),
                      ],
                    ),


                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Vive con su esposo/a e hijos "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P25Perc>(
                            value: P25Perc.esposohijos,
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
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Vive con su esposo/a"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P25Perc>(
                            value: P25Perc.esposo,
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
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Vive con su padre/madre y hermano/as "),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P25Perc>(
                            value: P25Perc.padreshermanos,
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
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Vivo con su padre/madre"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P25Perc>(
                            value: P25Perc.padres,
                            groupValue: _P25Perc,
                            onChanged: (P25Perc? value) {
                              setState(() {
                                _P25Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    //
                    Visibility(
                        visible: (_P25Perc != P25Perc.solo),
                        child:Column(
                            children: <Widget>[

                              const SizedBox(height: 16.0),
                              //HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a y leer las alternativas. "),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Vive con otros familiares (como tío/as, primo/as, etc.)?"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                              Row(
                                children: [
                                  const Text(
                                    'Sí',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P26Perc>(
                                    value: P26Perc.Si,
                                    groupValue: _P26Perc,
                                    onChanged: (P26Perc? value) {
                                      setState(() {
                                        _P26Perc = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'No',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P26Perc>(
                                    value: P26Perc.No,
                                    groupValue: _P26Perc,
                                    onChanged: (P26Perc? value) {
                                      setState(() {
                                        _P26Perc = value;
                                      });
                                    },),],
                              ),

                              const SizedBox(height: 16.0),
                              //HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a y leer las alternativas. "),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Vive con otros familiares y/u otras personas que nos son parte de su familia (como hermanastro/as, madrina, etc.)?"),
                              HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                              Row(
                                children: [
                                  const Text(
                                    'Sí',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P27Perc>(
                                    value: P27Perc.Si,
                                    groupValue: _P27Perc,
                                    onChanged: (P27Perc? value) {
                                      setState(() {
                                        _P27Perc = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'No',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P27Perc>(
                                    value: P27Perc.No,
                                    groupValue: _P27Perc,
                                    onChanged: (P27Perc? value) {
                                      setState(() {
                                        _P27Perc = value;
                                      });
                                    },),],
                              ),


                            ]
                        )),



                    const SizedBox(height: 16.0),
                    GestureDetector(
                        onTap: ()  async {
                          if( 2 == 3
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

                    HelpersViewLetrasRojas.formItemsDesign( "III) Perceción de la calidad de vida"),
                    const SizedBox(height: 16.0),


                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario: Calidad de vida es …\n"
                        "●	El/la encuestador/a debe leer solo las alternativas del 1 al 4. Si el/la usuario/a no sabe o no responde debe marcar la alternativa 5."),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Cómo crees que ha sido tu calidad de vida   en los últimos 30 días?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Muy buena"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P28Perc>(
                            value: P28Perc.muybuena,
                            groupValue: _P28Perc,
                            onChanged: (P28Perc? value) {
                              setState(() {
                                _P28Perc = value;
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
                          child: Radio<P28Perc>(
                            value: P28Perc.buena,
                            groupValue: _P28Perc,
                            onChanged: (P28Perc? value) {
                              setState(() {
                                _P28Perc = value;
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
                          child: Radio<P28Perc>(
                            value: P28Perc.mala,
                            groupValue: _P28Perc,
                            onChanged: (P28Perc? value) {
                              setState(() {
                                _P28Perc = value;
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
                          child: Radio<P28Perc>(
                            value: P28Perc.muymala,
                            groupValue: _P28Perc,
                            onChanged: (P28Perc? value) {
                              setState(() {
                                _P28Perc = value;
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
                          child: Radio<P28Perc>(
                            value: P28Perc.muybuena,
                            groupValue: _P28Perc,
                            onChanged: (P28Perc? value) {
                              setState(() {
                                _P28Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),

                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”.\n"
                        "●	El/la encuestador/a debe leer solo las alternativas del 1 al 4. Si el/la usuario/a no sabe o no responde debe marcar la alternativa 5."),
                    HelpersViewLetrasSubs.formItemsDesign( "En la actualidad, dirías que tu salud es …"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Muy buena"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Radio<P29Perc>(
                            value: P29Perc.muybuena,
                            groupValue: _P29Perc,
                            onChanged: (P29Perc? value) {
                              setState(() {
                                _P29Perc = value;
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
                          child: Radio<P29Perc>(
                            value: P29Perc.buena,
                            groupValue: _P29Perc,
                            onChanged: (P29Perc? value) {
                              setState(() {
                                _P29Perc = value;
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
                          child: Radio<P29Perc>(
                            value: P29Perc.mala,
                            groupValue: _P29Perc,
                            onChanged: (P29Perc? value) {
                              setState(() {
                                _P29Perc = value;
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
                          child: Radio<P29Perc>(
                            value: P29Perc.muymala,
                            groupValue: _P29Perc,
                            onChanged: (P29Perc? value) {
                              setState(() {
                                _P29Perc = value;
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
                          child: Radio<P29Perc>(
                            value: P29Perc.nosabe,
                            groupValue: _P29Perc,
                            onChanged: (P29Perc? value) {
                              setState(() {
                                _P29Perc = value;
                              });
                            },),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    //HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"),
                    HelpersViewLetrasSubs.formItemsDesign( "Debido a tu condición de salud, ¿tiene dificultad para … sin ayuda o supervisión?"),
                    //HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Lavarse o secarse (manos y cara)."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isCheckedP30Opcion01 ,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedP30Opcion01  = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    //PREGUNTA SECUNDARIA
                    Visibility(
                        visible: (isCheckedP30Opcion01),
                        child:Column(
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Alguien lo asiste: ¿Cuidador o Familiar?"),
                              Row(
                                children: [
                                  const Text(
                                    'Cuidador',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc01>(
                                    value: P31Perc01.cuidador,
                                    groupValue: _P31Perc01,
                                    onChanged: (P31Perc01? value) {
                                      setState(() {
                                        _P31Perc01 = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Familiar',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc01>(
                                    value: P31Perc01.familiar,
                                    groupValue: _P31Perc01,
                                    onChanged: (P31Perc01? value) {
                                      setState(() {
                                        _P31Perc01 = value;
                                      });
                                    },),],
                              ),
                            ]
                        )),


                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Ducharse."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isCheckedP30Opcion02 ,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedP30Opcion02  = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),


                    //PREGUNTA SECUNDARIA
                    Visibility(
                        visible: (isCheckedP30Opcion02),
                        child:Column(
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Alguien lo asiste: ¿Cuidador o Familiar?"),
                              Row(
                                children: [
                                  const Text(
                                    'Cuidador',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc02>(
                                    value: P31Perc02.cuidador,
                                    groupValue: _P31Perc02,
                                    onChanged: (P31Perc02? value) {
                                      setState(() {
                                        _P31Perc02 = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Familiar',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc02>(
                                    value: P31Perc02.familiar,
                                    groupValue: _P31Perc02,
                                    onChanged: (P31Perc02? value) {
                                      setState(() {
                                        _P31Perc02 = value;
                                      });
                                    },),],
                              ),
                            ]
                        )),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Vestirse."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isCheckedP30Opcion03 ,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedP30Opcion03  = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    //PREGUNTA SECUNDARIA
                    Visibility(
                        visible: (isCheckedP30Opcion03),
                        child:Column(
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Alguien lo asiste: ¿Cuidador o Familiar?"),
                              Row(
                                children: [
                                  const Text(
                                    'Cuidador',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc03>(
                                    value: P31Perc03.cuidador,
                                    groupValue: _P31Perc03,
                                    onChanged: (P31Perc03? value) {
                                      setState(() {
                                        _P31Perc03 = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Familiar',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc03>(
                                    value: P31Perc03.familiar,
                                    groupValue: _P31Perc03,
                                    onChanged: (P31Perc03? value) {
                                      setState(() {
                                        _P31Perc03 = value;
                                      });
                                    },),],
                              ),
                            ]
                        )),


                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Utilizar el baño."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isCheckedP30Opcion04 ,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedP30Opcion04  = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    //PREGUNTA SECUNDARIA
                    Visibility(
                        visible: (isCheckedP30Opcion04),
                        child:Column(
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Alguien lo asiste: ¿Cuidador o Familiar?"),
                              Row(
                                children: [
                                  const Text(
                                    'Cuidador',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc04>(
                                    value: P31Perc04.cuidador,
                                    groupValue: _P31Perc04,
                                    onChanged: (P31Perc04? value) {
                                      setState(() {
                                        _P31Perc04 = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Familiar',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc04>(
                                    value: P31Perc04.familiar,
                                    groupValue: _P31Perc04,
                                    onChanged: (P31Perc04? value) {
                                      setState(() {
                                        _P31Perc04 = value;
                                      });
                                    },),],
                              ),
                            ]
                        )),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Acostarse o levantarse (cama, sillón u otros)."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isCheckedP30Opcion05 ,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedP30Opcion05 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    //PREGUNTA SECUNDARIA
                    Visibility(
                        visible: (isCheckedP30Opcion05),
                        child:Column(
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Alguien lo asiste: ¿Cuidador o Familiar?"),
                              Row(
                                children: [
                                  const Text(
                                    'Cuidador',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc05>(
                                    value: P31Perc05.cuidador,
                                    groupValue: _P31Perc05,
                                    onChanged: (P31Perc05? value) {
                                      setState(() {
                                        _P31Perc05 = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Familiar',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc05>(
                                    value: P31Perc05.familiar,
                                    groupValue: _P31Perc05,
                                    onChanged: (P31Perc05? value) {
                                      setState(() {
                                        _P31Perc05 = value;
                                      });
                                    },),],
                              ),
                            ]
                        )),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Alimentarse."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isCheckedP30Opcion06 ,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedP30Opcion06 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    //PREGUNTA SECUNDARIA
                    Visibility(
                        visible: (isCheckedP30Opcion06),
                        child:Column(
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Alguien lo asiste: ¿Cuidador o Familiar?"),
                              Row(
                                children: [
                                  const Text(
                                    'Cuidador',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc06>(
                                    value: P31Perc06.cuidador,
                                    groupValue: _P31Perc06,
                                    onChanged: (P31Perc06? value) {
                                      setState(() {
                                        _P31Perc06 = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Familiar',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc06>(
                                    value: P31Perc06.familiar,
                                    groupValue: _P31Perc06,
                                    onChanged: (P31Perc06? value) {
                                      setState(() {
                                        _P31Perc06 = value;
                                      });
                                    },),],
                              ),
                            ]
                        )),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Realizar compras del hogar."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isCheckedP30Opcion07 ,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedP30Opcion07 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    //PREGUNTA SECUNDARIA
                    Visibility(
                        visible: (isCheckedP30Opcion07),
                        child:Column(
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Alguien lo asiste: ¿Cuidador o Familiar?"),
                              Row(
                                children: [
                                  const Text(
                                    'Cuidador',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc07>(
                                    value: P31Perc07.cuidador,
                                    groupValue: _P31Perc07,
                                    onChanged: (P31Perc07? value) {
                                      setState(() {
                                        _P31Perc07 = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Familiar',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc07>(
                                    value: P31Perc07.familiar,
                                    groupValue: _P31Perc07,
                                    onChanged: (P31Perc07? value) {
                                      setState(() {
                                        _P31Perc07 = value;
                                      });
                                    },),],
                              ),
                            ]
                        )),


                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Preparar comidas."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isCheckedP30Opcion08 ,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedP30Opcion08 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    //PREGUNTA SECUNDARIA
                    Visibility(
                        visible: (isCheckedP30Opcion08),
                        child:Column(
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Alguien lo asiste: ¿Cuidador o Familiar?"),
                              Row(
                                children: [
                                  const Text(
                                    'Cuidador',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc08>(
                                    value: P31Perc08.cuidador,
                                    groupValue: _P31Perc08,
                                    onChanged: (P31Perc08? value) {
                                      setState(() {
                                        _P31Perc08 = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Familiar',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc08>(
                                    value: P31Perc08.familiar,
                                    groupValue: _P31Perc08,
                                    onChanged: (P31Perc08? value) {
                                      setState(() {
                                        _P31Perc08 = value;
                                      });
                                    },),],
                              ),
                            ]
                        )),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Utilizar teléfono."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isCheckedP30Opcion09 ,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedP30Opcion09 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    //PREGUNTA SECUNDARIA
                    Visibility(
                        visible: (isCheckedP30Opcion09),
                        child:Column(
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Alguien lo asiste: ¿Cuidador o Familiar?"),
                              Row(
                                children: [
                                  const Text(
                                    'Cuidador',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc09>(
                                    value: P31Perc09.cuidador,
                                    groupValue: _P31Perc09,
                                    onChanged: (P31Perc09? value) {
                                      setState(() {
                                        _P31Perc09 = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Familiar',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc09>(
                                    value: P31Perc09.familiar,
                                    groupValue: _P31Perc09,
                                    onChanged: (P31Perc09? value) {
                                      setState(() {
                                        _P31Perc09 = value;
                                      });
                                    },),],
                              ),
                            ]
                        )),



                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Realizar tareas domesticas en el hogar."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isCheckedP30Opcion10 ,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedP30Opcion10 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    //PREGUNTA SECUNDARIA
                    Visibility(
                        visible: (isCheckedP30Opcion10),
                        child:Column(
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Alguien lo asiste: ¿Cuidador o Familiar?"),
                              Row(
                                children: [
                                  const Text(
                                    'Cuidador',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc10>(
                                    value: P31Perc10.cuidador,
                                    groupValue: _P31Perc10,
                                    onChanged: (P31Perc10? value) {
                                      setState(() {
                                        _P31Perc10 = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Familiar',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc10>(
                                    value: P31Perc10.familiar,
                                    groupValue: _P31Perc10,
                                    onChanged: (P31Perc10? value) {
                                      setState(() {
                                        _P31Perc10 = value;
                                      });
                                    },),],
                              ),
                            ]
                        )),


                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Lavar ropa."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isCheckedP30Opcion11 ,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedP30Opcion11 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    //PREGUNTA SECUNDARIA
                    Visibility(
                        visible: (isCheckedP30Opcion11),
                        child:Column(
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Alguien lo asiste: ¿Cuidador o Familiar?"),
                              Row(
                                children: [
                                  const Text(
                                    'Cuidador',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc11>(
                                    value: P31Perc11.cuidador,
                                    groupValue: _P31Perc11,
                                    onChanged: (P31Perc11? value) {
                                      setState(() {
                                        _P31Perc11 = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Familiar',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc11>(
                                    value: P31Perc11.familiar,
                                    groupValue: _P31Perc11,
                                    onChanged: (P31Perc11? value) {
                                      setState(() {
                                        _P31Perc11 = value;
                                      });
                                    },),],
                              ),
                            ]
                        )),


                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Utilizar Transporte."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isCheckedP30Opcion12 ,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedP30Opcion12 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    //PREGUNTA SECUNDARIA
                    Visibility(
                        visible: (isCheckedP30Opcion12),
                        child:Column(
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Alguien lo asiste: ¿Cuidador o Familiar?"),
                              Row(
                                children: [
                                  const Text(
                                    'Cuidador',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc12>(
                                    value: P31Perc12.cuidador,
                                    groupValue: _P31Perc12,
                                    onChanged: (P31Perc12? value) {
                                      setState(() {
                                        _P31Perc12 = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Familiar',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc12>(
                                    value: P31Perc12.familiar,
                                    groupValue: _P31Perc12,
                                    onChanged: (P31Perc12? value) {
                                      setState(() {
                                        _P31Perc12 = value;
                                      });
                                    },),],
                              ),
                            ]
                        )),




                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Controlar su propia medicación."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isCheckedP30Opcion13 ,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedP30Opcion13 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    //PREGUNTA SECUNDARIA
                    Visibility(
                        visible: (isCheckedP30Opcion13),
                        child:Column(
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Alguien lo asiste: ¿Cuidador o Familiar?"),
                              Row(
                                children: [
                                  const Text(
                                    'Cuidador',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc13>(
                                    value: P31Perc13.cuidador,
                                    groupValue: _P31Perc13,
                                    onChanged: (P31Perc13? value) {
                                      setState(() {
                                        _P31Perc13 = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Familiar',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc13>(
                                    value: P31Perc13.familiar,
                                    groupValue: _P31Perc13,
                                    onChanged: (P31Perc13? value) {
                                      setState(() {
                                        _P31Perc13 = value;
                                      });
                                    },),],
                              ),
                            ]
                        )),

                    Row(
                      children: [
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("Manejar el dinero."),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isCheckedP30Opcion14,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedP30Opcion14 = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),


                    //PREGUNTA SECUNDARIA
                    Visibility(
                        visible: (isCheckedP30Opcion14),
                        child:Column(
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              HelpersViewLetrasSubs.formItemsDesign( "¿Alguien lo asiste: ¿Cuidador o Familiar?"),
                              Row(
                                children: [
                                  const Text(
                                    'Cuidador',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc14>(
                                    value: P31Perc14.cuidador,
                                    groupValue: _P31Perc14,
                                    onChanged: (P31Perc14? value) {
                                      setState(() {
                                        _P31Perc14 = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Familiar',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Radio<P31Perc14>(
                                    value: P31Perc14.familiar,
                                    groupValue: _P31Perc14,
                                    onChanged: (P31Perc14? value) {
                                      setState(() {
                                        _P31Perc14 = value;
                                      });
                                    },),],
                              ),
                            ]
                        )),



                    const SizedBox(height: 16.0),
                    //HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"),
                    HelpersViewLetrasSubs.formItemsDesign( "Si quien lo asiste es algún familiar, ¿cuál es su grado de parentesco?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    const SizedBox(height: 16.0),
                    //HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Con qué frecuencia recibe asistencia?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    //FIN DE LOS QUE NO ENTIENDO BIEN

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Antes de realizar la pregunta, brindar el siguiente "
                        "enunciado al Usuario:“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”.\n"
                        "●	El/la encuestador/a debe leer solo las alternativas del 1 al 4. Si el/la usuario/a no sabe o no responde debe marcar la alternativa 5."),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Qué tan satisfecho/a estás con el apoyo que tienes de tus familiares?"),
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                        "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”."),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Tiene amigos que lo visitan en su casa?"),
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

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                        "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”."),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Sientes que tienes alguna persona que te exprese afecto y ánimo?"),
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                        "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”."),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Sientes que tienes alguna persona que te aliente a expresar tus ideas y pensamientos?"),
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                        "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”."),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Sientes que tienes alguna persona que te pueda prestar ayuda económica?"),
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                        "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”."),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Sientes que tienes alguna persona a la cual le puedas contarle tus problemas?"),
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                        "●	Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”.\n"
                        "●	El/la encuestador/a debe leer solo las alternativas del 1 al 4. Si el/la usuario/a no sabe o no responde debe marcar la alternativa 5."),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Qué tan satisfecho/a estás contigo mismo(a)?"),
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "● Antes de realizar la pregunta, brindar el siguiente enunciado al Usuario:\n"
                        "“En esta pregunta le leeré las alternativas y al final usted me responde. Si no recuerda le leeré varias veces las alternativas”.\n"
                        "●	El/la encuestador/a debe leer solo las alternativas del 1 al 3. Si el/la usuario/a no sabe o no responde debe marcar la alternativa 4."),
                    HelpersViewLetrasSubs.formItemsDesign( "Desde que estás en el Programa CONTIGO, consideras que tu situación económica"),
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
                        HelpersViewLetrasSubsGris.formItemsDesignOPTIONTEXT("No sabe/ No responde"),
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

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Dejar que el Usuario se tome su tiempo para pensar en la respuesta y de ser "
                        "necesario repetirle la pregunta. Recuerde que no debe leer las alternativas.\n"
                        "●	No debe de inducir o sugerir respuestas a la pregunta formulada, como darle ejemplos. Solo si es necesario podría precisar al usuario/a que se le pregunta"
                        " sobre el principal problema en su hogar que lo ha tenido preocupado en este año.\n"
                        "● Si la respuesta es distinta a las presentadas, seleccione “Otro” (Especifique) y registre la información correspondiente.\n"
                        "●	Se debe indagar en la respuesta brindada y de acuerdo a orden de importancia marcar las tres principales preocupaciones.\n"
                        "●	Puede haber 3, 2, 1 o ninguna preocupación. "),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Cuáles han sido las mayores preocupaciones que han afectado tu bienestar durante el transcurso de este año 2024?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.circleAviso),

                    //BOTON DE SUBIR
                    GestureDetector(
                        onTap: ()  async {
                          if(
                          (1 == 2)
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

                    HelpersViewLetrasRojas.formItemsDesign( "IV) Acceso a la pensión no contributativa"),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a.\n"),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Conoce la última fecha de pago o cronograma de pagos de la pensión del Programa CONTIGO?"),
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Realizar la pregunta al usuario/a o cuidador/a.\n"
                        "●	Indagar sobre la respuesta brindada y marcar la que más se asemeje."),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Cómo se informó para saber la última fecha de pago o el cronograma de pagos de la Pensión del Programa CONTIGO?"),
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Si la respuesta del Usuario/a es diferente a las alternativas comprendidas entre el código 1 y el 4, "
                        "seleccione el código 5 “Otro” (Especifique) y registre la información correspondiente.\n"
                        "●	En el caso que el Usuario responda con el nombre de un mes en particular, marcar según la opción que corresponda.\n"
                        "●	Recuerde realizar el cálculo (en meses) según la respuesta que brinde el usuario/a."),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Cuándo fue la última vez que cobraste tu pensión del Programa CONTIGO?"),
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Si es necesario, al realizar la pregunta precisar que la última fecha de pago se refiere a los últimos 2 meses o menos.\n"
                        "● Si la respuesta del Usuario es diferente a las alternativas comprendidas entre el código 1 y el 6, seleccione el código 7 “Otro” (Especifique) y registre la información correspondiente."),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Por qué razón no cobraste tu pensión del Programa CONTIGO en la última fecha de pago?"),
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	La respuesta la puede brindar el usuario del programa, su cuidador o familiar autorizado para el cobro. \n"),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Quién realiza el cobro de su pensión del Programa CONTIGO?"),
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE( "●	Si en el último pago tuvo contratiempos (problemas en las vías u otro) deberá de repreguntar por el tiempo que suele "
                        "demorarse normalmente, donde no se da dichos contratiempos.\n"
                        "●	Sondear el tiempo y marcar la respuesta más idónea."),
                    HelpersViewLetrasSubs.formItemsDesign( "La última vez que cobraste tu pensión del Programa, ya sea de manera personal o a través de tu "
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE("●	De mencionar el usuario dos o más medios de movilización, deberá precisar que responda solo el "
                        "medio de transporte donde viaja más tiempo. "
                        "●	Si la respuesta del Usuario es diferente a las alternativas comprendidas entre el código 1 y el 10, seleccione el código 11 “Otro” "
                        "(Especifique) y registre la información correspondiente.\n"
                        "●	Sondear el tiempo y marcar la respuesta más idónea."),
                    HelpersViewLetrasSubs.formItemsDesign( "La última vez que cobraste tu pensión del Programa ya sea de manera "
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE("●	Considerar todos los medios de transporte que tuvieron algún costo "
                        "para el Usuario/a, tanto de ida como de retorno a su vivienda.\n"
                        "●	Recuerde registrar: Si no realiza gasto alguno anote en la respuesta cero “0”. "
                        "Si no recuerda el monto gastado en la última vez registre “9999”.\n"
                        "●	Si la persona va a pie al lugar de pago, debe registrar cero “0”."),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Cuánto gastaste o cuanto gastó tu familiar o cuánto gastaron en transporte de manera conjunta la última vez que "
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE("●	La respuesta la puede brindar el usuario del programa, su cuidador o familiar autorizado para el cobro."),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Bajo qué modalidad cobró la última vez el dinero otorgado por el Programa?"),
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE("●	Dejar que el Usuario se tome su tiempo para pensar en la respuesta y de ser "
                        "necesario repetirle la pregunta. Recuerde que no debe leer las alternativas.\n"
                        "●	No debe de inducir o sugerir respuestas a la pregunta formulada, ni brindarle algunas alternativas como ejemplo.\n"
                        "●	Si la respuesta del Usuario es diferente a las alternativas comprendidas entre el código 1 y el 11, seleccione el código 12 "
                        "“Otro” (Especifique) y registre la información correspondiente."),

                    HelpersViewLetrasSubs.formItemsDesign( "De acuerdo a la modalidad que cobra el dinero del Programa, actualmente, "
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE("●	La respuesta la puede brindar el usuario del programa, "
                        "su cuidador o familiar autorizado para el cobro."),
                    HelpersViewLetrasSubs.formItemsDesign( "Cada vez que vas a cobrar tu dinero del Programa, ¿Se te hace difícil, o "
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

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasSubs.formItemsDesignBLUE("●	Dejar que el Usuario se tome su tiempo para pensar en la respuesta y de ser "
                        "necesario repetirle la pregunta. Recuerde que no debe leer las alternativas.\n"
                        "●	Si la respuesta es distinta a las presentadas, seleccione “Otro” (Especifique) y registre la información correspondiente.\n"
                        "●	Se debe indagar en la respuesta brindada y de acuerdo a orden de importancia marcar los tres principales motivos.\n"
                        "●	Precisar que la dificultad debe estar referida al traslado del usuario/a al lugar de pago.\n"
                        "●	Puede haber 3, 2, 1 o ninguna preocupación.\n"),
                    HelpersViewLetrasSubs.formItemsDesign( "¿Cuáles son los tres principales motivos por los que se le hace difícil llegar al lugar de pago?"),
                    HelpersViewLetrasSubs.formItemsDesignGris(Constants.checkAviso),





                    GestureDetector(
                        onTap: ()  async {
                          if(
                          (1 == 2)
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

                    HelpersViewLetrasRojas.formItemsDesign( "V) Módulo del dinero"),

                    const SizedBox(height: 16.0),
                    HelpersViewLetrasSubs.formItemsDesignBLUE("●	La respuesta la puede brindar el usuario del programa, su cuidador o familiar autorizado para el cobro."),
                    HelpersViewLetrasSubs.formItemsDesign( "Normalmente, usted (usuario del Programa) decide sobre el uso o destino del cobro del dinero del Programa"),
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE("●	La respuesta la puede brindar el usuario del programa, su cuidador o familiar autorizado para el cobro."),
                    HelpersViewLetrasSubs.formItemsDesign( "En caso que usted no administre ni participa en el uso del dinero ¿Quién lo realiza?"),
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
                          'Persona autorizada para el cobro',
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
                    HelpersViewLetrasSubs.formItemsDesignBLUE("●	La respuesta la puede brindar el usuario del programa, su cuidador o familiar autorizado para el cobro.\n"
                        "●	Es importante recalcar al Usuario/a que la pregunta se refiere al gasto que normalmente realiza con la pensión que cobró.\n"
                        "●	Si la respuesta del Usuario es diferente a las alternativas comprendidas entre el código 1 y el 9, "
                        "seleccione el código 10 “Otro” (Especifique) y registre la información correspondiente.\n"
                        "●	La alternativa de “Invierte en negocio / activos productivos” considera el inicio de un "
                        "emprendimiento o la compra de herramientas, semillas o animales que le sirva de insumos para una actividad productiva."),
                    HelpersViewLetrasSubs.formItemsDesign( "Normalmente, ¿En qué se gasta principalmente el dinero que recibes del Programa?"),
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
                          (1 == 2)
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