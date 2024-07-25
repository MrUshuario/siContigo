import 'dart:async';
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
import '../../infraestructure/dao/formdatamodeldao_respuestaBACKUPtresvisita.dart';
import '../../model/t_insertarEncuestaRSPTA.dart';
import '../../model/t_padron.dart';
import '../../model/utils/camera.dart';
import '../../model/utils/viewdisplayfoto.dart';
import '../../model/visitaDomiciliaria/t_respBackupprimeravisita.dart';
import '../../model/visitaDomiciliaria/t_respBackupsegundavisita.dart';
import '../../model/visitaDomiciliaria/t_respBackupterceravisita.dart';
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


class MenudeOpcionesVisitaTres extends StatefulWidget {

  final _appDatabase = GetIt.I.get<AppDatabase>();
  FormDataModelDaoRespuestaunovisita get formDataModelDao => _appDatabase.formDataModelDaoRespuesta;
  FormDataModelDaoRespuestaBACKUPtresvisita get formDataModelDaoBackup => _appDatabase.formDataModelDaoRespuestaBACKUPtresvisita;

  //PADRON
  FormDataModelDaoPadron get padronsql => _appDatabase.formDataModelDaoPadron;

  List<String> listMediaPath = List.empty(growable: true);

  GlobalKey<FormState> keyForm = GlobalKey();
  //SIGUIENTE
  TextEditingController formIdUsuario = TextEditingController();
  TextEditingController formNombreUsuario = TextEditingController();

  //P0
  TextEditingController p01EspecificarCtrl = TextEditingController();
  final Paramp01EspecificarCtrl = List.filled(3, "", growable: false);
  TextEditingController p01P1EspecificarCtrl = TextEditingController();
  final Paramp01P1EspecificarCtrl = List.filled(3, "", growable: false);
  TextEditingController p02EspecificarCtrl = TextEditingController();
  final Paramp02EspecificarCtrl = List.filled(3, "", growable: false);
  TextEditingController p03EspecificarCtrl = TextEditingController();
  final Paramp03EspecificarCtrl = List.filled(3, "", growable: false);
  TextEditingController p04EspecificarCtrl = TextEditingController();
  final Paramp04EspecificarCtrl = List.filled(3, "", growable: false);
  TextEditingController p05EspecificarCtrl = TextEditingController();
  final Paramp05EspecificarCtrl = List.filled(3, "", growable: false);
  TextEditingController p06EspecificarCtrl = TextEditingController();
  final Paramp06EspecificarCtrl = List.filled(3, "", growable: false);
  TextEditingController p07EspecificarCtrl = TextEditingController();
  final Paramp07EspecificarCtrl = List.filled(3, "", growable: false);
  TextEditingController p08EspecificarCtrl = TextEditingController();
  final Paramp08EspecificarCtrl = List.filled(3, "", growable: false);
  TextEditingController p09EspecificarCtrl = TextEditingController();
  final Paramp09EspecificarCtrl = List.filled(3, "", growable: false);
  TextEditingController p09P1EspecificarCtrl = TextEditingController();
  final Paramp09P1EspecificarCtrl = List.filled(3, "", growable: false);
  TextEditingController p09P2EspecificarCtrl = TextEditingController();
  final Paramp09P2EspecificarCtrl = List.filled(3, "", growable: false);
  TextEditingController p10EspecificarCtrl = TextEditingController();
  final Paramp10EspecificarCtrl = List.filled(3, "", growable: false);
  TextEditingController p10P1EspecificarCtrl = TextEditingController();
  final Paramp10P1EspecificarCtrl = List.filled(3, "", growable: false);


  //BACKUP
  bool backup = false;



  //SIGUIENTE

  final ParamGestor = List.filled(3, "", growable: false);


