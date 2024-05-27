import 'dart:async';
import 'package:animated_infinite_scroll_pagination/animated_infinite_scroll_pagination.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sicontigo/infraestructure/dao/apis/apiprovider_formulario.dart';
import 'package:sicontigo/infraestructure/dao/database/database.dart';
import 'package:sicontigo/infraestructure/dao/formdatamodeldao_formulario.dart';
import 'package:sicontigo/infraestructure/dao/formdatamodeldao_respuesta.dart';
import 'package:sicontigo/model/t_formulario.dart';
import 'package:sicontigo/model/t_respuesta.dart';
import 'package:sicontigo/utils/constantes.dart';
import 'package:sicontigo/utils/helpersviewAlertMensajeTitutlo.dart';
import 'package:sicontigo/utils/helpersviewLetrasSubsGris.dart';
import 'package:sicontigo/utils/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sicontigo/utils/resources_apis.dart';
import 'package:sicontigo/viewmodels/UI/menu_login.dart';
import 'package:sicontigo/viewmodels/UI/viewmodels/form_viewsmodel_formulario.dart';
import '../../model/t_insertarEncuestaRSPTA.dart';
import '../../utils/helpersviewAlertFaltaMSG.dart';
import '../../utils/helpersviewAlertProgressCircle.dart';
import '../../utils/helpersviewBlancoIcon.dart';
import '../../utils/helpersviewBlancoSelect.dart';
import '../../utils/helpersviewLetrasRojas.dart';
import '../../utils/helpersviewLetrasSubs.dart';
import '../../utils/helperviewCabecera.dart';
import 'menu_deOpcionesLISTADO.dart';


class MenudeOpcionesOffline extends StatefulWidget {

  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoRespuesta get formDataModelDao => _appDatabase.formDataModelDaoRespuesta;

  GlobalKey<FormState> keyForm = GlobalKey();
  //SIGUIENTE

  //P03
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




  //SIGUIENTE

  final ParamGestor = List.filled(3, "", growable: false);


  //ENVIAR LA DATA
  apiprovider_formulario apiForm = apiprovider_formulario();
  Respuesta? formData;
  MenudeOpcionesOffline(this.formData, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenudeOpcionesOffline();
  }

}

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

class _MenudeOpcionesOffline extends State<MenudeOpcionesOffline> {

  //ANTES TENIAN LATE
  String? PREFname;
  String? PREFapPaterno;
  String? PREFapMaterno;
  String? PREFnroDoc;
  String? PREFtypeUser;
  String? PREFtoken;

  String? GPSlatitude = "";
  String? GPSlongitude = "";
  String? GPSaltitude = "";

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

