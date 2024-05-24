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

  TextEditingController formP08EspecificarCtrl = TextEditingController();
  final ParamP08EspecificarCtrl = List.filled(3, "", growable: false);

  TextEditingController formP09EspecificarCtrl = TextEditingController();
  final ParamP09EspecificarCtrl = List.filled(3, "", growable: false);

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

          //GUARDAR FORMULARIO BOTON DISKETE
          IconButton(
            icon: Image.asset(Resources.guardar),
            color: Colors.white,
            onPressed: () async {
              if ( GPSlongitude != "") {
                if (
                    (_CobroPension == null) ||
                    (_Tiempomeses == null) ||
                    (_SeAtendio == null) ||
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
                    )  ||
                        (_PensionRecibe == null) ||
                        (_TipoEstablecimientoSalud == null) //||

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

                  if(isCheckedP04Alimentacion){rpstChecksTemp = "${rpstChecksTemp}Alimentacion,";}
                  if(isCheckedP04Salud){rpstChecksTemp = "${rpstChecksTemp}Salud,";}
                  if(isCheckedP04Limpieza){rpstChecksTemp = "${rpstChecksTemp}Limpieza,";}
                  if(isCheckedP04Rehabilitacion){rpstChecksTemp = "${rpstChecksTemp}Rehabilitacion,";}
                  if(isCheckedP04Educacion){rpstChecksTemp = "${rpstChecksTemp}Educacion,";}
                  if(isCheckedP04PagoServicio){rpstChecksTemp = "${rpstChecksTemp}PagoServicios,";}
                  if(isCheckedP04PagoComunicacion){rpstChecksTemp = "${rpstChecksTemp}PagoComunicacion,";}
                  if(isCheckedP04Transporte){rpstChecksTemp = "${rpstChecksTemp}Transporte,";}
                  if(isCheckedP04Vestimenta){rpstChecksTemp = "${rpstChecksTemp}Vestimenta,";}
                  if(isCheckedP04Recreacion){rpstChecksTemp = "${rpstChecksTemp}Recreacion,";}
                  if(isCheckedP04Ahorro){rpstChecksTemp = "${rpstChecksTemp}Ahorro,";}
                  if(isCheckedP04AhorroSalud){rpstChecksTemp = "${rpstChecksTemp}AhorroSalud,";}
                  if(isCheckedP04OtroGasto){rpstChecksTemp = "${rpstChecksTemp}OtroGasto,";}

                  if(isCheckedP03Distancia){rpstChecksTemp = "${rpstChecksTemp}Distancia,";}
                  if(isCheckedP03Acumular){rpstChecksTemp = "${rpstChecksTemp}Acumula,";}
                  if(isCheckedP03Noacompaniado){rpstChecksTemp = "${rpstChecksTemp}NoAcompaniado,";}
                  if(isCheckedP03Ahorrando){rpstChecksTemp = "${rpstChecksTemp}Ahorrando,";}
                  if(isCheckedP03DificultarTrasladar){rpstChecksTemp = "${rpstChecksTemp}DificultadTraslado,";}
                  if(isCheckedP03OtroEspecificar){rpstChecksTemp = "${rpstChecksTemp}Especificar:${widget.formP03EspecificarCtrl!.text},";}


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
                  widget.formData?.id_usuario = int.parse(PREFnroDoc!);
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
    widget.formP03EspecificarCtrl!.clear();
    widget.ParamP08EspecificarCtrl!.clear();
    widget.formPensionTiempoCtrl!.clear(); //6
    widget.formNecesidadesCtrl!.clear(); //7
    widget.formEstablecimientoSaludCtrl!.clear(); //8
    widget.formSeAtendioCtrl!.clear(); //9
    widget.formServicioAtencionCtrl!.clear(); //10
    widget.formData = Respuesta();//


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
      isCheckedP03Distancia = false;
      isCheckedP03Acumular = false;
      isCheckedP03Noacompaniado = false;
      isCheckedP03Ahorrando = false;
      isCheckedP03DificultarTrasladar = false;
      isCheckedP03OtroEspecificar = false;

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
                              visible: isCheckedP08Otros,
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


                HelpersViewLetrasSubs.formItemsDesign( "¿CON QUIÉN VIVE USTED? *"),
                HelpersViewLetrasSubs.formItemsDesign( "¿USTED TIENE AMIGOS, FAMILIARES, VECINOS A LOS QUE SUELE VISITAR? *"),

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
                      (widget.formP08EspecificarCtrl == null || widget.formP08EspecificarCtrl!.text.isEmpty)
                      //SI MARCO SI
                      )

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

                HelpersViewLetrasRojas.formItemsDesign( "Presione el diskete y envie (sino funciona presione primero el satelite"),
                const SizedBox(height: 16.0),

              ],),
          ),



        ],),
    );
  }
}
