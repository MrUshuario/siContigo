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
  //COOBROPENSION//CIRCLE 4
  //tiempomeses //CIRCLE 5
  TextEditingController formPensionTiempoCtrl = TextEditingController(); //CHECK 6 CAMBIA
  TextEditingController formNecesidadesCtrl = TextEditingController(); //CIRCLE 7
  TextEditingController formEstablecimientoSaludCtrl = TextEditingController(); //CIRCLE 8
  TextEditingController formSeAtendioCtrl = TextEditingController(); //CIRCLE 9
  TextEditingController formServicioAtencionCtrl = TextEditingController(); //CHECK 10 CAMBIA
  //SIGUIENTE

  final ParamGestor = List.filled(3, "", growable: false);

  List<String> listMotivo = [
    "Seleccionar un gestor social",
    "RITTA JACQUELINE ORREGO HUAMAN",
    "ROBERT SEMION CANAZA VEGA",
    "ELVIS CLAUDIO GARCIA BELLO",
    "ELDER JAIME CASTREJON RIOS",
  ];

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
enum TipoEstablecimientoSalud {sis, essalud, policiales, privado, ninguno, nosabe}
enum SeAtendio { Si, No }




class _MenudeOpcionesOffline extends State<MenudeOpcionesOffline> {

  late String PREFname;
  late String PREFapPaterno;
  late String PREFapMaterno;
  late String PREFnroDoc;
  late String PREFtypeUser;
  late String PREFtoken;

  late String GPSlatitude = "";
  late String GPSlongitude = "";
  late String GPSaltitude = "";

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
  SeAtendio? _SeAtendio;
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

  //OCULTAR PREGUNTAS
  bool PregCada3meses = false;
  bool PregCada2meses = false;