    /* BACKUP PERO ME TOMARIA 3 HORAS HACERLO
    if(widget.formData != null) {

      if (widget.formData!.observacion != null && widget.formData!.observacion!.isNotEmpty) {
        setState(() {
          widget.formIngresarObsCtrl!.text = widget.formData!.observacion!;
        });
      }

    } */

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
    bool mostrarLOADING = true;
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          Constants.tituloMenudeOpciones,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFD60000),
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

                  if(_CobroPension == CobroPension.Si){rpstP01 = "${rpstP01}Sí-A";}
                  else {rpstP01 = "${rpstP01}No-B";}
                  rpstP01 = "${rpstP01};";

                  if(_Tiempomeses == Tiempomeses.dos){rpstP02 = "${rpstP02}Dos-A";}
                  else {rpstP02 = "${rpstP02}Tres-B";}
                  rpstP02 = "${rpstP02};";

                  //3 meses oculto
                  if(isCheckedP03Distancia){rpstP03 = "${rpstP03}A,";}
                  if(isCheckedP03Acumular){rpstP03 = "${rpstP03}B,";}
                  if(isCheckedP03Noacompaniado){rpstP03 = "${rpstP03}C,";}
                  if(isCheckedP03Ahorrando){rpstP03 = "${rpstP03}D,,";}
                  if(isCheckedP03DificultarTrasladar){rpstP03 = "${rpstP03}E,";}
                  if(isCheckedP03OtroEspecificar){rpstP03 = "${rpstP03}F:${widget.formP03EspecificarCtrl!.text}";}
                  rpstP03 = "${rpstP03};";
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

                  if(_PensionRecibe == PensionRecibe.Totalmente){rpstP05 = "${rpstP05}Totalmente-A";}
                  else {rpstP05 = "${rpstP05}Parcialmente-B";}
                  rpstP05 = "${rpstP05};";

                  if(_TipoEstablecimientoSalud== TipoEstablecimientoSalud.sis){rpstP06 = "${rpstP06}SIS-A";}
                  if(_TipoEstablecimientoSalud== TipoEstablecimientoSalud.essalud){rpstP06 = "${rpstP06}ESSALUD-B";}
                  if(_TipoEstablecimientoSalud== TipoEstablecimientoSalud.policiales){rpstP06 = "${rpstP06}Armado-C";}
                  if(_TipoEstablecimientoSalud== TipoEstablecimientoSalud.privado){rpstP06 = "${rpstP06}Privado-D";}
                  if(_TipoEstablecimientoSalud== TipoEstablecimientoSalud.ninguno){rpstP06 = "${rpstP06}Ninguno-E";}
                  if(_TipoEstablecimientoSalud== TipoEstablecimientoSalud.nosabe){rpstP06 = "${rpstP06}NoSabe-F";}
                  if(_TipoEstablecimientoSalud== TipoEstablecimientoSalud.otro){rpstP06 = "${rpstP06}G:${widget.formP06EspecificarCtrl!.text}";}
                  rpstP06 = "${rpstP06};";

                  if(_SeAtendio == SeAtendio.Si){rpstP07 = "${rpstP07}Sí-A";}
                  else {rpstP07 = "${rpstP07}No-B";}
                  rpstP07 = "${rpstP07};";

                  //P08 si P07 es no
                  if(isCheckedP08NoCentro){rpstP08 = "${rpstP08}A,";}
                  if(isCheckedP08NoNecesito){rpstP08 = "${rpstP08}B,";}
                  if(isCheckedP08MetodoTradicional){rpstP08 = "${rpstP08}C,";}
                  if(isCheckedP08NoBuenTrato){rpstP08 = "${rpstP08}D,";}
                  if(isCheckedP08NoDoctores){rpstP08 = "${rpstP08}E,";}
                  if(isCheckedP08NoMedicina){rpstP08 = "${rpstP08}F,";}
                  if(isCheckedP08Otros){rpstP08 = "${rpstP08}G:${widget.formP08EspecificarCtrl!.text}";}
                  rpstP08 = "${rpstP08};";

                  //P09 si P07 es SI
                  if(isCheckedP09MedicinaGeneral){rpstP09 = "${rpstP09}A,";}
                  if(isCheckedP09Rehabilitacion){rpstP09 = "${rpstP09}B,";}
                  if(isCheckedP09Psicologia){rpstP09 = "${rpstP09}C,";}
                  if(isCheckedP09Odontologia){rpstP09 = "${rpstP09}D,";}
                  if(isCheckedP09Oftalmologia){rpstP09 = "${rpstP09}E,";}
                  if(isCheckedP09Ginecologia){rpstP09 = "${rpstP09}F,";}
                  if(isCheckedP09Otros){rpstP09 = "${rpstP09}G:${widget.formP09EspecificarCtrl!.text}";}
                  rpstP09 = "${rpstP09};";

                  //P10
                  if(_FrecuenciaAtiende== FrecuenciaAtiende.tiempoMes06){rpstP10 = "${rpstP10}A";}
                  if(_FrecuenciaAtiende== FrecuenciaAtiende.tiempoAno){rpstP10 = "${rpstP10}B";}
                  if(_FrecuenciaAtiende== FrecuenciaAtiende.tiempoMasdeUnAno){rpstP10 = "${rpstP10}C";}
                  rpstP10 = "${rpstP10};";

                  //HAY PUNTAJE!
                  if(_ViveUsted== ViveUsted.otrasConHijos){rpstP11 = "${rpstP11}ConOtros-A"; puntaje=puntaje+1;}
                  if(_ViveUsted== ViveUsted.otrasConHijosCuidado){rpstP11 = "${rpstP11}ConOtros-B"; puntaje=puntaje+2;}
                  if(_ViveUsted== ViveUsted.otrasEnPareja){rpstP11 = "${rpstP11}ConOtros-C"; puntaje=puntaje+3;}
                  if(_ViveUsted== ViveUsted.soloConHijos){rpstP11 = "${rpstP11}Solo-D"; puntaje=puntaje+4;}
                  if(_ViveUsted== ViveUsted.soloConFamiliares){rpstP11 = "${rpstP11}Solo-E"; puntaje=puntaje+5;}
                  rpstP11 = "${rpstP11};";


                  if(_TieneFamilia == TieneFamilia.Si){rpstP12 = "${rpstP12}Sí-A";}
                  else {rpstP12 = "${rpstP12}No-B,";}

                  if(_TieneFamiliaABCDE== TieneFamiliaABCDE.opcionA){rpstP12 = "${rpstP12}A";puntaje=puntaje+1;}
                  if(_TieneFamiliaABCDE== TieneFamiliaABCDE.opcionB){rpstP12 = "${rpstP12}B";puntaje=puntaje+2;}
                  if(_TieneFamiliaABCDE== TieneFamiliaABCDE.opcionC){rpstP12 = "${rpstP12}C";puntaje=puntaje+3;}
                  if(_TieneFamiliaABCDE== TieneFamiliaABCDE.opcionD){rpstP12 = "${rpstP12}D";puntaje=puntaje+4;}
                  if(_TieneFamiliaABCDE== TieneFamiliaABCDE.opcionE){rpstP12 = "${rpstP12}E";puntaje=puntaje+5;}
                  rpstP12 = "${rpstP12};";


                  if(_TieneAyudas == TieneAyudas.No){rpstP12 = "${rpstP12}No-A";puntaje=puntaje+1;}
                  else {rpstP12 = "${rpstP12}Sí-B,";}

                  if(_TieneAyudasABCD== TieneAyudasABCD.redInformalSUficiente){rpstP13 = "${rpstP13}A";puntaje=puntaje+2;}
                  if(_TieneAyudasABCD== TieneAyudasABCD.cuidadoraExterna){rpstP13 = "${rpstP13}B";puntaje=puntaje+3;}
                  if(_TieneAyudasABCD== TieneAyudasABCD.redInformalInsuficiente){rpstP13 = "${rpstP13}C";puntaje=puntaje+4;}
                  if(_TieneAyudasABCD== TieneAyudasABCD.noTieneApoyo){rpstP13 = "${rpstP13}D";puntaje=puntaje+5;}
                  rpstP13 = "${rpstP13};";

                  if(_IngresoEconomico== IngresoEconomico.recibenMas2050){rpstP11 = "${rpstP11}Ingresos-A";puntaje=puntaje+1;}
                  if(_IngresoEconomico== IngresoEconomico.recibenMas1537){rpstP11 = "${rpstP11}Ingresos-B";puntaje=puntaje+2;}
                  if(_IngresoEconomico== IngresoEconomico.recibenIgual1537){rpstP11 = "${rpstP11}Ingresos-C";puntaje=puntaje+3;}
                  if(_IngresoEconomico== IngresoEconomico.reciben1025){rpstP11 = "${rpstP11}Ingresos-D";puntaje=puntaje+4;}
                  if(_IngresoEconomico== IngresoEconomico.sinIngresosFijos){rpstP11 = "${rpstP11}SinIngresos-E";puntaje=puntaje+5;}
                  rpstP14 = "${rpstP14};";


                  if(_TipoVivienda == TipoVivienda.Si){rpstP15 = "${rpstP15}Adecuada-A";puntaje=puntaje+1;}
                  else {rpstP15 = "${rpstP15}Inadecuada-B,";puntaje=puntaje+2;}

                  if(_TipoViviendaABC== TipoViviendaABC.inadecuadaBarreras){rpstP15 = "${rpstP15}A";puntaje=puntaje+3;}
                  if(_TipoViviendaABC== TipoViviendaABC.inadecuadaSuministros){rpstP15 = "${rpstP15}B";puntaje=puntaje+4;}
                  if(_TipoViviendaABC== TipoViviendaABC.inadecuadaAusencia){rpstP15 = "${rpstP15}C";puntaje=puntaje+5;}
                  rpstP15 = "${rpstP15};";

                  //TERMINA EL PUNTAJE

                  if(_SituacionRiesgo == SituacionRiesgo.Si){rpstP12 = "${rpstP16}No-A";}
                  else {rpstP16 = "${rpstP16}Sí-B,";}

                  if(_SituacionRiesgoAB== SituacionRiesgoAB.relacionCobro){rpstP16 = "${rpstP16}A";}
                  if(_SituacionRiesgoAB== SituacionRiesgoAB.relacionSocioEconomico){rpstP16 = "${rpstP16}B";}
                  rpstP16 = "${rpstP16};";


                  //P17
                  if(isCheckedP17Cuidados){rpstP17 = "${rpstP17}A,";}
                  if(isCheckedP17ORehabilitacion){rpstP17 = "${rpstP17}B,";}
                  if(isCheckedP17Alimentacion){rpstP17 = "${rpstP17}C,";}
                  if(isCheckedP17Otros){rpstP17 = "${rpstP17}D:${widget.formP17EspecificarCtrl!.text},";}
                  rpstP17 = "${rpstP17};";

                  if(_TipoEmprendimiento == TipoEmprendimiento.Si){rpstP18 = "${rpstP18}Sí-A";}
                  else {rpstP18 = "${rpstP18}No-B";}
                  rpstP18 = "${rpstP18};";

                  //PREG 7 en ADELANTE
                  //ESTANDAR
                  // -puntaje en vez de puntaje, poner letras.
                  //DEL API ESTA LISTANDO USUARIOS DEL PROGRAMA
                  // P01 A, P02 B, P04,13, || P16 Si-A

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
                  widget.formData?.id_usuario = int.parse(PREFnroDoc!);
                  widget.formData?.fecha = formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());
                  widget.formData?.respuestas = respuestas;
                  widget.formData?.puntaje = puntaje;
                  widget.formData?.longitud = GPSlongitude;
                  widget.formData?.latitud = GPSlatitude;
                  //GPSlatitude

                  //FUNCION PARA SINCRONIZAR
                  //insertarEncuestaRSPTA rpta = await widget.apiForm.post_EnviarRspt(widget.formData!, PREFtoken);

                  //await GuardarFormulario();

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
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 440.0, // Set your minimum width here
              maxWidth: double.infinity, // Set your maximum width here
            ),
            child: Container(
              margin: const EdgeInsets.all(41.0),
              child: Form(
                //key: widget.keyForm,
                child: formUI(),
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
                          Widget ContactoRefererencia = MenudeOpcionesOffline(Respuesta());
                          Navigator.push(
                            context,
                            //MaterialPageRoute(builder: (context) =>  MenudeOpciones()),
                            MaterialPageRoute(builder: (context) =>  ContactoRefererencia),
                          );
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

  void htmlAgregado(String htmlcode) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      HelpersViewAlertMensajeTitulo.formItemsDesign(
                          "Se agrego el codigo HTML ${htmlcode}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Spacer(),
                          InkWell(
                            onTap: () async {

                              Navigator.pop(context);

                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, bottom: 20),
                              child: const Text(
                                "Entiendo",
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
    _CobroPension = null;
    _Tiempomeses = null;
    widget.formP03EspecificarCtrl!.clear();
    widget.formP08EspecificarCtrl!.clear();
    widget.formP09EspecificarCtrl!.clear();
    widget.formP17EspecificarCtrl!.clear();
    widget.formData = Respuesta();//


    setState(() {
      Fase1 = true;
      Fase2 = false;
      Fase3 = false;
      Fase4 = false;
      Fase5 = false;
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

  Widget formUI() {

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
                HelpersViewLetrasSubs.formItemsDesign( "Gestor social: ${PREFname} ${PREFapPaterno} ${PREFapMaterno}"),

                GestureDetector(
                    onTap: ()  {
                        setState(() {
                          Fase1 = false;
                          Fase2 = true;
                        });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color(0xFFD60000),
                      ),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text("Finalizar formulario",
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

                HelpersViewLetrasRojas.formItemsDesign( "Formulario (* Obligatorio)"),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "¿Usted ha realizado el cobro correspondiente al último padrón *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),
                Row(
                  children: [
                    const Text(
                      'Sí',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<CobroPension>(
                      value: CobroPension.Si,
                      groupValue: _CobroPension,
                      onChanged: (CobroPension? value) {
                        setState(() {
                          _CobroPension = value;
                        });
                      },
                    ),
                    const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<CobroPension>(
                      value: CobroPension.No,
                      groupValue: _CobroPension,
                      onChanged: (CobroPension? value) {
                        setState(() {
                          _CobroPension = value;
                        });
                      },),],
                ),

                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "Usualmente ¿Cada cuánto tiempo cobra la pensión? *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),
                Row(
                  children: [
                    const Text(
                      'Cada dos meses',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<Tiempomeses>(
                      value: Tiempomeses.dos,
                      groupValue: _Tiempomeses,
                      onChanged: (Tiempomeses? value) {
                        setState(() {
                          _Tiempomeses = value;
                          PregCada3meses = false;
                          PregCada2meses = true;
                          //DESACTIVA CHECKS DEL OTRO
                          isCheckedP03Distancia = false;
                          isCheckedP03Acumular = false;
                          isCheckedP03Noacompaniado = false;
                          isCheckedP03Ahorrando = false;
                          isCheckedP03DificultarTrasladar = false;
                          isCheckedP03OtroEspecificar = false;

                          //RESETEA EL INPUT
                          widget.formP03EspecificarCtrl!.clear();
                        });
                      },
                    ),
                    const Text(
                      'De 3 meses a más',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<Tiempomeses>(
                      value: Tiempomeses.tres,
                      groupValue: _Tiempomeses,
                      onChanged: (Tiempomeses? value) {
                        setState(() {
                          _Tiempomeses = value;
                          PregCada3meses = true;
                          PregCada2meses = false;
                          //DESACTIVA LOS CHECKS DEL OTRO
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
                          //RESETEA EL INPUT
                          widget.formP03EspecificarCtrl!.clear();
                        });
                      },),],
                ),

                const SizedBox(height: 16.0),
                ////

                Visibility(
                  visible: PregCada2meses,
                  child:Column(
                    children: <Widget>[
                      HelpersViewLetrasSubs.formItemsDesign( "Normalmente, de los 300 soles de la pensión que recibe ¿Cómo gasta el dinero? *"),
                      HelpersViewLetrasSubsGris.formItemsDesign(Constants.checkAviso),
                  Row(
                    children: [
                      const Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Alimentación (arroz, leche, papas, verduras,frutas,etc.).',
                            style: TextStyle(
                              fontSize: 14.0,
                              //color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Checkbox(
                          value: isCheckedP04Alimentacion,
                          onChanged: (bool? value) {
                            setState(() {
                              isCheckedP04Alimentacion = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),


                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Salud (pastillas, exámenes, inyecciones,jarabe,etc).',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP04Salud,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP04Salud = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Limpieza y Aseo (insumos de aseo personal y limpieza en el hogar).',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP04Limpieza,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP04Limpieza = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),


                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Rehabilitación.',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP04Rehabilitacion,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP04Rehabilitacion = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Educación (Pictogramas, cuadernos, regletas, pinturas, etc).',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP04Educacion,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP04Educacion = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Pago de servicios de agua y luz.',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP04PagoServicio,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP04PagoServicio = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Pago de servicios para acceso en comunicación (internet, celular, teléfono). ',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP04PagoComunicacion,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP04PagoComunicacion = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Transporte (para desplazarte al centro de salud, rehabilitación, centro de estudios, actividades de recreación o productivas etc). ',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP04Transporte,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP04Transporte = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),


                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Vestimenta.',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP04Vestimenta,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP04Vestimenta = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Recreación (Juegos, deporte, participación en espacios de la comunidad, etc).',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP04Recreacion,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP04Recreacion = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),


                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Ahorro para poder comprar equipos y acondicionamiento en el hogar.',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP04Ahorro,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP04Ahorro = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),


                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Ahorro para salud (operación, exámenes, etc).',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP04AhorroSalud,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP04AhorroSalud = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Otros Gastos.',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP04OtroGasto,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP04OtroGasto = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),


                      const SizedBox(height: 16.0),
                    ],),
                ),

                Visibility(
                  visible: PregCada3meses,
                  child:Column(
                    children: <Widget>[
                      HelpersViewLetrasSubs.formItemsDesign( "¿Por qué no cobra la pensión, cada dos meses? *"),
                      HelpersViewLetrasSubsGris.formItemsDesign(Constants.checkAviso),
                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Por la distancia y/o tiempo de traslado al punto de cobro.',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP03Distancia,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP03Distancia = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Deja que se acumule las pensiones por el elevado costo de transporte.',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP03Acumular,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP03Acumular = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'No tiene con quien ir o quien le acompañe a cobrar la pensión al banco, cajero o agente.',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP03Ahorrando,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP03Ahorrando = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Porque está ahorrando. (Para salud, estudios, compra de equipos, acondicionamiento en su hogar, etc).',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP03Noacompaniado,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP03Noacompaniado = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),


                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Es muy dificultoso trasladarse para el cobro de la pensión por su estado físico o de salud.',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP03DificultarTrasladar,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP03DificultarTrasladar = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Otro (especificar).',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: isCheckedP03OtroEspecificar,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedP03OtroEspecificar = value!;
                                  //RESETEA EL INPUT
                                  widget.formP03EspecificarCtrl!.clear();
                                });
                              },
                            ),
                          ),
                        ],
                      ),


                      //SE MUESTRA SI SE MARCA OTROS ESPECIFICAR

                      Visibility(
                      visible: isCheckedP03OtroEspecificar,
                      child:Column(
                      children: <Widget>[
                        HelpersViewBlancoIcon.formItemsDesign(
                            Icons.pending_actions,
                            TextFormField(
                              controller: widget.formP03EspecificarCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Especifique',
                              ),
                              validator: (value) {
                                return HelpersViewBlancoIcon.validateField(
                                    value!, widget.ParamP03EspecificarCtrl);
                              },
                              maxLength: 100,
                            ), context),

                      ]
                      )),


                      const SizedBox(height: 16.0),
                    ],),
                ),


                HelpersViewLetrasSubs.formItemsDesign( "¿La pensión que recibe el usuario, está destinada a sus necesidades: *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),
                Row(
                  children: [
                    const Text(
                      'Totalmente',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<PensionRecibe>(
                      value: PensionRecibe.Totalmente,
                      groupValue: _PensionRecibe,
                      onChanged: (PensionRecibe? value) {
                        setState(() {
                          _PensionRecibe = value;
                        });
                      },
                    ),
                    const Text(
                      'Parcialmente',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<PensionRecibe>(
                      value: PensionRecibe.Parcialmente,
                      groupValue: _PensionRecibe,
                      onChanged: (PensionRecibe? value) {
                        setState(() {
                          _PensionRecibe = value;
                        });
                      },),],
                ),

                /////

                const SizedBox(height: 16.0),

                //BOTON PARA PRESEGUIR

                GestureDetector(
                    onTap: ()  {

                      if(
                      (_CobroPension == null) ||
                      (_Tiempomeses == null) ||
                      (_PensionRecibe == null) ||
                      (//CADA 2 meses lamenos uno marcado
                          !isCheckedP04Alimentacion &&
                          !isCheckedP04Salud &&
                          !isCheckedP04Limpieza &&
                          !isCheckedP04Rehabilitacion &&
                          !isCheckedP04Educacion &&
                          !isCheckedP04PagoServicio &&
                          !isCheckedP04PagoComunicacion &&
                          !isCheckedP04Transporte &&
                          !isCheckedP04Vestimenta &&
                          !isCheckedP04Recreacion &&
                          !isCheckedP04Ahorro &&
                          !isCheckedP04AhorroSalud &&
                          !isCheckedP04OtroGasto &&
                        //CADA 3 meses lamenos uno marcado
                          !isCheckedP03Distancia  &&
                          !isCheckedP03Acumular  &&
                          !isCheckedP03Noacompaniado  &&
                          !isCheckedP03Ahorrando  &&
                          !isCheckedP03DificultarTrasladar  &&
                        (widget.formP03EspecificarCtrl == null || widget.formP03EspecificarCtrl!.text.isEmpty)
                      )
                      ){
                        showDialogValidFields(Constants.faltanCampos);
                      } else {
                        setState(() {
                          Fase2 = false;
                          Fase3 = true;
                        });
                      }

                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color(0xFFD60000),
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

                HelpersViewLetrasRojas.formItemsDesign( "SALUD"),
                const SizedBox(height: 16.0),
                HelpersViewLetrasSubs.formItemsDesign( "Actualmente. ¿A qué tipo de establecimiento de Salud, acude con frecuencia? *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '¿Seguro integral de salud (SIS)?',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<TipoEstablecimientoSalud>(
                        value: TipoEstablecimientoSalud.sis,
                        groupValue: _TipoEstablecimientoSalud,
                        onChanged: (TipoEstablecimientoSalud? value) {
                          setState(() {
                            _TipoEstablecimientoSalud = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '¿ESSALUD?',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<TipoEstablecimientoSalud>(
                        value: TipoEstablecimientoSalud.essalud,
                        groupValue: _TipoEstablecimientoSalud,
                        onChanged: (TipoEstablecimientoSalud? value) {
                          setState(() {
                            _TipoEstablecimientoSalud = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '¿Seguro de fuerzas armadas o policiales?',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<TipoEstablecimientoSalud>(
                        value: TipoEstablecimientoSalud.policiales,
                        groupValue: _TipoEstablecimientoSalud,
                        onChanged: (TipoEstablecimientoSalud? value) {
                          setState(() {
                            _TipoEstablecimientoSalud = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '¿Seguro privado de salud?',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<TipoEstablecimientoSalud>(
                        value: TipoEstablecimientoSalud.privado,
                        groupValue: _TipoEstablecimientoSalud,
                        onChanged: (TipoEstablecimientoSalud? value) {
                          setState(() {
                            _TipoEstablecimientoSalud = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Ninguno.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<TipoEstablecimientoSalud>(
                        value: TipoEstablecimientoSalud.ninguno,
                        groupValue: _TipoEstablecimientoSalud,
                        onChanged: (TipoEstablecimientoSalud? value) {
                          setState(() {
                            _TipoEstablecimientoSalud = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'No sabe.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<TipoEstablecimientoSalud>(
                        value: TipoEstablecimientoSalud.nosabe,
                        groupValue: _TipoEstablecimientoSalud,
                        onChanged: (TipoEstablecimientoSalud? value) {
                          setState(() {
                            _TipoEstablecimientoSalud = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Otro (especificar)',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<TipoEstablecimientoSalud>(
                        value: TipoEstablecimientoSalud.otro,
                        groupValue: _TipoEstablecimientoSalud,
                        onChanged: (TipoEstablecimientoSalud? value) {
                          setState(() {
                            _TipoEstablecimientoSalud = value;
                          });
                        },),
                    ),
                  ],
                ),

                //OTRO ESPECIFICAR

                Visibility(
                    visible: (_TipoEstablecimientoSalud == TipoEstablecimientoSalud.otro),
                    child:Column(
                        children: <Widget>[
                          HelpersViewBlancoIcon.formItemsDesign(
                              Icons.pending_actions,
                              TextFormField(
                                controller: widget.formP06EspecificarCtrl,
                                decoration: const InputDecoration(
                                  labelText: 'Especifique',
                                ),
                                validator: (value) {
                                  return HelpersViewBlancoIcon.validateField(
                                      value!, widget.ParamP06EspecificarCtrl);
                                },
                                maxLength: 100,
                              ), context),
                        ]
                    )),


                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "¿Se ha atendido en algún centro de salud/ puesto de salud/posta médica u hospital? *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),
                Row(
                  children: [
                    const Text(
                      'Sí',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<SeAtendio>(
                      value: SeAtendio.Si,
                      groupValue: _SeAtendio,
                      onChanged: (SeAtendio? value) {
                        setState(() {
                          _SeAtendio = value;
                          isCheckedP08NoCentro = false;
                          isCheckedP08NoNecesito= false;
                          isCheckedP08MetodoTradicional = false;
                          isCheckedP08NoBuenTrato= false;
                          isCheckedP08NoDoctores = false;
                          isCheckedP08NoMedicina = false;
                          isCheckedP08Otros = false;
                          isCheckedP09MedicinaGeneral = false;
                          isCheckedP09Rehabilitacion= false;
                          isCheckedP09Psicologia = false;
                          isCheckedP09Odontologia = false;
                          isCheckedP09Oftalmologia = false;
                          isCheckedP09Ginecologia = false;
                          isCheckedP09Otros = false;
                          widget.formP08EspecificarCtrl!.clear();
                          widget.formP09EspecificarCtrl!.clear();
                        });
                      },
                    ),
                    const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Radio<SeAtendio>(
                      value: SeAtendio.No,
                      groupValue: _SeAtendio,
                      onChanged: (SeAtendio? value) {
                        setState(() {
                          _SeAtendio = value;
                          isCheckedP08NoCentro = false;
                          isCheckedP08NoNecesito= false;
                          isCheckedP08MetodoTradicional = false;
                          isCheckedP08NoBuenTrato= false;
                          isCheckedP08NoDoctores = false;
                          isCheckedP08NoMedicina = false;
                          isCheckedP08Otros = false;
                          isCheckedP09MedicinaGeneral = false;
                          isCheckedP09Rehabilitacion= false;
                          isCheckedP09Psicologia = false;
                          isCheckedP09Odontologia = false;
                          isCheckedP09Oftalmologia = false;
                          isCheckedP09Ginecologia = false;
                          isCheckedP09Otros = false;
                          widget.formP08EspecificarCtrl!.clear();
                          widget.formP09EspecificarCtrl!.clear();
                        });
                      },),],
                ),

                Visibility(
                    visible: (_SeAtendio == SeAtendio.No),
                    child:Column(
                        children: <Widget>[
                          const SizedBox(height: 16.0),
                          HelpersViewLetrasSubs.formItemsDesign( "¿Por qué no se atendió en algún centro de salud, puesto de salud/posta médica u hospital? *"),
                          HelpersViewLetrasSubsGris.formItemsDesign(Constants.checkAviso),

                          Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'No hay centro de salud, posta médica u hospital cercano.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Checkbox(
                                  value: isCheckedP08NoCentro ,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedP08NoCentro  = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'No lo necesito/ se encontraba bien de salud.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Checkbox(
                                  value: isCheckedP08NoNecesito,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedP08NoNecesito= value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Uso métodos tradicionales (hierbas,curanderos, hueseros, etc.) para curarse.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Checkbox(
                                  value: isCheckedP08MetodoTradicional ,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedP08MetodoTradicional  = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'La última vez no lo/a trataron bien.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Checkbox(
                                  value: isCheckedP08NoBuenTrato,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedP08NoBuenTrato = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'No hay doctores o especialistas que lo/la atiendan.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Checkbox(
                                  value: isCheckedP08NoDoctores,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedP08NoDoctores = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'No le dieron medicinas adecuadas/ No hay medicinas.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Checkbox(
                                  value: isCheckedP08NoMedicina,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedP08NoMedicina = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Otro (Especificar).',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Checkbox(
                                  value: isCheckedP08Otros,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedP08Otros = value!;
                                      //RESETEA EL INPUT
                                      widget.formP08EspecificarCtrl!.clear();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          Visibility(
                              visible: isCheckedP08Otros,
                              child:Column(
                                  children: <Widget>[
                                    HelpersViewBlancoIcon.formItemsDesign(
                                        Icons.pending_actions,
                                        TextFormField(
                                          controller: widget.formP08EspecificarCtrl,
                                          decoration: const InputDecoration(
                                            labelText: 'Especifique',
                                          ),
                                          validator: (value) {
                                            return HelpersViewBlancoIcon.validateField(
                                                value!, widget.ParamP08EspecificarCtrl);
                                          },
                                          maxLength: 100,
                                        ), context),
                                  ]
                              )),
                        ])),

                Visibility(
                    visible: (_SeAtendio == SeAtendio.Si),
                    child:Column(
                        children: <Widget>[
                          const SizedBox(height: 16.0),
                          HelpersViewLetrasSubs.formItemsDesign( "¿Cuáles son los servicios a los que accede con mayor frecuencia, cuando se atiende en el centro de salud, puesto de salud/posta médica u hospital? *"),
                          HelpersViewLetrasSubsGris.formItemsDesign(Constants.checkAviso),

                          Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Medicina General.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Checkbox(
                                  value: isCheckedP09MedicinaGeneral ,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedP09MedicinaGeneral  = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Rehabilitación.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Checkbox(
                                  value: isCheckedP09Rehabilitacion,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedP09Rehabilitacion=  value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Psicología.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Checkbox(
                                  value: isCheckedP09Psicologia ,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedP09Psicologia  = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Odontología.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Checkbox(
                                  value: isCheckedP09Odontologia,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedP09Odontologia=  value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Oftalmología.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Checkbox(
                                  value: isCheckedP09Oftalmologia ,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedP09Oftalmologia  = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Ginecología.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Checkbox(
                                  value: isCheckedP09Ginecologia ,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedP09Ginecologia  = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Otro (especificar).',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Checkbox(
                                  value: isCheckedP09Otros ,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedP09Otros  = value!;
                                      //RESETEA INPUT
                                      widget.formP09EspecificarCtrl!.clear();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          Visibility(
                              visible: isCheckedP09Otros,
                              child:Column(
                                  children: <Widget>[
                                    HelpersViewBlancoIcon.formItemsDesign(
                                        Icons.pending_actions,
                                        TextFormField(
                                          controller: widget.formP09EspecificarCtrl,
                                          decoration: const InputDecoration(
                                            labelText: 'Especifique',
                                          ),
                                          validator: (value) {
                                            return HelpersViewBlancoIcon.validateField(
                                                value!, widget.ParamP09EspecificarCtrl);
                                          },
                                          maxLength: 100,
                                        ), context),
                                  ]
                              )),
                        ])),

                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "¿Con qué frecuencia se atiende en el centro de salud, puesto de salud/posta médica u hospital?"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'De 0 a 6 meses.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<FrecuenciaAtiende>(
                        value: FrecuenciaAtiende.tiempoMes06,
                        groupValue: _FrecuenciaAtiende,
                        onChanged: (FrecuenciaAtiende? value) {
                          setState(() {
                            _FrecuenciaAtiende = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'De 6 meses a 1 año.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<FrecuenciaAtiende>(
                        value: FrecuenciaAtiende.tiempoAno,
                        groupValue: _FrecuenciaAtiende,
                        onChanged: (FrecuenciaAtiende? value) {
                          setState(() {
                            _FrecuenciaAtiende = value;
                          });
                        },),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'De un año a más.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Radio<FrecuenciaAtiende>(
                        value: FrecuenciaAtiende.tiempoMasdeUnAno,
                        groupValue: _FrecuenciaAtiende,
                        onChanged: (FrecuenciaAtiende? value) {
                          setState(() {
                            _FrecuenciaAtiende = value;
                          });
                        },),
                    ),
                  ],
                ),


                GestureDetector(
                    onTap: ()  {
                      if(
                      (_TipoEstablecimientoSalud == null) ||
                      (_SeAtendio == null) ||
                      (//SI MARCO NO
                      !isCheckedP08NoCentro  &&
                      !isCheckedP08NoNecesito  &&
                      !isCheckedP08MetodoTradicional  &&
                      !isCheckedP08NoBuenTrato  &&
                      !isCheckedP08NoDoctores  &&
                      !isCheckedP08NoMedicina &&
                      (widget.formP08EspecificarCtrl == null || widget.formP08EspecificarCtrl!.text.isEmpty) &&
                      //SI MARCO SI
                      !isCheckedP09MedicinaGeneral   &&
                      !isCheckedP09Rehabilitacion   &&
                      !isCheckedP09Psicologia   &&
                      !isCheckedP09Odontologia   &&
                      !isCheckedP09Oftalmologia   &&
                      !isCheckedP09Ginecologia  &&
                      (widget.formP09EspecificarCtrl == null || widget.formP09EspecificarCtrl!.text.isEmpty)
                      ) ||
                      (_FrecuenciaAtiende == null)

                      ){
                        showDialogValidFields(Constants.faltanCampos);
                      } else {
                        setState(() {
                          Fase3 = false;
                          Fase4 = true;
                        });
                      }

                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color(0xFFD60000),
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

                HelpersViewLetrasRojas.formItemsDesign( "VALORACION SOCIO FAMILIAR - OBSERVACION DEL GESTOR"),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "¿Con quién vive usted? *"),
                HelpersViewLetrasSubsGris.formItemsDesign(Constants.circleAviso),

                Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Vive con otras personas (en pareja y/o familia) y hay hijos/as u otros familiares que requiere de cuidados.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Vive con otras personas (en pareja o familia), requiere de cuidados, haya o no hijos/as u otros familiares que lo ayuden.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Vive con otras personas (en pareja y/o con familiares) de edad avanzada, con/sin hijos/as con dificultades, capacidad y/o disponibilidad para prestar cuidados de larga duración.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Vive solo y hay hijos o familia con limitaciones en capacidad, disponibilidad o disposición para cuidarlo/a.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Vive solo, con familiares que está distante (física o afectivamente) y presenta falta de cuidados.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                      const Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '¿Ha recibido visita de algún familiar, suele visitarlos por lo menos una vez a la semana? o durante la semana participa en alguna actividad pública.',
                            style: TextStyle(
                              fontSize: 14.0,
                              //color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Suele salir fuera de su domicilio y se mantiene activa/o con familiares, amigos, vecinos, lo ha hecho en esta semana.',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
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
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Suele salir fuera de su hogar, con o sin compañía, por lo menos una vez a la semana.',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
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
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Recibe visita de algún familiar en su hogar? Por lo menos una vez por semana.',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
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
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'No recibe visitas, no sale a la calle, se encuentra en aislamiento social.',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  //color: Colors.white,
                                ),
                              ),
                            ),
                          ),
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
                        const Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Requiere ayuda y la recibe de la red informal y/o formal y es suficiente.',
                              style: TextStyle(
                                fontSize: 14.0,
                                //color: Colors.white,
                              ),
                            ),
                          ),
                        ),
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
                        const Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Requiere ayuda y la recibe en su mayor parte de una persona cuidadora externa (privada).',
                              style: TextStyle(
                                fontSize: 14.0,
                                //color: Colors.white,
                              ),
                            ),
                          ),
                        ),
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
                        const Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Requiere ayuda y la recibe de la red informal y/o formal y es insuficiente.',
                              style: TextStyle(
                                fontSize: 14.0,
                                //color: Colors.white,
                              ),
                            ),
                          ),
                        ),
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
                        const Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Requiere ayuda y no tiene apoyo de la red de recursos (formal/informal) y/o no se puede ejercer.',
                              style: TextStyle(
                                fontSize: 14.0,
                                //color: Colors.white,
                              ),
                            ),
                          ),
                        ),
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
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '¿Reciben  más de S/2,050 mensualmente?',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '¿Reciben más de S/ 1537.50 hasta S/ 2,050 mensualmente?.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '¿Reciben mas de S/ 1025 hasta S/ 1537.50 mensualmente?',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Reciben igual o menos de S/ 1025 mensualmente.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Sin ingresos fijos.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                    onTap: ()  {
                      if(
                      (_TipoEstablecimientoSalud == null) ||
                      (_SeAtendio == null)

                      ){
                        showDialogValidFields(Constants.faltanCampos);
                      } else {
                        setState(() {
                          Fase4 = false;
                          Fase5 = true;
                        });
                      }

                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color(0xFFD60000),
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
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Inadecuada: Barreras arquitectónicas internas en el domicilio.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
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
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Inadecuada: Falta uno o más suministros y/o dos o más equipamientos.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
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
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Inadecuada: Ausencia de vivienda, infravivienda.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
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
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'En relación al cobro.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
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
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'En relación a riesgo socioemocional.',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
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
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Cuidados de la PCDS.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Rehabilitación.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Alimentación.',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                    const Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Otro (Especificar)',
                          style: TextStyle(
                            fontSize: 14.0,
                            //color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                                controller: widget.formP09EspecificarCtrl,
                                decoration: const InputDecoration(
                                  labelText: 'Especifique',
                                ),
                                validator: (value) {
                                  return HelpersViewBlancoIcon.validateField(
                                      value!, widget.ParamP09EspecificarCtrl);
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
                    onTap: ()  {
                      setState(() {
                        Fase5 = false;
                        Fase6 = true;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Color(0xFFD60000),
                      ),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text("Iniciar con el formulario",
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

                HelpersViewLetrasSubs.formItemsDesign( "Realize click en el boton del satelite y luego en el diskete para guardar"),

              ],),
          ),

        ],),
    );
  }
}