  //ENVIAR LA DATA
  apiprovider_formulario apiForm = apiprovider_formulario();
  RespuestaPrimeraVisita? formData;
  RespuestaBACKUPterceravisita? formDataBACKUP = RespuestaBACKUPterceravisita();
  MenudeOpcionesVisitaTres(this.formData, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenudeOpcionesVisitaTres();
  }

}



class _MenudeOpcionesVisitaTres extends State<MenudeOpcionesVisitaTres> {

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

  String rpstP01 = "P01 ";
  String rpstP01P1 = "P01.1 ";
  String rpstP02 = " P02 ";
  String rpstP03 = " P03 ";
  String rpstP04 = " P04 ";
  String rpstP05 = " P05 ";
  String rpstP06 = " P06 ";
  String rpstP07 = " P07 ";
  String rpstP08 = " P08 ";
  String rpstP09 = " P09 ";
  String rpstP09P1 = " P09.1 ";
  String rpstP09P2 = " P09.2 ";
  String rpstP10 = " P10 ";
  String rpstP10P1 = "P010.1 ";
  int puntaje = 0;

  //BACKUP
  List <RespuestaBACKUPterceravisita> listBackup = List.empty();

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

      if(GPSlatitude == ""){
        print("NO COORDENADAS");

      } else {
        print("HAY COORDENADAS");
        isSatelliteGreen = true;
      }


    });
  }



  @override
  void initState() {
    conseguirVersion();
    revisarBackup();
    ConseguirHora();
    widget.formData?.tipoencuesta = Resources.valor_terceraVisita;
    if(widget.formData != null) {

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

    }

    // TODO: implement initState
    super.initState();
  }

  final _OE1 = SuperTooltipController();
  final _OE2 = SuperTooltipController();
  final _OE3 = SuperTooltipController();
  final _OE4 = SuperTooltipController();









  bool isSatelliteGreen=false;

  bool Fase1 = true;
  bool Fase2 = false;
  bool Fase3 = false;
  bool Fase4 = false;
  bool Fase5 = false;
  bool Fase6 = false;


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

    //widget.formData?.tipoencuesta = Resources.valor_terceraVisita;
    widget.formData?.nombre_usuario =widget.formNombreUsuario!.text;
    widget.formDataBACKUP?.nombre_usuario = widget.formNombreUsuario!.text;
    widget.formData?.id_usuario = widget.formIdUsuario!.text;
    widget.formDataBACKUP?.id_usuario =widget.formIdUsuario!.text;
    await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }


  Future<void> guardadoFase2() async{

    rpstP01 = "${rpstP01}${widget.p01EspecificarCtrl!.text};";
    //widget.formData?.p01visita3 =widget.p01EspecificarCtrl!.text;
    //widget.formDataBACKUP?.p01visita3 =widget.p01EspecificarCtrl!.text;

    rpstP01P1 = "${rpstP01P1}${widget.p01P1EspecificarCtrl!.text};";
    //widget.formData?.p01visita3 =widget.p01P1EspecificarCtrl!.text;
    //widget.formDataBACKUP?.p01visita3 =widget.p01P1EspecificarCtrl!.text;

    rpstP02 = "${rpstP02}${widget.p02EspecificarCtrl!.text};";
    //widget.formData?.p01visita3 =widget.p02EspecificarCtrl!.text;
    //widget.formDataBACKUP?.p01visita3 =widget.p02EspecificarCtrl!.text;

    rpstP03 = "${rpstP03}${widget.p03EspecificarCtrl!.text};";
    //widget.formData?.p01visita3 =widget.p03EspecificarCtrl!.text;
    //widget.formDataBACKUP?.p01visita3 =widget.p03EspecificarCtrl!.text;

    rpstP04 = "${rpstP04}${widget.p04EspecificarCtrl!.text};";
    //widget.formData?.p01visita3 =widget.p04EspecificarCtrl!.text;
    //widget.formDataBACKUP?.p01visita3 =widget.p04EspecificarCtrl!.text;

    rpstP05 = "${rpstP05}${widget.p05EspecificarCtrl!.text};";
    //widget.formData?.p01visita3 =widget.p05EspecificarCtrl!.text;
    //widget.formDataBACKUP?.p01visita3 =widget.p05EspecificarCtrl!.text;

    rpstP06 = "${rpstP06}${widget.p06EspecificarCtrl!.text};";
    //widget.formData?.p01visita3 =widget.p06EspecificarCtrl!.text;
    //widget.formDataBACKUP?.p01visita3 =widget.p06EspecificarCtrl!.text;

    rpstP07 = "${rpstP07}${widget.p07EspecificarCtrl!.text};";
    //widget.formData?.p01visita3 =widget.p07EspecificarCtrl!.text;
    //widget.formDataBACKUP?.p01visita3 =widget.p07EspecificarCtrl!.text;

    rpstP08 = "${rpstP08}${widget.p08EspecificarCtrl!.text};";
    //widget.formData?.p01visita3 =widget.p08EspecificarCtrl!.text;
    //widget.formDataBACKUP?.p01visita3 =widget.p08EspecificarCtrl!.text;

    rpstP09 = "${rpstP09}${widget.p09EspecificarCtrl!.text};";
    //widget.formData?.p01visita3 =widget.p09EspecificarCtrl!.text;
    //widget.formDataBACKUP?.p01visita3 =widget.p09EspecificarCtrl!.text;

    rpstP09P1 = "${rpstP09P1}${widget.p09P1EspecificarCtrl!.text};";
    //widget.formData?.p01visita3 =widget.p09P1EspecificarCtrl!.text;
    //widget.formDataBACKUP?.p01visita3 =widget.p09P1EspecificarCtrl!.text;

    rpstP09P2 = "${rpstP09P2}${widget.p09P2EspecificarCtrl!.text};";
    //widget.formData?.p01visita3 =widget.p09P2EspecificarCtrl!.text;
    //widget.formDataBACKUP?.p01visita3 =widget.p09P2EspecificarCtrl!.text;

    rpstP10 = "${rpstP10}${widget.p10EspecificarCtrl!.text};";
    //widget.formData?.p01visita3 =widget.p10EspecificarCtrl!.text;
    //widget.formDataBACKUP?.p01visita3 =widget.p10EspecificarCtrl!.text;

    rpstP10P1 = "${rpstP10P1}${widget.p10P1EspecificarCtrl!.text};";
    //widget.formData?.p01visita3 =widget.p10P1EspecificarCtrl!.text;
    //widget.formDataBACKUP?.p01visita3 =widget.p10P1EspecificarCtrl!.text;


    //await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase3() async{

    //await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase4() async{

    //await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
  }

  Future<void> guardadoFase5() async{

    //await widget.formDataModelDaoBackup.insertFormDataModel(widget.formDataBACKUP!);
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
          Constants.tituloMenudeOpcionestres,
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
                      '$rpstP01$rpstP01P1$rpstP02$rpstP03$rpstP04$rpstP05$rpstP06$rpstP07'
                      '$rpstP08$rpstP09$rpstP09P1$rpstP09P2$rpstP10$rpstP10P1'
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
                  widget.formData?.puntaje =  puntaje;
                  widget.formData?.longitud = GPSlongitude;
                  widget.formData?.latitud = GPSlatitude;
                  widget.formData?.id_usuario = widget.formIdUsuario.text;
                  //widget.formData?.tipoencuesta = Resources.valor_terceraVisita;
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
    widget.formIdUsuario!.clear();
    widget.formData = RespuestaPrimeraVisita();////
    widget.formNombreUsuario!.clear();
    setState(() {
      Fase1 = true;
      Fase2 = false;
      Fase3 = false;
      Fase4 = false;
      Fase5 = false;
      Fase6 = false;
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[

          Visibility(
            visible: Fase1,
            child:Column(
              children: <Widget>[

                HelpersViewLetrasRojas.formItemsDesign( "Inicio del cuestionario"),
                const SizedBox(height: 16.0),
                HelpersViewLetrasSubs.formItemsDesign( "Gestor social: ${PREFname} ${PREFapPaterno} ${PREFapMaterno}"),
                HelpersViewLetrasSubs.formItemsDesignGris( "Hora Inicio: ${horaFecha}"),
                //PONER AQUI
                const SizedBox(height: 16.0),
                HelpersViewLetrasToolTip(message: "●	Validar los datos registrados por la persona usuaria y/o cuidadora en el proceso de afiliación.",
                    controller: _OE1),

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

                HelpersViewLetrasRojas.formItemsDesign( "MATRIZ DE CONSISTENCIA TERCERA VISITA"),
                const SizedBox(height: 16.0),
                HelpersViewLetrasRojas.formItemsDesign( "CUESTIONARIO N° 3"),


                const SizedBox(height: 16.0),
                HelpersViewLetrasToolTip(message: "●	Objetivo: Registrar y hacer el seguimiento a las metas de "
                    "corto y mediano plazo, establecidas en el plan de metas concretas de la persona con discapacidad.",
                    controller: _OE2),
                HelpersViewLetrasSubs.formItemsDesign( "1) ¿Se logró cumplir con las metas concretas de corto y/o mediano plazo?"),

                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.p01EspecificarCtrl,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.Paramp01EspecificarCtrl);
                            },
                            maxLength: 100,
                          ), context),

                    ]
                ),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "1.1) ¿En qué medida se dio el cumplimiento?"),

                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.p01P1EspecificarCtrl,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.Paramp01P1EspecificarCtrl);
                            },
                            maxLength: 100,
                          ), context),

                    ]
                ),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "2) ¿Qué dificultades encontró para no realizar sus metas de corto y mediano plazo?"),

                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.p02EspecificarCtrl,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.Paramp02EspecificarCtrl);
                            },
                            maxLength: 100,
                          ), context),

                    ]
                ),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "3) ¿De qué manera considera usted que el Programa "
                    "Contigo lo pueda apoyar a lograr sus metas de corto o mediano plazo?"),

                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.p03EspecificarCtrl,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.Paramp03EspecificarCtrl);
                            },
                            maxLength: 100,
                          ), context),

                    ]
                ),
                const SizedBox(height: 16.0),
                HelpersViewLetrasToolTip(message: "●	Verificar la situación de riesgo social de la persona con discapacidad severa, usuario de Programa Contigo.",
                    controller: _OE3),
                HelpersViewLetrasSubs.formItemsDesign( "4) ¿Con quién vive usted?"),

                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.p04EspecificarCtrl,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.Paramp04EspecificarCtrl);
                            },
                            maxLength: 100,
                          ), context),

                    ]
                ),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "5) ¿Usted tiene amigos, familiares, vecinos a los que suele visitar?"),

                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.p05EspecificarCtrl,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.Paramp05EspecificarCtrl);
                            },
                            maxLength: 100,
                          ), context),

                    ]
                ),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "6) ¿Recibe ayuda en sus actividades diarias?"),

                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.p06EspecificarCtrl,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.Paramp06EspecificarCtrl);
                            },
                            maxLength: 100,
                          ), context),

                    ]
                ),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "7) ¿Cuál es su ingreso económico en su hogar?"),

                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.p07EspecificarCtrl,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.Paramp07EspecificarCtrl);
                            },
                            maxLength: 100,
                          ), context),

                    ]
                ),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "8) ¿Qué tipo de vivienda tiene?"),

                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.p08EspecificarCtrl,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.Paramp08EspecificarCtrl);
                            },
                            maxLength: 100,
                          ), context),

                    ]
                ),
                const SizedBox(height: 16.0),
                HelpersViewLetrasToolTip(message: "●	Orientar sobre las redes de apoyo social disponibles en la jurisdicción.",
                    controller: _OE4),
                HelpersViewLetrasSubs.formItemsDesign( "9) ¿Participa de alguna red de apoyo?"),

                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.p09EspecificarCtrl,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.Paramp09EspecificarCtrl);
                            },
                            maxLength: 100,
                          ), context),

                    ]
                ),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "9.1) Actualmente, ¿por qué no participa de alguna red de apoyo?"),

                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.p09P1EspecificarCtrl,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.Paramp09P1EspecificarCtrl);
                            },
                            maxLength: 100,
                          ), context),

                    ]
                ),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "9.2) ¿Está interesado de participar de alguna red de apoyo?"),

                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.p09P2EspecificarCtrl,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.Paramp09P2EspecificarCtrl);
                            },
                            maxLength: 100,
                          ), context),

                    ]
                ),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "10) ¿Ha identificado alguna situación de riesgo?"),

                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.p10EspecificarCtrl,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.Paramp10EspecificarCtrl);
                            },
                            maxLength: 100,
                          ), context),

                    ]
                ),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "10.1) ¿Es relacionado al cobro?"),

                Column(
                    children: <Widget>[
                      HelpersViewBlancoIcon.formItemsDesign(
                          Icons.pending_actions,
                          TextFormField(
                            controller: widget.p10P1EspecificarCtrl,
                            decoration: const InputDecoration(
                              labelText: '',
                            ),
                            validator: (value) {
                              return HelpersViewBlancoIcon.validateField(
                                  value!, widget.Paramp10P1EspecificarCtrl);
                            },
                            maxLength: 100,
                          ), context),

                    ]
                ),
                const SizedBox(height: 16.0),

                //BOTON PARA PRESEGUIR
                GestureDetector(
                    onTap: ()  async {

                      if(

                      (widget.p01EspecificarCtrl.text == null || widget.p01EspecificarCtrl.text.isEmpty) ||
                      (widget.p01P1EspecificarCtrl.text == null || widget.p01P1EspecificarCtrl.text.isEmpty) ||
                      (widget.p02EspecificarCtrl.text == null || widget.p02EspecificarCtrl.text.isEmpty) ||
                      (widget.p03EspecificarCtrl.text == null || widget.p03EspecificarCtrl.text.isEmpty) ||
                      (widget.p04EspecificarCtrl.text == null || widget.p04EspecificarCtrl.text.isEmpty) ||
                      (widget.p05EspecificarCtrl.text == null || widget.p05EspecificarCtrl.text.isEmpty) ||
                      (widget.p07EspecificarCtrl.text == null || widget.p07EspecificarCtrl.text.isEmpty) ||
                      (widget.p08EspecificarCtrl.text == null || widget.p08EspecificarCtrl.text.isEmpty) ||
                      (widget.p09EspecificarCtrl.text == null || widget.p09EspecificarCtrl.text.isEmpty) ||
                      (widget.p09P1EspecificarCtrl.text == null || widget.p09P1EspecificarCtrl.text.isEmpty) ||
                      (widget.p09P2EspecificarCtrl.text == null || widget.p09P2EspecificarCtrl.text.isEmpty) ||
                      (widget.p10EspecificarCtrl.text == null || widget.p10EspecificarCtrl.text.isEmpty) ||



                      (widget.p10P1EspecificarCtrl.text == null || widget.p10P1EspecificarCtrl.text.isEmpty)
                      ){
                        showDialogValidFields(Constants.faltanCampos);
                      } else {
                        await guardadoFase2();
                        setState(() {
                          Fase2 = false;
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
            visible: Fase3,
            child:Column(
              children: <Widget>[


                GestureDetector(
                    onTap: ()  async {
                      if( 1 == 2){
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


                //BOTON DE SUBIR
                GestureDetector(
                    onTap: ()  async {
                      if( 1 == 2
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

                GestureDetector(
                    onTap: ()  async {
                      if( 1 == 2
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