  //2 meses oculto
  bool isCheckedAlimentacion = false;
  bool isCheckedSalud = false;
  bool isCheckedLimpieza = false;
  bool isCheckedRehabilitacion = false;
  bool isCheckedEducacion = false;
  bool isCheckedPagoServicio = false;
  bool isCheckedPagoComunicacion = false;
  bool isCheckedTransporte = false;
  bool isCheckedVestimenta = false;
  bool isCheckedRecreacion = false;
  bool isCheckedAhorro = false;
  bool isCheckedAhorroSalud = false;
  bool isCheckedOtroGasto = false;
  //3 meses oculto
  bool isCheckedDistancia = false;
  bool isCheckedAcumular = false;
  bool isCheckedNoacompaniado = false;
  bool isCheckedAhorrando = false;
  bool isCheckedDificultarTrasladar = false;
  bool isCheckedOtroEspecificar = false;

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
  void CargaDialog() {
    bool mostrarLOADING = true;
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

            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    HelpersViewAlertProgressCircle(
                      mostrar: mostrarLOADING,
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

          IconButton(
            icon: Image.asset(Resources.guardar),
            color: Colors.white,
            onPressed: () async {


              if ( GPSlongitude != "") {



                if (
                    (_CobroPension == null) ||
                    (_Tiempomeses == null) ||
                    (_PensionRecibe == null) ||
                    (_TipoEstablecimientoSalud == null) ||
                    (_SeAtendio == null) ||

                    (//CADA 2 meses lamenos uno marcado
                        !isCheckedAlimentacion &&
                            !isCheckedSalud &&
                            !isCheckedLimpieza &&
                            !isCheckedRehabilitacion &&
                            !isCheckedEducacion &&
                            !isCheckedPagoServicio &&
                            !isCheckedPagoComunicacion &&
                            !isCheckedTransporte &&
                            !isCheckedVestimenta &&
                            !isCheckedRecreacion &&
                            !isCheckedAhorro &&
                            !isCheckedAhorroSalud &&
                            !isCheckedOtroGasto &&
                            //CADA 3 meses lamenos uno marcado
                            !isCheckedDistancia  &&
                            !isCheckedAcumular  &&
                            !isCheckedNoacompaniado  &&
                            !isCheckedAhorrando  &&
                            !isCheckedDificultarTrasladar  &&
                            !isCheckedOtroEspecificar
                    )

                //(widget.formPensionTiempoCtrl!.text == "" ||widget.formPensionTiempoCtrl!.text.isEmpty) ||
                    //(widget.formNecesidadesCtrl!.text == "" ||widget.formNecesidadesCtrl!.text.isEmpty) ||
                    //(widget.formEstablecimientoSaludCtrl!.text == "" ||widget.formEstablecimientoSaludCtrl!.text.isEmpty) ||
                    //(widget.formSeAtendioCtrl!.text == "" ||widget.formSeAtendioCtrl!.text.isEmpty) ||
                    //(widget.formServicioAtencionCtrl!.text == "" ||widget.formServicioAtencionCtrl!.text.isEmpty)

                ) {

                  HelpersViewAlertMensajeFaltaMSG.formItemsDesign("Faltan llenar campos", context);

                } else {
                  CargaDialog(); //INICIALIZA DIALOGO

                  String respuestas = "";

                  String rpstChecksTemp = "";

                  if(isCheckedAlimentacion){rpstChecksTemp = "${rpstChecksTemp}Alimentacion,";}
                  if(isCheckedSalud){rpstChecksTemp = "${rpstChecksTemp}Salud,";}
                  if(isCheckedLimpieza){rpstChecksTemp = "${rpstChecksTemp}Limpieza,";}
                  if(isCheckedRehabilitacion){rpstChecksTemp = "${rpstChecksTemp}Rehabilitacion,";}
                  if(isCheckedEducacion){rpstChecksTemp = "${rpstChecksTemp}Educacion,";}
                  if(isCheckedPagoServicio){rpstChecksTemp = "${rpstChecksTemp}PagoServicios,";}
                  if(isCheckedPagoComunicacion){rpstChecksTemp = "${rpstChecksTemp}PagoComunicacion,";}
                  if(isCheckedTransporte){rpstChecksTemp = "${rpstChecksTemp}Transporte,";}
                  if(isCheckedVestimenta){rpstChecksTemp = "${rpstChecksTemp}Vestimenta,";}
                  if(isCheckedRecreacion){rpstChecksTemp = "${rpstChecksTemp}Recreacion,";}
                  if(isCheckedAhorro){rpstChecksTemp = "${rpstChecksTemp}Ahorro,";}
                  if(isCheckedAhorroSalud){rpstChecksTemp = "${rpstChecksTemp}AhorroSalud,";}
                  if(isCheckedOtroGasto){rpstChecksTemp = "${rpstChecksTemp}OtroGasto,";}

                  if(isCheckedDistancia){rpstChecksTemp = "${rpstChecksTemp}Distancia,";}
                  if(isCheckedAcumular){rpstChecksTemp = "${rpstChecksTemp}Acumula,";}
                  if(isCheckedNoacompaniado){rpstChecksTemp = "${rpstChecksTemp}NoAcompaniado,";}
                  if(isCheckedAhorrando){rpstChecksTemp = "${rpstChecksTemp}Ahorrando,";}
                  if(isCheckedDificultarTrasladar){rpstChecksTemp = "${rpstChecksTemp}DificultadTraslado,";}
                  if(isCheckedOtroEspecificar){rpstChecksTemp = "${rpstChecksTemp}Especificar,";}


                  respuestas = ''
                      'Cobro:$_CobroPension,'
                      'TiempoPension:$_Tiempomeses,'
                      'checks($rpstChecksTemp),'
                      'PensionRecibe:$_PensionRecibe,'
                      'TipoEstablecimientoSalud:$_TipoEstablecimientoSalud ,'
                      'Nombre:$PREFname,'
                      'Appaterno:$PREFapPaterno,'
                      'MatMaterno:$PREFapMaterno,'
                      'DNI:$PREFnroDoc,'
                      'TipoUsuario:$PREFtypeUser,'
                  ;

                  //RELLENANDO
                  widget.formData?.idformato = apisResources.api_idFormato;
                  widget.formData?.id_usuario = int.parse(PREFnroDoc);
                  widget.formData?.fecha = formatDate("dd/MM/yyyy hh:mm:ss", DateTime.now());
                  widget.formData?.respuestas = respuestas;
                  widget.formData?.longitud = GPSlongitude;
                  widget.formData?.latitud = GPSlatitude;
                  //GPSlatitude

                  //YA NO ENVIA AHORA GUARDA
                  //insertarEncuestaRSPTA rpta = await widget.apiForm.post_EnviarRspt(widget.formData!, PREFtoken);

                  //await GuardarFormulario();

                  await widget.formDataModelDao.insertFormDataModel(widget.formData!);
                  cleanForm();
                  _mostrarLoadingStreamController.add(true);

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
    widget.formPensionTiempoCtrl!.clear(); //6
    widget.formNecesidadesCtrl!.clear(); //7
    widget.formEstablecimientoSaludCtrl!.clear(); //8
    widget.formSeAtendioCtrl!.clear(); //9
    widget.formServicioAtencionCtrl!.clear(); //10
    widget.formData = Respuesta();

    setState(() {
      Fase1 = true;
      Fase2 = false;
      Fase3 = false;
      Fase4 = false;
      Fase5 = false;
      //
      _CobroPension = null;
      _Tiempomeses = null;
      //OCULTAR PREGUNTAS
      PregCada3meses = false;
      PregCada2meses = false;
      //CHECKS
      isCheckedAlimentacion = false;
      isCheckedSalud = false;
      isCheckedLimpieza = false;
      isCheckedRehabilitacion = false;
      isCheckedEducacion = false;
      isCheckedPagoServicio = false;
      isCheckedPagoComunicacion = false;
      isCheckedTransporte = false;
      isCheckedVestimenta = false;
      isCheckedRecreacion = false;
      isCheckedAhorro = false;
      isCheckedAhorroSalud = false;
      isCheckedOtroGasto = false;
      isCheckedDistancia = false;
      isCheckedAcumular = false;
      isCheckedNoacompaniado = false;
      isCheckedAhorrando = false;
      isCheckedDificultarTrasladar = false;
      isCheckedOtroEspecificar = false;

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

          /*
           //LISTA MOTIVOS
          HelpersViewBlancoSelect.formItemsDesign(
              DropdownButtonFormField(
                  items: widget.listMotivo.map((dep) {
                    return DropdownMenuItem(
                      value: dep,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          dep,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) async {

                    if(value == "Seleccionar un gestor social") {
                      widget.formGestorSocialCtrl.text = "";
                    } else {
                      widget.formGestorSocialCtrl.text = value!.isEmpty || value == null ? "" : value!;
                    }
                  },
                  validator: (value) => HelpersViewBlancoIcon.validateField(
                      widget.formGestorSocialCtrl.text!,
                      widget.ParamGestor),
                  isDense: true,
                  isExpanded: true,
                  //hint: const Text("Seleccione un motivo de Visita"),
                  value: widget.listMotivo.elementAt(widget.listMotivo.indexOf(widget.formGestorSocialCtrl.text) == -1 ? 0 : widget.listMotivo.indexOf(widget.formGestorSocialCtrl.text))
              )
          ),
           */

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
                      child: const Text("Iniciar con el formulario",
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

                HelpersViewLetrasRojas.formItemsDesign( "Cobro de Pensión (* Obligatorio)"),
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
                          isCheckedDistancia = false;
                          isCheckedAcumular = false;
                          isCheckedNoacompaniado = false;
                          isCheckedAhorrando = false;
                          isCheckedDificultarTrasladar = false;
                          isCheckedOtroEspecificar = false;


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
                          isCheckedAlimentacion = false;
                          isCheckedSalud = false;
                          isCheckedLimpieza = false;
                          isCheckedRehabilitacion = false;
                          isCheckedEducacion = false;
                          isCheckedPagoServicio = false;
                          isCheckedPagoComunicacion = false;
                          isCheckedTransporte = false;
                          isCheckedVestimenta = false;
                          isCheckedRecreacion = false;
                          isCheckedAhorro = false;
                          isCheckedAhorroSalud = false;
                          isCheckedOtroGasto = false;
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
                          value: isCheckedAlimentacion,
                          onChanged: (bool? value) {
                            setState(() {
                              isCheckedAlimentacion = value!;
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
                              value: isCheckedSalud,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedSalud = value!;
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
                              value: isCheckedLimpieza,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedLimpieza = value!;
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
                              value: isCheckedRehabilitacion,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedRehabilitacion = value!;
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
                              value: isCheckedEducacion,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedEducacion = value!;
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
                              value: isCheckedPagoServicio,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedPagoServicio = value!;
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
                              value: isCheckedPagoComunicacion,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedPagoComunicacion = value!;
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
                              value: isCheckedTransporte,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedTransporte = value!;
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
                              value: isCheckedVestimenta,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedVestimenta = value!;
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
                              value: isCheckedRecreacion,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedRecreacion = value!;
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
                              value: isCheckedAhorro,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedAhorro = value!;
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
                              value: isCheckedAhorroSalud,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedAhorroSalud = value!;
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
                              value: isCheckedOtroGasto,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedOtroGasto = value!;
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
                              value: isCheckedDistancia,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedDistancia = value!;
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
                              value: isCheckedAcumular,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedAcumular = value!;
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
                              value: isCheckedAhorrando,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedAhorrando = value!;
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
                              value: isCheckedNoacompaniado,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedNoacompaniado = value!;
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
                              value: isCheckedDificultarTrasladar,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedDificultarTrasladar = value!;
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
                              value: isCheckedOtroEspecificar,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedOtroEspecificar = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),


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
                        });
                      },),],
                ),

                const SizedBox(height: 16.0),

                //BOTON PARA PRESEGUIR

                GestureDetector(
                    onTap: ()  {

                      if(
                      (_CobroPension == null) ||
                      (_Tiempomeses == null) ||
                      (_PensionRecibe == null) ||
                      (_TipoEstablecimientoSalud == null) ||
                      (_SeAtendio == null) ||
                      (//CADA 2 meses lamenos uno marcado
                          !isCheckedAlimentacion &&
                          !isCheckedSalud &&
                          !isCheckedLimpieza &&
                          !isCheckedRehabilitacion &&
                          !isCheckedEducacion &&
                          !isCheckedPagoServicio &&
                          !isCheckedPagoComunicacion &&
                          !isCheckedTransporte &&
                          !isCheckedVestimenta &&
                          !isCheckedRecreacion &&
                          !isCheckedAhorro &&
                          !isCheckedAhorroSalud &&
                          !isCheckedOtroGasto &&
                        //CADA 3 meses lamenos uno marcado
                          !isCheckedDistancia  &&
                          !isCheckedAcumular  &&
                          !isCheckedNoacompaniado  &&
                          !isCheckedAhorrando  &&
                          !isCheckedDificultarTrasladar  &&
                          !isCheckedOtroEspecificar
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




                HelpersViewLetrasRojas.formItemsDesign( "VALORACION SOCIO FAMILIAR - OBSERVACION DEL GESTOR"),
                const SizedBox(height: 16.0),

                HelpersViewLetrasSubs.formItemsDesign( "¿CON QUIÉN VIVE USTED? *"),
                HelpersViewLetrasSubs.formItemsDesign( "¿USTED TIENE AMIGOS, FAMILIARES, VECINOS A LOS QUE SUELE VISITAR? *"),

                GestureDetector(
                    onTap: ()  {
                      if(
                      (_CobroPension == null) ||
                      (_Tiempomeses == null) //||
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

                HelpersViewLetrasSubs.formItemsDesign( "¿CON QUIÉN VIVE USTED? *"),
                HelpersViewLetrasSubs.formItemsDesign( "¿USTED TIENE AMIGOS, FAMILIARES, VECINOS A LOS QUE SUELE VISITAR? *"),

                GestureDetector(
                    onTap: ()  {
                      if(
                      (_CobroPension == null) ||
                          (_Tiempomeses == null) //||
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

                HelpersViewLetrasRojas.formItemsDesign( "Presione el diskete y envie (sino funciona presione primero el satelite"),
                const SizedBox(height: 16.0),

              ],),
          ),



        ],),
    );
  }
}
